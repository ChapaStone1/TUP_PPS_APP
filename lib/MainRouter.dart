import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomeMedico.dart';
import 'package:flutter_application_1/pages/HomePaciente.dart';
import 'package:flutter_application_1/pages/ProfilePage.dart';
import 'package:flutter_application_1/pages/auth/Login.dart';
import 'package:flutter_application_1/pages/pacientes/RegisterPaciente.dart';
import 'package:flutter_application_1/pages/medicos/RegisterMedico.dart';

class MainRouter {
  static List<Route> allRoutes = [];

  // Inicializador (para evitar que se construya antes de tener funciones)
  static void initRoutes() {
    allRoutes = [
      Route(
        id: "profile",
        path: '/profile',
        widget: const ProfilePage(),
        icon: const Icon(Icons.settings),
        title: "Perfil de Usuario",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "home-medico",
        path: '/home-medico',
        widget: HomeMedico(
          title: 'Bienvenido.',
          routes: medicoRoutes(),
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
          title: 'Bienvenido.',
          routes: pacienteRoutes(),
        ),
        icon: const Icon(Icons.person_outline),
        title: "Inicio Paciente",
        subtitle: "Opciones para pacientes",
        show: false,
      ),
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
        id: "login",
        path: '/login',
        widget: const LoginPage(title: 'Iniciar sesión'),
        icon: const Icon(Icons.login),
        title: "Iniciar sesión",
        subtitle: "",
        show: true,
      ),
    ];
  }

  static List<Route> medicoRoutes() {
    return [
      Route(
        id: "profile",
        path: '/profile',
        widget: const ProfilePage(),
        icon: const Icon(Icons.settings),
        title: "Perfil",
        subtitle: "Ver y editar perfil",
        show: true,
      ),
      Route(
        id: "login",
        path: '/login',
        widget: const LoginPage(title: 'Iniciar sesión'),
        icon: const Icon(Icons.login),
        title: "Iniciar sesión",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "register-medico",
        path: '/register-medico',
        widget: const RegisterMedicoPage(),
        icon: const Icon(Icons.login),
        title: "Registrar Medico",
        subtitle: "",
        show: true,
      ),
      // Agregá más rutas específicas para médicos si querés
    ];
  }

  static List<Route> pacienteRoutes() {
    return [
      Route(
        id: "profile",
        path: '/profile',
        widget: const ProfilePage(),
        icon: const Icon(Icons.settings),
        title: "Perfil",
        subtitle: "Ver y editar perfil",
        show: true,
      ),
      // Agregá más rutas específicas para pacientes si querés
    ];
  }

  static Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    final all = [
      ...allRoutes,
      ...medicoRoutes(),
      ...pacienteRoutes(),
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
