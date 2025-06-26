import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Medico.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/utils/GeneralValidator.dart'; // Importa GeneralValidator
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileMedicoPage extends StatelessWidget {
  const ProfileMedicoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Editar perfil'),
        elevation: 10,
      ),
      body: FutureFetcher(
        url: 'https://tup-pps-api.onrender.com/api/medicos/mi-perfil',
        widget: (json) => FutureFetcher(
          url: 'https://tup-pps-api.onrender.com/api/medicos/especialidades',
          widget: (espJson) => BodyProfile(
            medico: Medico.fromJson(json['data']),
            especialidades: List<Map<String, dynamic>>.from(espJson['data']),
          ),
        ),
      ),
    );
  }
}

class BodyProfile extends StatefulWidget {
  final Medico medico;
  final List<Map<String, dynamic>> especialidades;

  const BodyProfile(
      {super.key, required this.medico, required this.especialidades});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  final _formKey = GlobalKey<FormState>();

  bool darkMode = false;
  bool showPassword = false;

  late TextEditingController _nombreController;
  late TextEditingController _apellidoController;
  late TextEditingController _sexoController;
  late TextEditingController _dniController;
  late TextEditingController _fechaNacController;
  late TextEditingController _telefonoController;
  late TextEditingController _emailController;
  late TextEditingController _matriculaController;
  late TextEditingController _consultorioController;
  final _passwordController = TextEditingController();

  int? especialidadId;

  @override
  void initState() {
    super.initState();
    darkMode = Preferences.darkmode;
    final m = widget.medico;
    _nombreController = TextEditingController(text: m.nombre);
    _apellidoController = TextEditingController(text: m.apellido);
    _sexoController = TextEditingController(text: m.sexo);
    _dniController = TextEditingController(text: m.dni);
    _fechaNacController = TextEditingController(text: m.fechaNac);
    _telefonoController = TextEditingController(text: m.telefono.toString());
    _emailController = TextEditingController(text: m.email);
    _matriculaController = TextEditingController(text: m.matricula);
    _consultorioController = TextEditingController(text: m.consultorio);
    especialidadId = m.especialidadId;
  }

  Future<void> updatePerfil() async {
    if (!_formKey.currentState!.validate()) return;

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return;

    final url =
        Uri.parse('https://tup-pps-api.onrender.com/api/medicos/mi-perfil');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final medicoActualizado = Medico(
      nombre: _nombreController.text.trim(),
      apellido: _apellidoController.text.trim(),
      sexo: _sexoController.text.trim(),
      fechaNac: _fechaNacController.text.trim(),
      dni: _dniController.text.trim(),
      telefono: _telefonoController.text.trim(),
      email: _emailController.text.trim(),
      matricula: _matriculaController.text.trim(),
      consultorio: _consultorioController.text.trim(),
      especialidadId: especialidadId,
    );

    final bodyMap = medicoActualizado.toJson();
    final passwordText = _passwordController.text.trim();
    if (passwordText.isNotEmpty) {
      bodyMap['password'] = passwordText;
    }
    final body = jsonEncode(bodyMap);

    final response = await http.put(url, headers: headers, body: body);

    final json = jsonDecode(response.body);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(json['message'] ?? 'Perfil actualizado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<ThemeProvider>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SwitchListTile.adaptive(
                title: const Text('Dark Mode'),
                value: darkMode,
                onChanged: (bool value) {
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
                  validator: GeneralValidator.validarDNI, isNumber: true),
              buildTextFormField('Sexo', _sexoController, Icons.wc,
                  validator: GeneralValidator.validarDropdown),
              buildTextFormField('Fecha de nacimiento', _fechaNacController,
                  Icons.calendar_today,
                  validator: GeneralValidator.validarFecha),
              buildTextFormField('Teléfono', _telefonoController, Icons.phone,
                  validator: GeneralValidator.validarTelefono, isNumber: true),
              buildTextFormField('Email', _emailController, Icons.email,
                  validator: GeneralValidator.validarEmail),
              buildTextFormField(
                  'Matrícula', _matriculaController, Icons.assignment_ind,
                  validator: GeneralValidator.campoRequerido),
              buildTextFormField(
                  'Consultorio', _consultorioController, Icons.assignment_ind,
                  validator: GeneralValidator.campoRequerido),
              buildEspecialidadDropdown(),
              buildTextFormField(
                'Password',
                _passwordController,
                Icons.lock,
                obscureText: !showPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                validator: (val) {
                  // La contraseña solo valida si no está vacía (opcional en update)
                  if (val == null || val.isEmpty) return null;
                  return GeneralValidator.validarPassword(val);
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: updatePerfil,
                icon: const Icon(Icons.save),
                label: const Text('Guardar cambios'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEspecialidadDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<int>(
        value: especialidadId,
        onChanged: (int? newValue) => setState(() => especialidadId = newValue),
        decoration: InputDecoration(
          labelText: 'Especialidad',
          prefixIcon: const Icon(Icons.local_hospital),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: widget.especialidades.map((esp) {
          return DropdownMenuItem<int>(
            value: esp['id'],
            child: Text(esp['nombre']),
          );
        }).toList(),
        validator: GeneralValidator.validarDropdownEspecialidad,
      ),
    );
  }

  Widget buildTextFormField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isNumber = false,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        obscureText: obscureText,
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
