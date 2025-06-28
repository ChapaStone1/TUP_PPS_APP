import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FuturePatcher extends StatefulWidget {
  final String url;
  final Map<String, dynamic> body;
  final Widget Function(Map<String, dynamic>) builder;

  const FuturePatcher({
    super.key,
    required this.url,
    required this.body,
    required this.builder,
  });

  @override
  _FuturePatcherState createState() => _FuturePatcherState();
}

class _FuturePatcherState extends State<FuturePatcher> {
  late Future<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    data = patchData();
  }

  Future<Map<String, dynamic>> patchData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.patch(
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
      throw Exception('Error patching data: ${response.statusCode}');
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
          return widget.builder(snapshot.data!);
        } else {
          return const Center(child: Text('No data returned'));
        }
      },
    );
  }
}
