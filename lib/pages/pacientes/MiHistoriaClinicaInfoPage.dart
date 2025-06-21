// ignore: unused_import
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/pacientes/HistoriaClinicaDescription.dart'; // La descripción personalizada para los personajes Marvel

class MiHistoriaClinicaInfoPage extends StatefulWidget {
  const MiHistoriaClinicaInfoPage({super.key});

  @override
  State<MiHistoriaClinicaInfoPage> createState() =>
      HistoriaClinicaInfoPageState();
}

class HistoriaClinicaInfoPageState extends State<MiHistoriaClinicaInfoPage> {
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    final HistoriaClinica historiaClinica =
        ModalRoute.of(context)!.settings.arguments as HistoriaClinica;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historia Clinica"),
      ),
      body: Center(
        child: FutureFetcher(
          url:
              "https://tup-pps-api.onrender.com/api/pacientes/mi-historia", // URL a la API de Marvel
          widget: (data) {
            return HistoriaClinicaDescription(
                historiaClinica:
                    historiaClinica); // Aquí se pasa la información obtenida
          },
        ),
      ),
    );
  }
}
