import 'package:flutter_application_1/classes/Paciente.dart';

class PacienteResponse {
  final Paciente paciente;

  PacienteResponse({required this.paciente});

  factory PacienteResponse.fromJson(Map<String, dynamic> json) {
    return PacienteResponse(paciente: Paciente.fromJson(json['data']));
  }
}
