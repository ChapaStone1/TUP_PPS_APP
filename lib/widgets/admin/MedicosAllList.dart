import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Medico.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/services/ListarMedicosService.dart';
import 'package:flutter_application_1/widgets/custom/FuturePatcher.dart';
import 'package:flutter_application_1/widgets/medicos/MedicoItem.dart';

class MedicosAllList extends StatefulWidget {
  const MedicosAllList({super.key});

  @override
  State<MedicosAllList> createState() => _MedicosAllListState();
}

class _MedicosAllListState extends State<MedicosAllList> {
  late Future<List<Medico>> _futureMedicos;
  final _medicoService = ListarMedicosService();

  @override
  void initState() {
    super.initState();
    _loadMedicos();
  }

  void _loadMedicos() {
    setState(() {
      _futureMedicos = _medicoService.fetchAllMedicos();
    });
  }

  void _toggleHabilitacion(Medico medico) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: FuturePatcher(
          url: ApiConfig.cambiarDisponibilidad(medico.id),
          body: {},
          builder: (response) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context); // Cierra el diálogo
              _loadMedicos(); // Recarga la lista
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(response['message'] ?? 'Estado actualizado')),
              );
            });
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listado de Médicos')),
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
              final medico = medicos[index];

              return Opacity(
                opacity: medico.habilitado ? 1.0 : 0.4,
                child: ListTile(
                  leading: Icon(
                    medico.habilitado ? Icons.check_circle : Icons.cancel,
                    color: medico.habilitado ? Colors.green : Colors.red,
                  ),
                  title: MedicoItem(medico: medico),
                  trailing: Switch(
                    value: medico.habilitado,
                    onChanged: (_) {
                      _toggleHabilitacion(medico);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
