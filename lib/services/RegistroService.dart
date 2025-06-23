import 'dart:convert';
import 'package:flutter_application_1/classes/RegistroMedico.dart';
import 'package:http/http.dart' as http;
import '../classes/RegistroPaciente.dart';

class RegistroService {
  static const String _baseUrl = 'https://tup-pps-api.onrender.com';

  Future<Map<String, dynamic>> registrar(Registro registro) async {
    final url = Uri.parse('$_baseUrl/api/auth/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(registro.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);

      return {
        'ok': response.statusCode == 200,
        'status': json['status'],
        'message':
            json['data']['message'] ?? 'Registro exitoso. Iniciá sesión.',
      };
    } catch (e) {
      return {
        'ok': false,
        'message': 'Error al conectar: $e',
      };
    }
  }

  Future<Map<String, dynamic>> registrarMedico(RegistroMedico registro) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register-medico'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(registro.toJson()),
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'ok': true, 'message': body['message'] ?? 'Registro exitoso'};
      } else {
        return {'ok': false, 'message': body['error'] ?? 'Error al registrar'};
      }
    } catch (e) {
      return {'ok': false, 'message': 'Error de red o servidor'};
    }
  }
}
