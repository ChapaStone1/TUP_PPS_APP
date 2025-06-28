import 'package:flutter/material.dart';

class CustomCardMedico extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailingIcon;
  final String imagePath;

  const CustomCardMedico({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen arriba
            Image.asset(
              imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            // Título (nombre)
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Subtítulo
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Ícono opcional
            if (trailingIcon != null) trailingIcon!,
          ],
        ),
      ),
    );
  }
}
