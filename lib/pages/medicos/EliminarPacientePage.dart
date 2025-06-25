import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/custom/FutureDeleter.dart';

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
          content: Text(
              "¿Deseás eliminar al paciente ${paciente.nombre} ${paciente.apellido}?"),
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
        Navigator.pop(context, false);
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
        // Usamos FutureDeleter para la eliminación
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FutureDeleter(
              url:
                  'https://tup-pps-api.onrender.com/api/medicos/eliminar-paciente/${paciente.id}',
              widget: (data) {
                final ok = data['ok'] ?? false;
                final message = data['message'] ?? '';

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                  if (ok) {
                    Navigator.pop(context); // Cierra FutureDeleter
                    Navigator.pop(context); // Cierra paciente-description
                  } else {
                    Navigator.pop(
                        context); // Solo cierra FutureDeleter si falló
                  }
                });

                // Mientras muestra el resultado, dejamos una pantalla vacía o mensaje
                return Scaffold(
                  body: Center(
                    child: ok
                        ? const Icon(Icons.check_circle,
                            color: Colors.green, size: 80)
                        : const Icon(Icons.error, color: Colors.red, size: 80),
                  ),
                );
              },
            ),
          ),
        );
      } else {
        Navigator.pop(context, false);
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      confirmarEliminacion();
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
