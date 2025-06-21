import 'package:flutter_application_1/classes/HistoriaClinica.dart';

class HistoriaClinicaResponse {
  final List<HistoriaClinica> historias;

  HistoriaClinicaResponse({required this.historias});

  factory HistoriaClinicaResponse.fromJson(Map<String, dynamic> json) {
    return HistoriaClinicaResponse(
      historias: HistoriaClinica.listFromJson(json['data']),
    );
  }
}
