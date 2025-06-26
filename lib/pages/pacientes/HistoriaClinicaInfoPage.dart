import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/widgets/custom/FutureFetcher.dart';
import 'package:flutter_application_1/widgets/pacientes/HistoriaClinicaCard.dart';
import 'package:flutter_application_1/utils/PDFGenerator.dart';

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
        url: ApiConfig.historiaClinica(paciente.id),
        widget: (jsonData) {
          final List<HistoriaClinica> historias =
              HistoriaClinica.listFromJson(jsonData['data']);

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: historias.length,
                  itemBuilder: (context, index) {
                    return HistoriaClinicaCard(historia: historias[index]);
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
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
            ],
          );
        },
      ),
    );
  }
}
