import 'dart:convert';
import 'package:flutter_application_1/classes/RegistroMedico.dart';
import 'package:http/http.dart' as http;
import '../classes/RegistroPaciente.dart';

class RegistroService {
  static const String _baseUrl = 'https://tup-pps-api.onrender.com';

  Future<Map<String, dynamic>> registrar(Registro registro) async {
    final url = Uri.parse('$_baseUrl/api/medicos');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(registro.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);

      final ok = response.statusCode == 200 || response.statusCode == 201;
      final message =
          json['message'] ?? json['data']?['message'] ?? 'Registro exitoso.';

      return {
        'ok': ok,
        'status': json['status'] ?? response.statusCode,
        'message': message,
      };
    } catch (e) {
      return {
        'ok': false,
        'message': 'Error de red o al conectar: $e',
      };
    }
  }

  Future<Map<String, dynamic>> registrarMedico(RegistroMedico registro) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/cargar-medico'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(registro.toJson()),
      );

      final json = jsonDecode(response.body);

      final ok = response.statusCode == 200 || response.statusCode == 201;
      final message = json['message'] ??
          json['data']?['message'] ??
          json['error'] ??
          'Registro fallido.';

      return {'ok': ok, 'message': message};
    } catch (e) {
      return {'ok': false, 'message': 'Error de red o servidor: $e'};
    }
  }
}
