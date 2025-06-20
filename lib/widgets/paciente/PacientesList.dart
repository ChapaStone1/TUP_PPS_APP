import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/paciente/PacienteItem.dart';
import 'package:flutter_application_1/widgets/custom/PacienteSearchDelegate.dart';

class PacientesList extends StatefulWidget {
  const PacientesList({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<PacientesList> createState() => _PacientesListState();
}

class _PacientesListState extends State<PacientesList> {
  late List<Paciente> _pacientes;

  @override
  void initState() {
    super.initState();
    _pacientes = Paciente.listFromJson(widget.data['data']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pacientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch<Paciente?>(
                context: context,
                delegate: PacienteSearchDelegate(),
              ).then((selectedPaciente) {
                if (selectedPaciente != null) {
                  // Aquí podés manejar el paciente seleccionado, por ejemplo:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text('Seleccionaste: ${selectedPaciente.nombre}')),
                  );
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _pacientes.length,
        itemBuilder: (BuildContext context, int index) {
          final paciente = _pacientes[index];
          return PacienteItem(paciente: paciente);
        },
      ),
    );
  }
}
