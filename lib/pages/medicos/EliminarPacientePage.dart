import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EliminarPacientePage extends StatelessWidget {
  const EliminarPacientePage({super.key});

  @override
  Widget build(BuildContext context) {
    final paciente = ModalRoute.of(context)!.settings.arguments as Paciente;

    Future<void> confirmarEliminacion() async {
      final confirmar1 = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("¿Estás seguro?"),
          content: Text("¿Deseás eliminar al paciente ${paciente.nombre}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("No"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Sí"),
            ),
          ],
        ),
      );

      if (confirmar1 != true) {
        Navigator.pop(context); // salir de la pantalla actual
        return;
      }

      final confirmar2 = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirmación final"),
          content: const Text(
              "¿Estás completamente seguro? Esta acción no se puede deshacer."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context, true),
              child: const Text("Eliminar"),
            ),
          ],
        ),
      );

      if (confirmar2 == true) {
        final success = await eliminarPaciente(context, paciente);

        if (success) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/login', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Error al eliminar al paciente.")),
          );
          Navigator.pop(context); // volver atrás
        }
      } else {
        Navigator.pop(context); // salir de la pantalla actual
      }
    }

    // Mostramos las alertas apenas se construye
    WidgetsBinding.instance.addPostFrameCallback((_) {
      confirmarEliminacion();
    });

    // Mientras tanto, pantalla de carga
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<bool> eliminarPaciente(BuildContext context, Paciente paciente) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return false;

      final url = Uri.parse(
          'https://tup-pps-api.onrender.com/api/medicos/eliminar-paciente/${paciente.id}');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint("Paciente eliminado correctamente.");
        return true;
      } else {
        debugPrint("Error al eliminar paciente: ${response.body}");
        return false;
      }
    } catch (e) {
      debugPrint("Excepción al eliminar paciente: $e");
      return false;
    }
  }
}
