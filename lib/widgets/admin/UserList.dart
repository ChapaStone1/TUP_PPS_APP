import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Usuario.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/services/ListarUsersService.dart';
import 'package:flutter_application_1/widgets/admin/UserItem.dart';
import 'package:flutter_application_1/widgets/custom/FuturePatcher.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final List<Usuario> _usuarios = [];
  final _userService = ListarUsersService();
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _query = '';
  int _currentPage = 0;
  final int _limit = 10;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchMoreUsuarios(); // Primer carga
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _fetchMoreUsuarios() async {
    if (_isLoadingMore || !_hasMore) return;

    setState(() => _isLoadingMore = true);

    try {
      final nuevos = await _userService.fetchUsuarios(
        query: _query,
        limit: _limit,
        offset: _currentPage * _limit,
      );

      setState(() {
        _usuarios.addAll(nuevos);
        _hasMore = nuevos.length == _limit;
        _currentPage++;
      });
    } catch (e) {
      debugPrint('Error al cargar usuarios: $e');
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchMoreUsuarios();
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final nuevoQuery = value.trim();
      if (nuevoQuery == _query) return;

      setState(() {
        _query = nuevoQuery;
        _currentPage = 0;
        _hasMore = true;
        _usuarios.clear();
      });

      _fetchMoreUsuarios();
    });
  }

  void _resetearPassword(Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar reseteo'),
        content: Text(
          '¿Resetear contraseña de ${usuario.apellido}, ${usuario.nombre}?\n'
          'Nueva clave: "clave${usuario.dni}"',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(
                  context); // Cierra el primer diálogo (de confirmación)
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext loadingContext) => Dialog(
                  child: FuturePatcher(
                    url: ApiConfig.resetearPassword(usuario.id),
                    body: {},
                    builder: (response) {
                      // Cerrá el loading dialog correctamente
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (Navigator.of(loadingContext).canPop()) {
                          Navigator.of(loadingContext)
                              .pop(); // Cierra el loader
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              response['message'] ??
                                  'Contraseña reseteada: "clave${usuario.dni}"',
                            ),
                          ),
                        );
                      });
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de usuarios'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Buscar por DNI...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _usuarios.isEmpty && !_isLoadingMore
          ? const Center(child: Text('No hay usuarios para mostrar.'))
          : ListView.builder(
              controller: _scrollController,
              itemCount: _usuarios.length + (_isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _usuarios.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final usuario = _usuarios[index];
                return ListTile(
                  title: UserItem(usuario: usuario),
                  trailing: IconButton(
                    icon: const Icon(Icons.lock_reset, color: Colors.blue),
                    tooltip: 'Resetear contraseña',
                    onPressed: () => _resetearPassword(usuario),
                  ),
                );
              },
            ),
    );
  }
}
