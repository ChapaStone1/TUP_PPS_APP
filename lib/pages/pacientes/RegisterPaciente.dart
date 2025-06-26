// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/RegistroPaciente.dart';
import 'package:flutter_application_1/services/RegistroService.dart';
import 'package:flutter_application_1/utils/GeneralValidator.dart'; // <-- Importado

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  String? _sexoSeleccionado;
  final _fechaNacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _grupoSanguineoSeleccionado;
  final _obraSocialController = TextEditingController();

  bool _isLoading = false;

  InputDecoration _inputDecoration(String label, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: colorScheme.onSurface),
      prefixIcon: Icon(icon, color: colorScheme.onSurface),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: colorScheme.surface,
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final registro = RegistroPaciente(
      nombre: _nombreController.text.trim(),
      apellido: _apellidoController.text.trim(),
      dni: _dniController.text.trim(),
      sexo: _sexoSeleccionado ?? '',
      fechaNac: _fechaNacController.text.trim(),
      telefono: _telefonoController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      grupoSanguineo: _grupoSanguineoSeleccionado ?? '',
      obraSocial: _obraSocialController.text.trim(),
    );

    final servicio = RegistroService();
    final result = await servicio.registrarPaciente(registro);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result['message']),
    ));

    if (result['ok']) {
      Navigator.pushReplacementNamed(context, '/login');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarse'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                'Crear cuenta de paciente',
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nombreController,
                decoration: _inputDecoration('Nombre completo', Icons.person),
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
                  DropdownMenuItem(value: 'M', child: Text('Masculino')),
                  DropdownMenuItem(value: 'F', child: Text('Femenino')),
                ],
                onChanged: (value) {
                  setState(() {
                    _sexoSeleccionado = value;
                  });
                },
                validator: GeneralValidator.validarDropdown,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fechaNacController,
                decoration: _inputDecoration(
                    'Fecha de nacimiento (YYYY-MM-DD)', Icons.calendar_today),
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
              DropdownButtonFormField<String>(
                value: _grupoSanguineoSeleccionado,
                decoration:
                    _inputDecoration('Grupo sanguíneo', Icons.bloodtype),
                items: const [
                  DropdownMenuItem(value: 'A+', child: Text('A+')),
                  DropdownMenuItem(value: 'A-', child: Text('A-')),
                  DropdownMenuItem(value: 'B+', child: Text('B+')),
                  DropdownMenuItem(value: 'B-', child: Text('B-')),
                  DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                  DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                  DropdownMenuItem(value: 'O+', child: Text('O+')),
                  DropdownMenuItem(value: 'O-', child: Text('O-')),
                ],
                onChanged: (value) {
                  setState(() {
                    _grupoSanguineoSeleccionado = value;
                  });
                },
                validator: GeneralValidator.validarDropdown,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _obraSocialController,
                decoration:
                    _inputDecoration('Obra social', Icons.local_hospital),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _register,
                        icon: const Icon(Icons.person_add, color: Colors.white),
                        label: const Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 5, 77, 136),
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
