import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';

class HistoriaClinicaDescription extends StatelessWidget {
  final HistoriaClinica historiaClinica;

  const HistoriaClinicaDescription({super.key, required this.historiaClinica});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenWidth * 0.5,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  historiaClinica.medico,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              background: Container(color: Colors.green[300]),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                InfoRow(
                    icon: Icons.calendar_today,
                    label: "Fecha",
                    value: historiaClinica.fecha),
                InfoRow(
                    icon: Icons.note,
                    label: "Nota médica",
                    value: historiaClinica.nota),
                InfoRow(
                    icon: Icons.medication,
                    label: "Medicación",
                    value: historiaClinica.medicacion),
                InfoRow(
                    icon: Icons.local_hospital,
                    label: "Consultorio",
                    value: historiaClinica.consultorio),
                InfoRow(
                    icon: Icons.local_hospital,
                    label: "Especialidad",
                    value: historiaClinica.especialidad),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueGrey[300], size: 30),
          const SizedBox(width: 20),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
