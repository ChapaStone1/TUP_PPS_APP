import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/medicos/MedicosList.dart';

class MedicoListPage extends StatelessWidget {
  const MedicoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MedicosList(),
      ),
    );
  }
}
