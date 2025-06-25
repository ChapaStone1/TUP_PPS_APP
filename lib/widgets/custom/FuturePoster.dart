import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FuturePoster extends StatefulWidget {
  final String url;
  final Widget Function(Map<String, dynamic>) widget;
  final Map<String, dynamic>? body;

  const FuturePoster({
    super.key,
    required this.url,
    required this.widget,
    this.body,
  });

  @override
  _FuturePosterState createState() => _FuturePosterState();
}

class _FuturePosterState extends State<FuturePoster> {
  late Future<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = postData();
  }

  Future<Map<String, dynamic>> postData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.post(
      Uri.parse(widget.url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(widget.body ?? {}),
    );

    final statusCode = response.statusCode;

    if (statusCode == 200 || statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      try {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Error $statusCode');
      } catch (_) {
        throw Exception('Error $statusCode: ${response.reasonPhrase}');
      }
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
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return widget.widget(snapshot.data!);
        } else {
          return const Center(child: Text('No data returned'));
        }
      },
    );
  }
}
