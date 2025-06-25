import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FutureDeleter extends StatefulWidget {
  final String url;
  final Widget Function(Map<String, dynamic>) widget;

  const FutureDeleter({
    super.key,
    required this.url,
    required this.widget,
  });

  @override
  _FutureDeleterState createState() => _FutureDeleterState();
}

class _FutureDeleterState extends State<FutureDeleter> {
  late Future<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = deleteData();
  }

  Future<Map<String, dynamic>> deleteData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.delete(
      Uri.parse(widget.url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final decoded = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        'status': decoded['status'],
        'message': decoded['data']?['message'] ?? 'Operación exitosa',
      };
    } else {
      return {
        'status': decoded['status'] ?? response.statusCode,
        'message': decoded['data']?['message'] ??
            decoded['message'] ??
            'Error desconocido',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: \${snapshot.error}'));
        } else if (snapshot.hasData) {
          return widget.widget(snapshot.data!);
        } else {
          return const Center(child: Text('No data returned'));
        }
      },
    );
  }
}
