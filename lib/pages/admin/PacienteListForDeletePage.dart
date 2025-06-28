import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/admin/PacientesListForDelete.dart';

class PacientesListForDeletePage extends StatelessWidget {
  const PacientesListForDeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: PacientesListForDelete(),
      ),
    );
  }
}
