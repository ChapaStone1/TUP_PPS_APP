// ignore_for_file: file_names, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/paciente/PacienteItem.dart';
import 'package:flutter_application_1/widgets/custom/PacienteSearchDelegate.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PacientesList extends StatefulWidget {
  const PacientesList({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<PacientesList> createState() => _PacientesListState();
}

class _PacientesListState extends State<PacientesList> {
  late List<Paciente> _pacientes;
  // ignore: unused_field
  bool _isSearching = false;
  String _searchQuery = "";
  int _currentPage = 0;
  final int _limit = 20;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  late ScrollController _scrollController;
  Timer? _debounce; // declaro el debounce para el timer

  @override
  void initState() {
    super.initState();
    _pacientes = Paciente.listFromJson(widget.data['data']);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel(); // libero el timer
    super.dispose();
  }

  Future<List<Paciente>> _fetchSearchResults(String query, int offset) async {
    final url =
        "https://tup-labo-4-grupo-15.onrender.com/api/v1/marvel/chars?nameStartsWith=$query&limit=$_limit&offset=$offset";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Paciente.listFromJson(data);
    } else {
      throw Exception('Error fetching search results');
    }
  }

  Future<void> _fetchMoreCharacters() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final newCharacters =
          await _fetchSearchResults(_searchQuery, _currentPage * _limit);
      setState(() {
        _pacientes.addAll(newCharacters);
        _hasMore = newCharacters.length == _limit;
        _currentPage++;
      });
    } catch (error) {
      debugPrint('Error fetching more characters: $error');
    } finally {
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchMoreCharacters();
    }
  }

  void _handleSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = value;
        _isSearching = value.isNotEmpty;
        _currentPage = 0;
        _hasMore = true;
        _pacientes.clear();
      });

      _fetchMoreCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marvel - Characters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PacienteSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
        itemCount: _pacientes.length + (_isLoadingMore ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == _pacientes.length) {
            return const Center(child: CircularProgressIndicator());
          }
          final paciente = _pacientes[index];
          return PacienteItem(paciente: paciente);
        },
      ),
    );
  }
}
