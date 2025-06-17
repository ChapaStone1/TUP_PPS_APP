import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/Registro.dart';

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
}
