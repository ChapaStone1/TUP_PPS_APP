import 'package:flutter_application_1/classes/Medico.dart';

class MedicoResponse {
  final Medico medico;

  MedicoResponse({required this.medico});

  factory MedicoResponse.fromJson(Map<String, dynamic> json) {
    return MedicoResponse(medico: Medico.fromJson(json['data']));
  }
}
