import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/config/ApiConfig.dart';
import 'package:flutter_application_1/widgets/custom/FuturePoster.dart';
import 'package:flutter_application_1/utils/GeneralValidator.dart';

class CargarConsultaPage extends StatefulWidget {
  const CargarConsultaPage({super.key});

  @override
  State<CargarConsultaPage> createState() => _CargarConsultaPageState();
}

class _CargarConsultaPageState extends State<CargarConsultaPage> {
  final _formKey = GlobalKey<FormState>();
  final _notaController = TextEditingController();
  final _medicacionController = TextEditingController();

  @override
  void dispose() {
    _notaController.dispose();
    _medicacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paciente = ModalRoute.of(context)!.settings.arguments as Paciente;

    return Scaffold(
      appBar: AppBar(title: const Text("Cargar consulta a paciente")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Paciente: ${paciente.apellido}, ${paciente.nombre}",
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _notaController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Nota',
                  border: OutlineInputBorder(),
                ),
                validator: GeneralValidator.campoRequerido,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _medicacionController,
                decoration: const InputDecoration(
                  labelText: 'Medicacion',
                  border: OutlineInputBorder(),
                ),
                validator: GeneralValidator.campoRequerido,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Cargar Consulta"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final body = {
                      'nota': _notaController.text.trim(),
                      'medicacion': _medicacionController.text.trim(),
                    };

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FuturePoster(
                          url: ApiConfig.cargarConsulta(paciente.id),
                          body: body,
                          widget: (data) {
                            final status = data['status'] ?? 500;
                            final ok = status == 200 || status == 201;
                            final message = data['data']?['message'] ??
                                'Hubo un error inesperado';
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(message)),
                              );

                              Future.delayed(const Duration(seconds: 2), () {
                                if (mounted) {
                                  Navigator.popUntil(
                                      context,
                                      (route) =>
                                          route.isFirst); // volver al inicio
                                }
                              });
                            });

                            return Scaffold(
                              body: Center(
                                child: ok
                                    ? const Icon(Icons.check_circle,
                                        color: Colors.green, size: 80)
                                    : const Icon(Icons.error,
                                        color: Colors.red, size: 80),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
