import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Medico.dart';
import 'package:flutter_application_1/widgets/custom/CustomCardMedico.dart';
import 'package:flutter_application_1/widgets/IsFavoriteIcon.dart';

class MedicoItem extends StatelessWidget {
  final Medico medico;

  const MedicoItem({super.key, required this.medico});

  @override
  Widget build(BuildContext context) {
    return CustomCardMedico(
      title: '${medico.apellido}, ${medico.nombre}',
      subtitle: '''
Sexo: ${medico.sexo}
Teléfono: ${medico.telefono}
Email: ${medico.email}
Matrícula: ${medico.matricula}
Consultorio: ${medico.consultorio}
Especialidad: ${medico.especialidad_nombre}
''',
      trailingIcon: IsFavoriteIcon(
        id: medico.id,
        color: Colors.blueAccent,
        size: 24,
      ),
      imagePath: 'lib/assets/images/medico.png',
    );
  }
}
