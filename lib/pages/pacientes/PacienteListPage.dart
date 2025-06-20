import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/paciente/PacientesList.dart';

class PacienteListPage extends StatelessWidget {
  const PacienteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureFetcher(
          url:
              "https://tup-pps-api.onrender.com/api/medicos/all-pacientes?&limit=20",
          widget: (data) {
            return PacientesList(data: data);
          },
        ),
      ),
    );
  }
}
