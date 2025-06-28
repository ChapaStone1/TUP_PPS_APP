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
    await Preferences
        .clear(); // Asegurate de tener este método en tu clase Preferences

    // 2. Si usás Provider o algún state global, podés resetearlo acá también (opcional)

    // 3. Redirigir al login y limpiar toda la pila de navegación
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
