import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Usuario.dart';
import 'package:flutter_application_1/widgets/custom/CustomCardUser.dart';

class UserItem extends StatelessWidget {
  final Usuario usuario;

  const UserItem({super.key, required this.usuario});
  @override
  Widget build(BuildContext context) {
    return CustomCardUser(
      title: '${usuario.apellido}, ${usuario.nombre}',
      subtitle: '''
DNI: ${usuario.dni}
Email: ${usuario.email}
Tipo: ${usuario.tipo}
''',
    );
  }
}
