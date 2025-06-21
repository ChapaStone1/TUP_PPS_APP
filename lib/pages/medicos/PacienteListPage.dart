import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/medicos/PacientesList.dart';

class PacienteListPage extends StatelessWidget {
  const PacienteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const PacientesList(),
      ),
    );
  }
}
