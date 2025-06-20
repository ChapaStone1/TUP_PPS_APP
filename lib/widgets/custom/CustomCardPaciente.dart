import 'package:flutter/material.dart';

class CustomCardPaciente extends StatelessWidget {
  final String title; // Para el nombre del paciente
  final String subtitle; // Para el DNI
  final Widget? trailingIcon;
  final VoidCallback onTap;

  const CustomCardPaciente({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: ListTile(
          trailing: trailingIcon,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle:
              Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis),
        ),
      ),
    );
  }
}
