import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/pacientes/HistoriaClinicaCard.dart';
import 'package:flutter_application_1/utils/PDFGenerator.dart'; // Asegurate de tener esta función

class HistoriaClinicaInfoPage extends StatefulWidget {
  const HistoriaClinicaInfoPage({super.key});

  @override
  State<HistoriaClinicaInfoPage> createState() =>
      HistoriaClinicaInfoPageState();
}

class HistoriaClinicaInfoPageState extends State<HistoriaClinicaInfoPage> {
  @override
  Widget build(BuildContext context) {
    final Paciente paciente =
        ModalRoute.of(context)!.settings.arguments as Paciente;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historia Clínica"),
      ),
      body: FutureFetcher(
        url:
            "https://tup-pps-api.onrender.com/api/medicos/historia-clinica/${paciente.id}",
        widget: (jsonData) {
          final List<HistoriaClinica> historias =
              HistoriaClinica.listFromJson(jsonData['data']);

          return SingleChildScrollView(
            child: Column(
              children: [
                ...historias
                    .map((historia) => HistoriaClinicaCard(historia: historia))
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
      ),
    );
  }
}
