import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Usuario.dart';
import 'package:flutter_application_1/widgets/custom/CustomCardUser.dart';

class UserItem extends StatelessWidget {
  final Usuario usuario;

  const UserItem({super.key, required this.usuario});
  Color? _getColorForTipo(String tipo) {
    switch (tipo) {
      case 'admin':
        return Colors.red.shade100;
      case 'medico':
        return Colors.blue.shade100;
      case 'paciente':
      default:
        return null; // sin color
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomCardUser(
      title: '${usuario.apellido}, ${usuario.nombre}',
      subtitle: '''
DNI: ${usuario.dni}
Email: ${usuario.email}
''',
      color: _getColorForTipo(usuario.tipo),
    );
  }
}
