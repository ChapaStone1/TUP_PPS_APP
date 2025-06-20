import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/paciente/PacienteItem.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PacienteSearchDelegate extends SearchDelegate<Paciente?> {
  PacienteSearchDelegate();

  Future<List<Paciente>> _fetchSearchResults(String query) async {
    const int limit = 20;
    final url =
        "https://tup-pps-api.onrender.com/api/medicos/all-pacientes?dni=$query&limit=$limit";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Paciente.listFromJson(data);
    } else {
      throw Exception('Error fetching search results');
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
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
          return const Center(child: Text('No se encontraron resultados.'));
        }

        return ListView.builder(
          itemCount: pacientes.length,
          itemBuilder: (context, index) {
            final paciente = pacientes[index];

            return PacienteItem(paciente: paciente);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Introduce un nombre para buscar.'));
    }
    return FutureBuilder<List<Paciente>>(
      future: _fetchSearchResults(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final suggestions = snapshot.data ?? [];

        if (suggestions.isEmpty) {
          return const Center(child: Text('No se encontraron sugerencias.'));
        }

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final paciente = suggestions[index];

            return InkWell(
              onTap: () {
                query = paciente.nombre;
                showResults(context);
              },
              child: PacienteItem(paciente: paciente),
            );
          },
        );
      },
    );
  }
}
