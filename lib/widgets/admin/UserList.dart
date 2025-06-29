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
  late Future<List<Usuario>> _futureUsuarios;
  final _userService = ListarUsersService();
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  void _loadUsuarios() {
    setState(() {
      _futureUsuarios = _userService.fetchUsuarios(
        query: _query,
        limit: 10,
        offset: 0,
      );
    });
  }

  void _onSearchSubmitted(String text) {
    _query = text.trim();
    _loadUsuarios();
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
              child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Dialog(
                  child: FuturePatcher(
                    url: ApiConfig.resetearPassword(usuario.id),
                    body: {},
                    builder: (response) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pop(context);
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
        title: const Text('Usuarios sin información'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Buscar por DNI...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchSubmitted('');
                        },
                      )
                    : null,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: _onSearchSubmitted,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: _futureUsuarios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final usuarios = snapshot.data;
          if (usuarios == null || usuarios.isEmpty) {
            return const Center(child: Text('No hay usuarios para mostrar.'));
          }
          return ListView.builder(
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return ListTile(
                title: UserItem(usuario: usuario),
                trailing: IconButton(
                  icon: const Icon(Icons.lock_reset, color: Colors.blue),
                  tooltip: 'Resetear contraseña',
                  onPressed: () => _resetearPassword(usuario),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
