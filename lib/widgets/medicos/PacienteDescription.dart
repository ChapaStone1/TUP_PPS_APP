import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/Paciente.dart';
import 'package:flutter_application_1/widgets/IsFavoriteIcon.dart';

class PacienteDescription extends StatelessWidget {
  final Paciente paciente;

  const PacienteDescription({super.key, required this.paciente});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: screenWidth * 0.6,
            floating: false,
            pinned: true,
            automaticallyImplyLeading: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  paciente.nombre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 1.0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'lib/assets/images/paciente.jpg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black
                        .withOpacity(0.3), // opcional para oscurecer un poco
                  ),
                  Positioned(
                    top: 14.0,
                    right: 8.0,
                    child: IsFavoriteIcon(
                      id: paciente.nombre,
                      color: Colors.yellow,
                      size: 40.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                InfoRow(icon: Icons.badge, label: "DNI", value: paciente.dni),
                InfoRow(
                    icon: Icons.person, label: "Sexo", value: paciente.sexo),
                InfoRow(
                    icon: Icons.cake,
                    label: "Fecha de Nacimiento",
                    value: paciente.fechaNac),
                InfoRow(
                    icon: Icons.phone,
                    label: "Teléfono",
                    value: paciente.telefono.toString()),
                InfoRow(
                    icon: Icons.email, label: "Email", value: paciente.email),
                InfoRow(
                    icon: Icons.opacity,
                    label: "Grupo Sanguíneo",
                    value: paciente.grupoSanguineo),
                InfoRow(
                    icon: Icons.local_hospital,
                    label: "Obra Social",
                    value: paciente.obraSocial),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/cargar-consulta');
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Cargar consulta"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/historia-clinica',
                            arguments: paciente,
                          );
                        },
                        icon: const Icon(Icons.history),
                        label: const Text("Ver historia clínica"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/eliminar-paciente',
                            arguments: paciente,
                          );
                        },
                        icon: const Icon(Icons.delete),
                        label: const Text("Eliminar paciente"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          backgroundColor: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.red[200], size: 30),
          const SizedBox(width: 20),
          Expanded(
            child: RichText(
              text: TextSpan(
                style:
                    DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
