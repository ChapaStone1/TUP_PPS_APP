import 'dart:convert';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PacienteService {
  Future<List<Paciente>> fetchPacientes({
    required String query,
    required int limit,
    required int offset,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token no encontrado');

    final url =
        "https://tup-pps-api.onrender.com/api/medicos/all-pacientes?dni=$query&limit=$limit&offset=$offset";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // <- CORREGIDO aquí
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Paciente.listFromJson(data['data']);
    } else {
      throw Exception('Error al buscar pacientes');
    }
  }
}
