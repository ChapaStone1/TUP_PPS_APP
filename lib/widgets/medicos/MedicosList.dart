import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Medico.dart';
import 'package:flutter_application_1/services/ListarMedicosService.dart';
import 'package:flutter_application_1/widgets/medicos/MedicoItem.dart';

class MedicosList extends StatefulWidget {
  const MedicosList({super.key});

  @override
  State<MedicosList> createState() => _MedicosListState();
}

class _MedicosListState extends State<MedicosList> {
  late Future<List<Medico>> _futureMedicos;

  @override
  void initState() {
    super.initState();
    _futureMedicos = ListarMedicosService().fetchEnableMedicos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Médicos'),
      ),
      body: FutureBuilder<List<Medico>>(
        future: _futureMedicos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final medicos = snapshot.data;

          if (medicos == null || medicos.isEmpty) {
            return const Center(child: Text('No hay médicos disponibles.'));
          }

          return ListView.builder(
            itemCount: medicos.length,
            itemBuilder: (context, index) {
              return MedicoItem(medico: medicos[index]);
            },
          );
        },
      ),
    );
  }
}
