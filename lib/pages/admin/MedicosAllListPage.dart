import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/admin/MedicosAllList.dart';

class MedicosAllListPage extends StatelessWidget {
  const MedicosAllListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MedicosAllList(),
      ),
    );
  }
}
