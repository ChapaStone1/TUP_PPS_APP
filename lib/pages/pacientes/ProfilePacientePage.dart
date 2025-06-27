import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/widgets/custom/DataPickerFormField.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/utils/GeneralValidator.dart';
import 'package:flutter_application_1/widgets/custom/FutureUpdater.dart';
import 'package:provider/provider.dart';

class ProfilePacientePage extends StatelessWidget {
  const ProfilePacientePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Editar perfil'),
        elevation: 10,
      ),
      body: FutureFetcher(
        url: ApiConfig.perfilPaciente(),
        widget: (json) => BodyProfilePaciente(data: json['data']),
      ),
    );
  }
}

class BodyProfilePaciente extends StatefulWidget {
  final Map<String, dynamic> data;

  const BodyProfilePaciente({super.key, required this.data});

  @override
  State<BodyProfilePaciente> createState() => _BodyProfilePacienteState();
}

class _BodyProfilePacienteState extends State<BodyProfilePaciente> {
  final _formKey = GlobalKey<FormState>();

  bool darkMode = false;
  bool showPassword = false;

  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _dniController;
  String? _sexoSeleccionado;
  late TextEditingController _fechaNacController;
  late TextEditingController _telefonoController;
  late TextEditingController _emailController;
  late TextEditingController _obraSocialController;
  late TextEditingController _passwordController;
  String? _grupoSanguineoSeleccionado;

  final List<String> grupoSanguineoOpciones = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  void initState() {
    super.initState();
    final d = widget.data;

    darkMode = Preferences.darkmode;
    _nombreController = TextEditingController(text: d['nombre'] ?? '');
    _apellidoController = TextEditingController(text: d['apellido'] ?? '');
    _dniController = TextEditingController(text: d['dni'] ?? '');
    _sexoSeleccionado = d['sexo'] ?? '';
    _fechaNacController = TextEditingController(text: d['fecha_nac'] ?? '');
    _telefonoController =
        TextEditingController(text: d['telefono']?.toString() ?? '');
    _emailController = TextEditingController(text: d['email'] ?? '');
    _grupoSanguineoSeleccionado = d['grupo_sanguineo'];
    _obraSocialController = TextEditingController(text: d['obra_social'] ?? '');
    _passwordController = TextEditingController();
  }

  void updatePerfilConFutureUpdater() {
    if (!_formKey.currentState!.validate()) return;

    final body = {
      'nombre': _nombreController.text.trim(),
      'apellido': _apellidoController.text.trim(),
      'dni': _dniController.text.trim(),
      'sexo': _sexoSeleccionado ?? '',
      'fecha_nac': _fechaNacController.text.trim(),
      'telefono': _telefonoController.text.trim(),
      'email': _emailController.text.trim(),
      'grupo_sanguineo': _grupoSanguineoSeleccionado ?? '',
      'obra_social': _obraSocialController.text.trim(),
      'password': _passwordController.text.trim(),
    };

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Actualizando perfil'),
        content: SizedBox(
          height: 100,
          child: FutureUpdater(
            url: ApiConfig.perfilPaciente(),
            body: body,
            widget: (json) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(json['message'] ?? 'Perfil actualizado')),
                );
              });
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<ThemeProvider>(context, listen: false);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile.adaptive(
              title: const Text('Dark Mode'),
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  Preferences.darkmode = value;
                  value ? temaProvider.setDark() : temaProvider.setLight();
                  darkMode = value;
                });
              },
            ),
            const SizedBox(height: 20),
            buildTextFormField('Nombre', _nombreController, Icons.person,
                validator: GeneralValidator.campoRequerido),
            buildTextFormField('Apellido', _apellidoController, Icons.person,
                validator: GeneralValidator.campoRequerido),
            buildTextFormField('DNI', _dniController, Icons.badge,
                validator: GeneralValidator.validarDNI,
                isNumber: true,
                readOnly: true),
            buildDropdownSexo(),
            DatePickerFormField(
              controller: _fechaNacController,
              label: 'Fecha de nacimiento',
              icon: Icons.calendar_today,
              validator: GeneralValidator.validarFecha,
            ),
            buildTextFormField('Teléfono', _telefonoController, Icons.phone,
                isNumber: true, validator: GeneralValidator.validarTelefono),
            buildTextFormField('Email', _emailController, Icons.email,
                validator: GeneralValidator.validarEmail),
            buildDropdownGrupoSanguineo(),
            buildTextFormField(
                'Obra Social', _obraSocialController, Icons.local_hospital,
                validator: GeneralValidator.campoRequerido),
            buildTextFormField(
              'Contraseña',
              _passwordController,
              Icons.lock,
              obscureText: !showPassword,
              suffixIcon: IconButton(
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () => setState(() => showPassword = !showPassword),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) return null;
                return GeneralValidator.validarPassword(val);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: updatePerfilConFutureUpdater,
              icon: const Icon(Icons.save),
              label: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownSexo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: _sexoSeleccionado,
        decoration: InputDecoration(
          labelText: 'Sexo',
          prefixIcon: const Icon(Icons.wc),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: const [
          DropdownMenuItem(value: 'F', child: Text('Femenino')),
          DropdownMenuItem(value: 'M', child: Text('Masculino')),
        ],
        onChanged: (value) => setState(() => _sexoSeleccionado = value),
        validator: GeneralValidator.validarDropdown,
      ),
    );
  }

  Widget buildDropdownGrupoSanguineo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: _grupoSanguineoSeleccionado,
        decoration: InputDecoration(
          labelText: 'Grupo Sanguíneo',
          prefixIcon: const Icon(Icons.bloodtype),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: grupoSanguineoOpciones
            .map((gs) => DropdownMenuItem(value: gs, child: Text(gs)))
            .toList(),
        onChanged: (value) =>
            setState(() => _grupoSanguineoSeleccionado = value),
        validator: GeneralValidator.validarDropdown,
      ),
    );
  }

  Widget buildTextFormField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isNumber = false,
    bool obscureText = false,
    bool readOnly = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        obscureText: obscureText,
        readOnly: readOnly,
        style: const TextStyle(fontSize: 18),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: validator,
      ),
    );
  }
}
