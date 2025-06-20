// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PacienteSearchDelegate extends SearchDelegate<Paciente?> {
  PacienteSearchDelegate();

  Future<List<Paciente>> _fetchSearchResults(String query) async {
    const int limit = 20;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token no encontrado. Iniciá sesión.');
    }

    final url =
        "https://tup-pps-api.onrender.com/api/medicos/all-pacientes?dni=$query&limit=$limit";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Paciente.listFromJson(data['data']);
    } else {
      throw Exception('Error al buscar pacientes');
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Paciente>>(
      future: _fetchSearchResults(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final pacientes = snapshot.data ?? [];

        if (pacientes.isEmpty) {
          return const Center(child: Text('No se encontraron pacientes.'));
        }

        return ListView.builder(
          itemCount: pacientes.length,
          itemBuilder: (context, index) {
            final paciente = pacientes[index];
            return ListTile(
              title: Text(paciente.nombre),
              subtitle: Text('DNI: ${paciente.dni}'),
              onTap: () {
                close(context, paciente); // Retornás el paciente si querés
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Escribí un DNI y presioná buscar'));
  }
}
