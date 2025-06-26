import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/medicos/PacienteDescription.dart';

class PacienteInfoPage extends StatefulWidget {
  const PacienteInfoPage({super.key});

  @override
  State<PacienteInfoPage> createState() => _PacienteInfoPageState();
}

class _PacienteInfoPageState extends State<PacienteInfoPage> {
  @override
  Widget build(BuildContext context) {
    final Paciente paciente =
        ModalRoute.of(context)!.settings.arguments as Paciente;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paciente"),
      ),
      body: Center(
        child: FutureFetcher(
          url: ApiConfig.buscarPacientePorDni(paciente.dni),
          widget: (data) {
            return PacienteDescription(paciente: paciente);
          },
        ),
      ),
    );
  }
}
