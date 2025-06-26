import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/RegistroMedico.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/services/RegistroService.dart';
import 'package:flutter_application_1/widgets/custom/DataPickerFormField.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/utils/GeneralValidator.dart';

class RegisterMedicoPage extends StatefulWidget {
  const RegisterMedicoPage({super.key});

  @override
  State<RegisterMedicoPage> createState() => _RegisterMedicoPageState();
}

class _RegisterMedicoPageState extends State<RegisterMedicoPage> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _fechaNacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _consultorioController = TextEditingController();
  final _matriculaController = TextEditingController();
  int? _especialidadId;

  bool _isLoading = false;
  String _sexoSeleccionado = 'M';

  @override
  void initState() {
    super.initState();
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: theme.colorScheme.surface,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final registro = RegistroMedico(
      nombre: _nombreController.text.trim(),
      apellido: _apellidoController.text.trim(),
      dni: _dniController.text.trim(),
      sexo: _sexoSeleccionado,
      fechaNac: _fechaNacController.text.trim(),
      telefono: _telefonoController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      matricula: _matriculaController.text.trim(),
      consultorio: _consultorioController.text.trim(),
      especialidad_id: _especialidadId!,
    );

    final servicio = RegistroService();
    final result = await servicio.registrarMedico(registro);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'])),
    );

    if (result['ok']) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alta de cuenta Médico'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text('Registrar cuenta de médico',
                  style: theme.textTheme.headlineSmall),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nombreController,
                decoration: _inputDecoration('Nombres', Icons.person),
                validator: GeneralValidator.campoRequerido,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _apellidoController,
                decoration: _inputDecoration('Apellido', Icons.person),
                validator: GeneralValidator.campoRequerido,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dniController,
                decoration: _inputDecoration('DNI', Icons.badge),
                validator: GeneralValidator.validarDNI,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sexoSeleccionado,
                decoration: _inputDecoration('Sexo', Icons.wc),
                items: const [
                  DropdownMenuItem(value: 'F', child: Text('Femenino')),
                  DropdownMenuItem(value: 'M', child: Text('Masculino')),
                ],
                onChanged: (val) => setState(() => _sexoSeleccionado = val!),
                validator: GeneralValidator.validarDropdown,
              ),
              const SizedBox(height: 16),
              DatePickerFormField(
                controller: _fechaNacController,
                label: 'Fecha de nacimiento',
                icon: Icons.calendar_today,
                validator: GeneralValidator.validarFecha,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: _inputDecoration('Teléfono', Icons.phone),
                validator: GeneralValidator.validarTelefono,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration('Correo electrónico', Icons.email),
                validator: GeneralValidator.validarEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: _inputDecoration('Contraseña', Icons.lock),
                obscureText: true,
                validator: GeneralValidator.validarPassword,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _matriculaController,
                decoration:
                    _inputDecoration('Matrícula médica', Icons.assignment_ind),
                validator: GeneralValidator.campoRequerido,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _consultorioController,
                decoration:
                    _inputDecoration('Consultorio', Icons.assignment_ind),
                validator: GeneralValidator.campoRequerido,
              ),
              const SizedBox(height: 16),
              FutureFetcher(
                url: ApiConfig.especialidadesMedico(),
                widget: (json) {
                  final especialidades =
                      List<Map<String, dynamic>>.from(json['data']);

                  return DropdownButtonFormField<int>(
                    value: _especialidadId,
                    decoration: _inputDecoration(
                        'Especialidad', Icons.medical_services),
                    items: especialidades.map((esp) {
                      return DropdownMenuItem<int>(
                        value: esp['id'],
                        child: Text(esp['nombre']),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _especialidadId = val),
                    validator: (val) =>
                        GeneralValidator.validarDropdownEspecialidad(val),
                  );
                },
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _register,
                        icon: const Icon(Icons.person_add),
                        label: const Text('Registrarse'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
