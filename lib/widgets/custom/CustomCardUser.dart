import 'package:flutter/material.dart';

class CustomCardUser extends StatelessWidget {
  final String title; // Nombre completo del usuario
  final String subtitle; // Información adicional: tipo, DNI, email, etc.
  final Widget? trailingIcon;
  final Color? color; // ✅ Nuevo parámetro opcional para fondo

  const CustomCardUser({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: color, // ✅ Se aplica el color recibido
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: ListTile(
        trailing: trailingIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
