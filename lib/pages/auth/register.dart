import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Registro.dart';
import 'package:flutter_application_1/services/registro_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _dniController = TextEditingController();
  final _sexoController = TextEditingController();
  final _fechaNacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _grupoSanguineoController = TextEditingController();
  final _obraSocialController = TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final registro = Registro(
      nombre: _nombreController.text.trim(),
      dni: _dniController.text.trim(),
      sexo: _sexoController.text.trim(),
      fechaNac: _fechaNacController.text.trim(),
      telefono: _telefonoController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      grupoSanguineo: _grupoSanguineoController.text.trim(),
      obraSocial: _obraSocialController.text.trim(),
    );

    final servicio = RegistroService();
    final result = await servicio.registrar(registro);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(result['message']),
    ));

    if (result['ok']) {
      Navigator.pushReplacementNamed(
          context, '/login'); // Reemplaza la pantalla
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de paciente'),
        automaticallyImplyLeading: false, // Quita la flecha de "atrás"
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _dniController,
                decoration: const InputDecoration(labelText: 'DNI'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _sexoController,
                decoration: const InputDecoration(labelText: 'Sexo (M/F)'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _fechaNacController,
                decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento (YYYY-MM-DD)'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo electrónico'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (!v.contains('@')) return 'Correo inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _grupoSanguineoController,
                decoration: const InputDecoration(labelText: 'Grupo sanguíneo'),
              ),
              TextFormField(
                controller: _obraSocialController,
                decoration: const InputDecoration(labelText: 'Obra social'),
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _register,
                      child: const Text('Registrarse'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
