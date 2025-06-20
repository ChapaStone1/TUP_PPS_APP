import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/RegistroMedico.dart';
import 'package:flutter_application_1/services/registro_service.dart';

class RegisterMedicoPage extends StatefulWidget {
  const RegisterMedicoPage({super.key});

  @override
  State<RegisterMedicoPage> createState() => _RegisterMedicoPageState();
}

class _RegisterMedicoPageState extends State<RegisterMedicoPage> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _dniController = TextEditingController();
  // ignore: unused_field
  final _sexoController = TextEditingController();
  final _fechaNacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _matriculaController = TextEditingController();
  int? _especialidadId;

  bool _isLoading = false;
  String _sexoSeleccionado = 'M';

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white24),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.grey[900],
    );
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final registro = RegistroMedico(
      nombre: _nombreController.text.trim(),
      dni: _dniController.text.trim(),
      sexo: _sexoSeleccionado,
      fechaNac: _fechaNacController.text.trim(),
      telefono: _telefonoController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      matricula: _matriculaController.text.trim(),
      especialidad: _especialidadId!.toInt(),
    );

    final servicio = RegistroService();
    final result =
        await servicio.registrarMedico(registro); // Método específico

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['message'])),
    );

    if (result['ok']) {
      Navigator.pushReplacementNamed(context, '/login');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Registro de médico'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text('Crear cuenta médica',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nombreController,
                decoration: _inputDecoration('Nombre completo', Icons.person),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dniController,
                decoration: _inputDecoration('DNI', Icons.badge),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _sexoSeleccionado,
                decoration: _inputDecoration('Sexo', Icons.wc),
                items: ['M', 'F']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (val) => setState(() => _sexoSeleccionado = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _fechaNacController,
                decoration: _inputDecoration(
                    'Fecha de nacimiento (YYYY-MM-DD)', Icons.calendar_today),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                decoration: _inputDecoration('Teléfono', Icons.phone),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration('Correo electrónico', Icons.email),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (!v.contains('@')) return 'Correo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: _inputDecoration('Contraseña', Icons.lock),
                obscureText: true,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _matriculaController,
                decoration:
                    _inputDecoration('Matrícula médica', Icons.assignment_ind),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _especialidadId,
                decoration:
                    _inputDecoration('Especialidad', Icons.medical_services),
                items: [
                  DropdownMenuItem(value: 1, child: Text('Clínico')),
                  DropdownMenuItem(value: 2, child: Text('Pediatra')),
                  DropdownMenuItem(value: 3, child: Text('Cardiólogo')),
                  // Agregá más según tu backend
                ],
                onChanged: (val) => setState(() => _especialidadId = val),
                validator: (val) =>
                    val == null ? 'Seleccioná una especialidad' : null,
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
