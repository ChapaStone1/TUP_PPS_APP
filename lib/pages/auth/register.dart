import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _fechaNacController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _grupoSanguineoController =
      TextEditingController();
  final TextEditingController _obraSocialController = TextEditingController();

  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final url = Uri.parse('https://tup-pps-api.onrender.com/api/auth/register');
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({
      "nombre": _nombreController.text.trim(),
      "dni": _dniController.text.trim(),
      "sexo": _sexoController.text.trim(),
      "fecha_nac": _fechaNacController.text.trim(),
      "telefono": _telefonoController.text.trim(),
      "email": _emailController.text.trim(),
      "password": _passwordController.text.trim(),
      "grupo_sanguineo": _grupoSanguineoController.text.trim(),
      "obra_social": _obraSocialController.text.trim(),
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      final message = response.statusCode == 200
          ? 'Registro exitoso. Iniciá sesión.'
          : 'No se pudo registrar. Reintentá.';

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al conectar: $e'),
      ));
    }

    setState(() => _isLoading = false);

    // Redirigir al login siempre
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de paciente')),
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
                      onPressed: _register, child: const Text('Registrarse')),
            ],
          ),
        ),
      ),
    );
  }
}
