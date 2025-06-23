import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/RegistroMedico.dart';
import 'package:flutter_application_1/services/RegistroService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterMedicoPage extends StatefulWidget {
  const RegisterMedicoPage({super.key});

  @override
  State<RegisterMedicoPage> createState() => _RegisterMedicoPageState();
}

class _RegisterMedicoPageState extends State<RegisterMedicoPage> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _dniController = TextEditingController();
  final _fechaNacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _consultorioController = TextEditingController();
  final _matriculaController = TextEditingController();

  int? _especialidadId;
  List<Map<String, dynamic>> _especialidades = [];

  bool _isLoading = false;
  String _sexoSeleccionado = 'M';

  @override
  void initState() {
    super.initState();
    _fetchEspecialidades();
  }

  Future<void> _fetchEspecialidades() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token no encontrado. Iniciá sesión.')),
      );
      return;
    }

    final url = Uri.parse(
        'https://tup-pps-api.onrender.com/api/medicos/especialidades');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      setState(() {
        _especialidades = List<Map<String, dynamic>>.from(data);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No se pudieron cargar las especialidades')),
      );
    }
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
    if (_especialidadId == null) return;

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
      consultorio: _consultorioController.text.trim(),
      especialidad: _especialidadId!,
    );

    final servicio = RegistroService();
    final result = await servicio.registrarMedico(registro);

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
    final theme = Theme.of(context);
    return Scaffold(
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
              Text('Registrar cuenta de médico',
                  style: theme.textTheme.headlineSmall),
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
              TextFormField(
                controller: _consultorioController,
                decoration:
                    _inputDecoration('Consultorio', Icons.assignment_ind),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _especialidadId,
                decoration:
                    _inputDecoration('Especialidad', Icons.medical_services),
                items: _especialidades.map((esp) {
                  return DropdownMenuItem<int>(
                    value: esp['id'],
                    child: Text(esp['nombre']),
                  );
                }).toList(),
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
