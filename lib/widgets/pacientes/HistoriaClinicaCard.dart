import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';

class HistoriaClinicaCard extends StatelessWidget {
  final HistoriaClinica historia;

  const HistoriaClinicaCard({super.key, required this.historia});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.person, color: Colors.blueGrey),
                const SizedBox(width: 8),
                Expanded(
                  // Para que el texto no se desborde y tome espacio disponible
                  child: Text(
                    'Especialista: ${historia.medicoNombre} ${historia.medicoApellido}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            InfoRow(
                icon: Icons.calendar_today,
                label: 'Fecha',
                value: historia.fecha),
            InfoRow(
                icon: Icons.note, label: 'Nota médica', value: historia.nota),
            InfoRow(
                icon: Icons.medication,
                label: 'Medicación',
                value: historia.medicacion),
            InfoRow(
                icon: Icons.local_hospital,
                label: 'Consultorio',
                value: historia.consultorio),
            InfoRow(
                icon: Icons.medical_services,
                label: 'Especialidad',
                value: historia.especialidad),
            const SizedBox(height: 8),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                    text: '$label: ',
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
