import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/IsFavoriteIcon.dart';
import 'package:flutter_application_1/widgets/custom/CustomCardPaciente.dart';

class PacienteItem extends StatelessWidget {
  final Paciente paciente;

  const PacienteItem({super.key, required this.paciente});

  @override
  Widget build(BuildContext context) {
    final nombre = paciente.nombre.isNotEmpty ? paciente.nombre : 'Sin nombre';
    final apellido =
        paciente.apellido.isNotEmpty ? paciente.apellido : 'Sin apellido';
    final dni = paciente.dni.isNotEmpty ? paciente.dni : 'N/D';
    final obra = paciente.obraSocial.isNotEmpty ? paciente.obraSocial : 'N/A';

    return CustomCardPaciente(
      trailingIcon: IsFavoriteIcon(
        id: paciente.id,
        color: const Color.fromARGB(255, 218, 197, 13),
        size: 30,
      ),
      title: '${apellido}, ${nombre}',
      subtitle:
          'DNI: $dni   |  Obra Social: $obra', //|  Correo: $email  |  Obra Social: $obra

      onTap: () {
        Navigator.pushNamed(
          context,
          '/datos-paciente',
          arguments: paciente,
        );
      },
    );
  }
}
