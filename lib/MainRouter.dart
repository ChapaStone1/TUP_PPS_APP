import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomeMedico.dart';
import 'package:flutter_application_1/pages/HomePaciente.dart';
import 'package:flutter_application_1/pages/medicos/ProfileMedico.dart';
import 'package:flutter_application_1/pages/medicos/PacienteInfoPage.dart';
import 'package:flutter_application_1/pages/medicos/PacienteListPage.dart';
import 'package:flutter_application_1/pages/pacientes/HistoriaClinicaInfoPage.dart';
import 'package:flutter_application_1/pages/pacientes/MiHistoriaClinicaInfoPage.dart';
import 'package:flutter_application_1/pages/pacientes/ProfilePaciente.dart';
import 'package:flutter_application_1/pages/auth/Login.dart';
import 'package:flutter_application_1/pages/RegisterPaciente.dart';
import 'package:flutter_application_1/pages/medicos/RegisterMedico.dart';

class MainRouter {
  static List<Route> generalRoutes = [];
  static List<Route> medicoRoutes = [];
  static List<Route> pacienteRoutes = [];

  static void initRoutes() {
    generalRoutes = [
      Route(
        id: "register",
        path: '/register',
        widget: const RegisterPage(),
        icon: const Icon(Icons.person_add),
        title: "Registrarse",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "home-medico",
        path: '/home-medico',
        widget: HomeMedico(
          title: 'Bienvenido',
        ),
        icon: const Icon(Icons.person),
        title: "Inicio Médico",
        subtitle: "Opciones para médicos",
        show: false,
      ),
      Route(
        id: "home-paciente",
        path: '/home-paciente',
        widget: HomePaciente(
          title: 'Bienvenido',
        ),
        icon: const Icon(Icons.person_outline),
        title: "Inicio Paciente",
        subtitle: "Opciones para pacientes",
        show: false,
      ),
    ];
    // separo las rutas de acuerdo a quien se logea.
    medicoRoutes = [
      Route(
        id: "profile-medico",
        path: '/profile-medico',
        widget: const ProfileMedicoPage(),
        icon: const Icon(Icons.settings),
        title: "Perfil",
        subtitle: "Ver y editar perfil",
        show: true,
      ),
      Route(
        id: "register-medico",
        path: '/register-medico',
        widget: const RegisterMedicoPage(),
        icon: const Icon(Icons.settings),
        title: "Registrar Medico",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "pacientes-list",
        path: '/pacientes-list',
        widget: const PacienteListPage(),
        icon: const Icon(Icons.settings),
        title: "Lista de pacientes",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "Datos de paciente",
        path: '/datos-paciente',
        widget: const PacienteInfoPage(),
        icon: const Icon(Icons.settings),
        title: "Datos de paciente",
        subtitle: "",
        show: false,
      ),
      Route(
        id: "Historia Clinica",
        path: '/historia-clinica',
        widget: const HistoriaClinicaInfoPage(),
        icon: const Icon(Icons.settings),
        title: "Historia Clinica del paciente",
        subtitle: "",
        show: false,
      ),
      Route(
        id: "Cargar consulta",
        path: '/cargar-consulta',
        widget: const HistoriaClinicaInfoPage(),
        icon: const Icon(Icons.settings),
        title: "Cargar información de una consulta de un paciente",
        subtitle: "",
        show: false,
      ),
      Route(
        id: "eliminar-paciente",
        path: '/eliminar-paciente',
        widget: const HistoriaClinicaInfoPage(),
        icon: const Icon(Icons.settings),
        title: "Eliminar un paciente de la base de datos.",
        subtitle: "",
        show: false,
      ),
      Route(
        id: "login",
        path: '/login',
        widget: const LoginPage(title: 'Iniciar sesión.'),
        icon: const Icon(Icons.login),
        title: "Cerrar sesión",
        subtitle: "Volver al login.",
        show: true,
      ),
    ];

    pacienteRoutes = [
      Route(
        id: "profile-paciente",
        path: '/profile-paciente',
        widget: const ProfilePacientePage(),
        icon: const Icon(Icons.settings),
        title: "Perfil",
        subtitle: "Ver y editar perfil",
        show: true,
      ),
      Route(
        id: "mi-historia-clinica",
        path: '/mi-historia-clinica',
        widget: const MiHistoriaClinicaInfoPage(),
        icon: const Icon(Icons.settings),
        title: "Mi Historia Clinica",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "login",
        path: '/login',
        widget: const LoginPage(title: 'Iniciar sesión.'),
        icon: const Icon(Icons.login),
        title: "Cerrar sesión",
        subtitle: "Volver al login.",
        show: true,
      ),
      // Podés agregar más rutas acá si querés
    ];
  }

  static Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    final all = [
      ...generalRoutes,
      ...medicoRoutes,
      ...pacienteRoutes,
    ];

    return {
      for (var route in all) route.path: (context) => route.widget,
    };
  }
}

class Route {
  final String id;
  final String path;
  final Widget widget;
  final String title;
  final String subtitle;
  final bool show;
  final Icon icon;

  Route({
    required this.id,
    required this.path,
    required this.widget,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.show,
  });
}
