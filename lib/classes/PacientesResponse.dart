import 'package:flutter_application_1/classes/Paciente.dart';

class PacientesResponse {
  final List<Paciente> pacientes;

  PacientesResponse({required this.pacientes});

  factory PacientesResponse.fromJson(Map<String, dynamic> json) {
    return PacientesResponse(
      pacientes: List<Paciente>.from(
          json['data'].map((paciente) => Paciente.fromJson(paciente))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': pacientes.map((paciente) => paciente.toJson()).toList(),
    };
  }

  List<Paciente> getData() {
    return pacientes;
  }
}
