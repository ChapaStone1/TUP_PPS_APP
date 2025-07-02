import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final IconData icon;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DatePickerFormField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    required this.icon,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onTap: () async {
          FocusScope.of(context).unfocus(); // Cierra el teclado
          DateTime initial = initialDate ??
              (DateTime.tryParse(controller.text) ?? DateTime(2000));
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initial,
            firstDate: firstDate ?? DateTime(1900),
            lastDate: lastDate ?? DateTime.now(),
            locale: const Locale('es'),
          );

          if (pickedDate != null) {
            controller.text = DateFormat('yyyy-MM-dd')
                .format(pickedDate); // Formatear para la DB
          }
        },
      ),
    );
  }
}
