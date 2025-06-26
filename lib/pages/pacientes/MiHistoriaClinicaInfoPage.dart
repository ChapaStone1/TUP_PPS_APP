import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/utils/PDFGenerator.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/pacientes/HistoriaClinicaCard.dart';

class MiHistoriaClinicaInfoPage extends StatefulWidget {
  const MiHistoriaClinicaInfoPage({super.key});

  @override
  State<MiHistoriaClinicaInfoPage> createState() =>
      _MiHistoriaClinicaInfoPageState();
}

class _MiHistoriaClinicaInfoPageState extends State<MiHistoriaClinicaInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mi Historia Clínica"),
      ),
      body: FutureFetcher(
        url: ApiConfig.perfilPaciente(),
        widget: (pacienteJson) {
          final Paciente paciente = Paciente.fromJson(pacienteJson['data']);

          return FutureFetcher(
            url: ApiConfig.historiaPaciente(),
            widget: (historiaJson) {
              final List<HistoriaClinica> historias =
                  HistoriaClinica.listFromJson(historiaJson['data']);

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...historias
                        .map((historia) =>
                            HistoriaClinicaCard(historia: historia))
                        .toList(),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          PDFGenerator.generarHistoriaClinicaPDF(
                              context, paciente, historias);
                        },
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text("Exportar en PDF"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[400],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
