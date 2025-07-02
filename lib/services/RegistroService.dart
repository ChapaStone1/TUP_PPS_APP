import 'dart:convert';
import 'package:flutter_application_1/classes/RegistroMedico.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../classes/RegistroPaciente.dart';

class RegistroService {
  Future<Map<String, dynamic>> registrarPaciente(
      RegistroPaciente registro) async {
    final url = Uri.parse(ApiConfig.registerPaciente());
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(registro.toJson());

    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);

      final status = json['status'] ?? response.statusCode;
      final ok = status == 200 || status == 201;
      final message =
          json['data']?['message'] ?? json['message'] ?? 'Registro exitoso.';

      return {
        'ok': ok,
        'status': status,
        'message': message,
        'usuarioId': json['data']?['usuarioId'],
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
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        return {
          'ok': false,
          'message': 'Token no encontrado. Inicie sesión nuevamente.'
        };
      }

      final response = await http.post(
        Uri.parse(ApiConfig.registerMedico()),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(registro.toJson()),
      );

      final json = jsonDecode(response.body);
      final status = json['status'] ?? response.statusCode;
      final ok = status == 200 || status == 201;
      final message = json['data']?['message'] ??
          json['message'] ??
          json['error'] ??
          'Registro fallido.';

      return {
        'ok': ok,
        'message': message,
        'status': status,
        'usuarioId': json['data']?['usuarioId'],
      };
    } catch (e) {
      return {'ok': false, 'message': 'Error de red o servidor: $e'};
    }
  }
}
