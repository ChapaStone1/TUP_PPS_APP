import 'package:flutter/material.dart';

class SoporteTecnicoPage extends StatelessWidget {
  const SoporteTecnicoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Soporte Técnico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/images/UTN.png',
              height: 80,
              fit: BoxFit.contain,
              color: primaryColor,
              colorBlendMode: BlendMode.srcIn,
            ),
            const SizedBox(height: 30),
            const Text(
              '¿Tenés problemas con la aplicación? Contactanos.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('chapapr@gmail.com'),
              subtitle: Text('Correo de contacto'),
            ),
            const ListTile(
              leading: Icon(Icons.phone, color: Colors.green),
              title: Text('291-4705104'),
              subtitle: Text('Teléfono de contacto'),
            ),
            const Divider(height: 30),
            const Text(
              'Alumno: Juan Jose Chaparro\n Legajo Académico: 21737\n UTN - TUP | PPS 2025',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
