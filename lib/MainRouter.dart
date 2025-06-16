import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomeMedico.dart';
import 'package:flutter_application_1/pages/HomePaciente.dart';
import 'package:flutter_application_1/pages/ProfilePage.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
import 'package:flutter_application_1/pages/auth/register.dart';

class MainRouter {
  static List<Route> routes = <Route>[
    Route(
        id: "profile",
        path: '/profile',
        widget: const ProfilePage(),
        icon: const Icon(Icons.settings),
        title: "Perfil de Usuario",
        subtitle: "",
        show: false),
    Route(
        id: "home-medico",
        path: '/home-medico',
        widget: const HomeMedico(
          title: 'Bienvenido.',
        ),
        icon: const Icon(Icons.person_search_rounded),
        title: "Home de medicos",
        subtitle: "Juan Jose Chaparro",
        show: false),
    Route(
        id: "home-paciente",
        path: '/home-paciente',
        widget: const HomePaciente(
          title: 'Bienvenido.',
        ),
        icon: const Icon(Icons.person_search_rounded),
        title: "Home de pacientes",
        subtitle: "Juan Jose Chaparro",
        show: false),
    Route(
        id: "register",
        path: '/register',
        widget: const RegisterPage(),
        icon: const Icon(Icons.person_search_rounded),
        title: "Registrarse",
        subtitle: ".",
        show: false),
    Route(
        id: "login",
        path: '/login',
        widget: const LoginPage(
          title: 'Logearse',
        ),
        icon: const Icon(Icons.person_search_rounded),
        title: "Logearse",
        subtitle: ".",
        show: true),
    //Rutas Matias Bussetti
    /*Route(
        id: "patientsList",
        path: '/patients',
        widget: const PatientsPage(),
        icon: const Icon(Icons.person_search_rounded),
        title: "Lista de Pacientes",
        subtitle: "Matias Bussetti",
        show: true),

    Route(
        id: "patientsMap",
        path: '/patients/map',
        widget: const PatientsMapPage(),
        icon: const Icon(Icons.map),
        title: "Mapa de Pacientes",
        subtitle: "Matias Bussetti",
        show: true),
    Route(
        id: "patientInfo",
        path: '/paciente/id',
        widget: const PatientInfoPage(),
        icon: const Icon(Icons.accessibility_new_rounded),
        title: "Paciente",
        subtitle: "",
        show: false),*/
  ];

  static Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    return {
      for (var route in routes) route.path: (context) => route.widget,
    };
  }

  static getRoute(String) {}
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
