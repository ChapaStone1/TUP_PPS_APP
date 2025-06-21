// ignore: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/pacientes/HistoriaClinicaDescription.dart'; // La descripción personalizada para los personajes Marvel

class HistoriaClinicaInfoPage extends StatefulWidget {
  const HistoriaClinicaInfoPage({super.key});

  @override
  State<HistoriaClinicaInfoPage> createState() =>
      HistoriaClinicaInfoPageState();
}

class HistoriaClinicaInfoPageState extends State<HistoriaClinicaInfoPage> {
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    final Paciente paciente =
        ModalRoute.of(context)!.settings.arguments as Paciente;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historia Clinica"),
      ),
      body: Center(
          child: FutureFetcher(
        url:
            "https://tup-pps-api.onrender.com/api/medicos/historia-clinica/${paciente.id}",
        widget: (data) {
          if (data == null || data.isEmpty) {
            return const Text("No hay registros disponibles.");
          }
          final historia =
              HistoriaClinica.fromJson(data[0]); // asumimos una lista
          return HistoriaClinicaDescription(historiaClinica: historia);
        },
      )),
    );
  }
}
