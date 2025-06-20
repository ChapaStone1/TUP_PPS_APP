import 'package:flutter/material.dart';

class CustomCardPaciente extends StatelessWidget {
  final String title;
  final Widget? trailingIcon;
  final VoidCallback onTap;
  final String name = 'assets/images/paciente.jpg';

  const CustomCardPaciente({
    super.key,
    required this.title,
    this.trailingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12.0)),
              child: Image.asset(
                name,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 109, 5, 5),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(12.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: "CoolveticaRg",
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  if (trailingIcon != null) trailingIcon!,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
