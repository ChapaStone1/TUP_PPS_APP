// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/IsFavoriteIcon.dart';
import 'package:flutter_application_1/widgets/custom/CustomCardPaciente.dart';

class PacienteItem extends StatelessWidget {
  final Paciente paciente;

  const PacienteItem({super.key, required this.paciente});

  @override
  Widget build(BuildContext context) {
    return CustomCardPaciente(
      title: paciente.nombre,
      subtitle: 'DNI: ${paciente.dni}  |  Grupo: ${paciente.grupoSanguineo}',
      trailingIcon: IsFavoriteIcon(
        id: paciente.dni, // mejor identificador
        color: Colors.yellow,
        size: 32,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/paciente/id',
          arguments: paciente,
        );
      },
    );
  }
}
