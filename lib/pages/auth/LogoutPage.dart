import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/preferences.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  @override
  void initState() {
    super.initState();
    _logout();
  }

  Future<void> _logout() async {
    // 1. Limpiar SharedPreferences o cualquier sesión guardada
    await Preferences.clear();

    // 2. Redirigir al login y limpiar toda la pila de navegación
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
