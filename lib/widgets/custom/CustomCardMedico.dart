import 'package:flutter/material.dart';

class CustomCardMedico extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? trailingIcon;
  final void Function()? onTap;
  final String? imagePath; // ahora puede ser asset

  const CustomCardMedico({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingIcon,
    this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 120,
            height: 120,
            color: Colors.grey[300],
            child: imagePath != null
                ? Image.asset(
                    imagePath!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.person, size: 30),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(height: 1.5),
        ),
        trailing: trailingIcon,
      ),
    );
  }
}
