import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final _dniController = TextEditingController();
  final _sexoController = TextEditingController();
  final _fechaNacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _grupoSanguineoController = TextEditingController();
  final _obraSocialController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    darkMode = Preferences.darkmode;
    getPerfil();
  }

  Future<void> getPerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token no encontrado. Iniciá sesión.')),
      );
      return;
    }

    final url =
        Uri.parse('https://tup-pps-api.onrender.com/api/pacientes/mi-perfil');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      setState(() {
        _nombreController.text = data['nombre'] ?? '';
        _dniController.text = data['dni'] ?? '';
        _sexoController.text = data['sexo'] ?? '';
        _fechaNacController.text = data['fecha_nac'] ?? '';
        _telefonoController.text = data['telefono']?.toString() ?? '';
        _emailController.text = data['email'] ?? '';
        _grupoSanguineoController.text = data['grupo_sanguineo'] ?? '';
        _obraSocialController.text = data['obra_social'] ?? '';
      });
    }
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
      'dni': _dniController.text.trim(),
      'sexo': _sexoController.text.trim(),
      'fecha_nac': _fechaNacController.text.trim(),
      'telefono': _telefonoController.text.trim(),
      'email': _emailController.text.trim(),
      'grupo_sanguineo': _grupoSanguineoController.text.trim(),
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
        buildTextField('Nombre y apellido', _nombreController, Icons.person),
        buildTextField('DNI', _dniController, Icons.badge, isNumber: true),
        buildTextField('Sexo', _sexoController, Icons.transgender),
        buildTextField('Fecha de nacimiento', _fechaNacController, Icons.cake),
        buildTextField('Teléfono', _telefonoController, Icons.phone,
            isNumber: true),
        buildTextField('Email', _emailController, Icons.email),
        buildTextField(
            'Grupo Sanguíneo', _grupoSanguineoController, Icons.bloodtype),
        buildTextField(
            'Obra Social', _obraSocialController, Icons.local_hospital),
        buildTextField(
          'Contraseña',
          _passwordController,
          Icons.lock,
          obscureText: !showPassword,
          suffixIcon: IconButton(
            icon: Icon(showPassword ? Icons.visibility : Icons.visibility_off),
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
          style:
              ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
        ),
      ],
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
          fillColor: Theme.of(context).inputDecorationTheme.fillColor ??
              Colors.grey.shade900,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
