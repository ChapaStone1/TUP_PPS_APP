// ignore: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/paciente/PacienteDescription.dart'; // La descripción personalizada para los personajes Marvel

class PacienteInfoPage extends StatefulWidget {
  const PacienteInfoPage({super.key});

  @override
  State<PacienteInfoPage> createState() => _PacienteInfoPageState();
}

class _PacienteInfoPageState extends State<PacienteInfoPage> {
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    final Paciente paciente =
        ModalRoute.of(context)!.settings.arguments as Paciente;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Paciente"),
      ),
      body: Center(
        child: FutureFetcher(
          url:
              "https://tup-pps-api.onrender.com/api/medicos/buscar-paciente/${paciente.dni}", // URL a la API de Marvel
          widget: (data) {
            return PacienteDescription(
                paciente: paciente); // Aquí se pasa la información obtenida
          },
        ),
      ),
    );
  }
}
