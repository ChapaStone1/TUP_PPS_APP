import 'dart:convert';
import 'package:flutter_application_1/classes/Usuario.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListarUsersService {
  Future<List<Usuario>> fetchUsuarios({
    required String query,
    required int limit,
    required int offset,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) throw Exception('Token no encontrado');

    final url = ApiConfig.allUsers(query, limit, offset);

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Usuario.listFromJson(data['data']);
    } else {
      try {
        final error = jsonDecode(response.body);
        final message = error['message'] ?? 'Error al buscar usuarios';
        throw Exception(message);
      } catch (e) {
        throw Exception('Error al buscar usuarios');
      }
    }
  }
}
