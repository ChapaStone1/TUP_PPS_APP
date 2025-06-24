import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: BodyProfilePaciente(),
      ),
    );
  }
}

class BodyProfilePaciente extends StatefulWidget {
  const BodyProfilePaciente({super.key});

  @override
  State<BodyProfilePaciente> createState() => _BodyProfilePacienteState();
}

class _BodyProfilePacienteState extends State<BodyProfilePaciente> {
  bool darkMode = false;
  bool showPassword = false;

  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _dniController = TextEditingController();
  final _sexoController = TextEditingController();
  final _fechaNacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _obraSocialController = TextEditingController();
  final _passwordController = TextEditingController();

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
    darkMode = Preferences.darkmode;
  }

  Future<void> updatePerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return;

    final url =
        Uri.parse('https://tup-pps-api.onrender.com/api/pacientes/mi-perfil');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'nombre': _nombreController.text.trim(),
      'apellido': _apellidoController.text.trim(),
      'dni': _dniController.text.trim(),
      'sexo': _sexoController.text.trim(),
      'fecha_nac': _fechaNacController.text.trim(),
      'telefono': _telefonoController.text.trim(),
      'email': _emailController.text.trim(),
      'grupo_sanguineo': _grupoSanguineoSeleccionado ?? '',
      'obra_social': _obraSocialController.text.trim(),
      'password': _passwordController.text.trim(),
    });

    final response = await http.put(url, headers: headers, body: body);
    final json = jsonDecode(response.body);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(json['message'] ?? 'Perfil actualizado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<ThemeProvider>(context, listen: false);

    return FutureFetcher(
      url: 'https://tup-pps-api.onrender.com/api/pacientes/mi-perfil',
      widget: (json) {
        final data = json['data'];
        _nombreController.text = data['nombre'] ?? '';
        _apellidoController.text = data['apellido'] ?? '';
        _dniController.text = data['dni'] ?? '';
        _sexoController.text = data['sexo'] ?? '';
        _fechaNacController.text = data['fecha_nac'] ?? '';
        _telefonoController.text = data['telefono']?.toString() ?? '';
        _emailController.text = data['email'] ?? '';
        _grupoSanguineoSeleccionado = data['grupo_sanguineo'] ?? null;
        _obraSocialController.text = data['obra_social'] ?? '';

        return Column(
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
            buildTextField('Nombre', _nombreController, Icons.person),
            buildTextField('Apellido', _apellidoController, Icons.person),
            buildTextField('DNI', _dniController, Icons.badge, isNumber: true),
            buildTextField('Sexo', _sexoController, Icons.transgender),
            buildTextField(
                'Fecha de nacimiento', _fechaNacController, Icons.cake),
            buildTextField('Teléfono', _telefonoController, Icons.phone,
                isNumber: true),
            buildTextField('Email', _emailController, Icons.email),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: DropdownButtonFormField<String>(
                value: _grupoSanguineoSeleccionado,
                decoration: InputDecoration(
                  labelText: 'Grupo Sanguíneo',
                  prefixIcon: const Icon(Icons.bloodtype),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                items: grupoSanguineoOpciones
                    .map((gs) => DropdownMenuItem(value: gs, child: Text(gs)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _grupoSanguineoSeleccionado = value;
                  });
                },
              ),
            ),
            buildTextField(
                'Obra Social', _obraSocialController, Icons.local_hospital),
            buildTextField(
              'Contraseña',
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
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: updatePerfil,
              icon: const Icon(Icons.save),
              label: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
            ),
          ],
        );
      },
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isNumber = false,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
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
      ),
    );
  }
}
