import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Medico.dart';
import 'package:flutter_application_1/helpers/preferences.dart';
import 'package:flutter_application_1/providers/theme_provider.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: BodyProfile(),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  State<BodyProfile> createState() => _BodyProfileState();
}

class _BodyProfileState extends State<BodyProfile> {
  bool darkMode = false;
  bool showPassword = false;

  final _nombreController = TextEditingController();
  final _sexoController = TextEditingController();
  final _dniController = TextEditingController();
  final _fecha_nacController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _emailController = TextEditingController();
  final _matriculaController = TextEditingController();
  final _consultorioController = TextEditingController();
  final _passwordController = TextEditingController();

  List<Map<String, dynamic>> especialidades = [];
  int? especialidadId;

  Medico? medicoPerfil;

  @override
  void initState() {
    super.initState();
    darkMode = Preferences.darkmode;
    getEspecialidades();
    getPerfil();
  }

  Future<void> getEspecialidades() async {
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
        especialidades = List<Map<String, dynamic>>.from(data);
      });
    }
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
        Uri.parse('https://tup-pps-api.onrender.com/api/medicos/mi-perfil');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      setState(() {
        medicoPerfil = Medico.fromJson(data);
        _nombreController.text = medicoPerfil!.nombre;
        _sexoController.text = medicoPerfil!.sexo;
        _fecha_nacController.text = medicoPerfil!.fechaNac;
        _dniController.text = medicoPerfil!.dni;
        _telefonoController.text = medicoPerfil!.telefono.toString();
        _emailController.text = medicoPerfil!.email;
        _matriculaController.text = medicoPerfil!.matricula;
        _consultorioController.text = medicoPerfil!.consultorio;
        especialidadId = medicoPerfil!.especialidadId;
      });
    }
  }

  Future<void> updatePerfil() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return;

    final url =
        Uri.parse('https://tup-pps-api.onrender.com/api/medicos/mi-perfil');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    // Creamos un nuevo objeto Medico con los datos actualizados (excepto id)
    final medicoActualizado = Medico(
      nombre: _nombreController.text.trim(),
      sexo: _sexoController.text.trim(),
      fechaNac: _fecha_nacController.text.trim(),
      dni: _dniController.text.trim(),
      telefono: int.tryParse(_telefonoController.text.trim()) ?? 0,
      email: _emailController.text.trim(),
      matricula: _matriculaController.text.trim(),
      consultorio: _consultorioController.text.trim(),
      especialidadId: especialidadId,
    );

    // Convertimos a JSON y añadimos password si hay
    final bodyMap = medicoActualizado.toJson();
    final passwordText = _passwordController.text.trim();
    if (passwordText.isNotEmpty) {
      bodyMap['password'] = passwordText;
    }
    final body = jsonEncode(bodyMap);

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(json['message'] ?? 'Perfil actualizado con éxito')),
      );
    } else {
      final json = jsonDecode(response.body);
      final errorMessage = json['message'] ?? 'Error al actualizar perfil';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final temaProvider = Provider.of<ThemeProvider>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
            buildTextField(
                'Nombre y Apellido', _nombreController, Icons.person),
            buildTextField('DNI', _dniController, Icons.badge, isNumber: true),
            buildTextField('Sexo', _sexoController, Icons.badge),
            buildTextField(
                'Fecha de nacimiento', _fecha_nacController, Icons.badge),
            buildTextField('Teléfono', _telefonoController, Icons.phone,
                isNumber: true),
            buildTextField('Email', _emailController, Icons.email),
            buildTextField('Matrícula', _matriculaController, Icons.assignment),
            buildTextField(
                'Consultorio', _consultorioController, Icons.assignment),
            buildEspecialidadDropdown(),
            buildTextField(
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
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: updatePerfil,
              icon: const Icon(Icons.save),
              label: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildEspecialidadDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<int>(
        value: especialidadId,
        onChanged: (int? newValue) {
          setState(() {
            especialidadId = newValue;
          });
        },
        decoration: InputDecoration(
          labelText: 'Especialidad',
          prefixIcon: const Icon(Icons.local_hospital),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        items: especialidades.map((esp) {
          return DropdownMenuItem<int>(
            value: esp['id'],
            child: Text(esp['nombre']),
          );
        }).toList(),
      ),
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
