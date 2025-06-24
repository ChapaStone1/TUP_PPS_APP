import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FutureUpdater extends StatefulWidget {
  final String url;
  final Map<String, dynamic> body;
  final Widget Function(Map<String, dynamic>) widget;

  const FutureUpdater({
    super.key,
    required this.url,
    required this.body,
    required this.widget,
  });

  @override
  _FutureUpdaterState createState() => _FutureUpdaterState();
}

class _FutureUpdaterState extends State<FutureUpdater> {
  late Future<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = updateData();
  }

  Future<Map<String, dynamic>> updateData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse(widget.url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(widget.body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error updating data');
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
