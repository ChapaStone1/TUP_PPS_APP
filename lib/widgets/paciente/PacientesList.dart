import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/services/pacientes_service.dart';
import 'package:flutter_application_1/widgets/paciente/PacienteItem.dart';
import 'dart:async';

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
  String _searchQuery = "";
  int _currentPage = 0;
  final int _limit = 20;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  late ScrollController _scrollController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _pacientes = Paciente.listFromJson(widget.data['data']);
    _scrollController = ScrollController()..addListener(_onScroll);

    // 🔧 Fuerza un rebuild tras el primer frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchMorePacientes() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final _pacienteService = PacienteService();

      final newPacientes = await _pacienteService.fetchPacientes(
        query: _searchQuery,
        limit: _limit,
        offset: _currentPage * _limit,
      );

      setState(() {
        final existingDnis = _pacientes.map((p) => p.dni).toSet();
        for (final paciente in newPacientes) {
          if (!existingDnis.contains(paciente.dni)) {
            _pacientes.add(paciente);
          }
        }
        _hasMore = newPacientes.length == _limit;
        _currentPage++;
      });
    } catch (error) {
      debugPrint('Error al cargar más pacientes: $error');
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchMorePacientes();
    }
  }

  void _handleSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      final query = value.trim();
      if (query == _searchQuery) return;

      setState(() {
        _searchQuery = query;
        _currentPage = 0;
        _hasMore = true;
        _pacientes.clear();
      });

      await _fetchMorePacientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de pacientes')),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAlias, // Previene glitches visuales
                child: TextField(
                  key: const Key('dni_search_input'),
                  textAlignVertical: TextAlignVertical.center,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Buscar por DNI',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                  onChanged: _handleSearch,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _pacientes.length + (_isLoadingMore ? 1 : 0),
                padding: const EdgeInsets.only(top: 4, bottom: 12),
                itemBuilder: (BuildContext context, int index) {
                  if (index == _pacientes.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final paciente = _pacientes[index];
                  return PacienteItem(paciente: paciente);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
