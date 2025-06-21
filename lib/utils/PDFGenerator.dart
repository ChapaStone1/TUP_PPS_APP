import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/classes/HistoriaClinica.dart';

class PDFGenerator {
  static Future<void> generarHistoriaClinicaPDF(BuildContext context,
      Paciente paciente, List<HistoriaClinica> historias) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => pw.Text(
          'Historia Clínica de ${paciente.nombre}',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        footer: (context) => pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Fecha: ${DateTime.now().toString().split(' ')[0]}'),
            pw.Text('Página ${context.pageNumber} de ${context.pagesCount}'),
          ],
        ),
        build: (pw.Context context) => [
          pw.SizedBox(height: 16),
          pw.Text('Datos del paciente:',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.Bullet(text: 'Nombre: ${paciente.nombre}'),
          pw.Bullet(text: 'DNI: ${paciente.dni}'),
          pw.Bullet(text: 'Sexo: ${paciente.sexo}'),
          pw.Bullet(text: 'Fecha de Nacimiento: ${paciente.fechaNac}'),
          pw.Bullet(text: 'Teléfono: ${paciente.telefono}'),
          pw.Bullet(text: 'Email: ${paciente.email}'),
          pw.Bullet(text: 'Grupo Sanguíneo: ${paciente.grupoSanguineo}'),
          pw.Bullet(text: 'Obra Social: ${paciente.obraSocial}'),
          pw.SizedBox(height: 20),
          pw.Text('Consultas registradas:',
              style:
                  pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          for (var h in historias)
            pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: PdfColor.fromHex("#CCCCCC")),
                borderRadius: pw.BorderRadius.circular(4),
              ),
              padding: const pw.EdgeInsets.all(10),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('📅 Fecha: ${h.fecha}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('👨‍⚕️ Médico: ${h.medico}'),
                  pw.Text('🏥 Especialidad: ${h.especialidad}'),
                  pw.Text('📍 Consultorio: ${h.consultorio}'),
                  pw.Text('💊 Medicación: ${h.medicacion}'),
                  pw.Text('📝 Nota médica:\n${h.nota}'),
                ],
              ),
            ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
