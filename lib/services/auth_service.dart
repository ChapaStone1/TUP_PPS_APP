import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _baseUrl = 'https://tup-pps-api.onrender.com';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/auth/login');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

    try {
      final response = await http.post(url, headers: headers, body: body);
      final json = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = json['data'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
        await prefs.setString('tipo', data['tipo']);

        return {'ok': true, 'tipo': data['tipo'], 'message': data['message']};
      } else {
        return {'ok': false, 'message': json['data']['message'] ?? 'Error'};
      }
    } catch (e) {
      return {'ok': false, 'message': 'Error al conectar: $e'};
    }
  }
}
