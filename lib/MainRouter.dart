import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/HomeAdmin.dart';
import 'package:flutter_application_1/pages/HomeMedico.dart';
import 'package:flutter_application_1/pages/HomePaciente.dart';
import 'package:flutter_application_1/pages/SoporteTecnicoPage.dart';
import 'package:flutter_application_1/pages/admin/EliminarPacientePage.dart';
import 'package:flutter_application_1/pages/admin/MedicosAllListPage.dart';
import 'package:flutter_application_1/pages/admin/PacienteListForDeletePage.dart';
import 'package:flutter_application_1/pages/admin/UsersListPage.dart';
import 'package:flutter_application_1/pages/auth/LogoutPage.dart';
import 'package:flutter_application_1/pages/medicos/MedicosListPage.dart';
import 'package:flutter_application_1/pages/medicos/ProfileMedicoPage.dart';
import 'package:flutter_application_1/pages/medicos/PacienteInfoPage.dart';
import 'package:flutter_application_1/pages/medicos/CargarConsultaPage.dart';
import 'package:flutter_application_1/pages/medicos/PacienteListPage.dart';
import 'package:flutter_application_1/pages/pacientes/HistoriaClinicaInfoPage.dart';
import 'package:flutter_application_1/pages/pacientes/MiHistoriaClinicaInfoPage.dart';
import 'package:flutter_application_1/pages/pacientes/ProfilePacientePage.dart';
import 'package:flutter_application_1/pages/auth/LoginPage.dart';
import 'package:flutter_application_1/pages/pacientes/RegisterPacientePage.dart';
import 'package:flutter_application_1/pages/admin/RegisterMedicoPage.dart';

class MainRouter {
  static List<Route> generalRoutes = [];
  static List<Route> medicoRoutes = [];
  static List<Route> pacienteRoutes = [];
  static List<Route> adminRoutes = [];

  static void initRoutes() {
    generalRoutes = [
      Route(
        id: "register",
        path: '/register',
        widget: const RegisterPage(),
        icon: const Icon(Icons.app_registration), // Ícono de registro
        title: "Registrarse como paciente",
        subtitle: "Ventana de registro",
        show: true,
      ),
      Route(
        id: "home-medico",
        path: '/home-medico',
        widget: const HomeMedico(title: 'Consultorios UTN'),
        icon: const Icon(Icons.local_hospital), // Médico
        title: "Inicio Médico",
        subtitle: "Opciones para médicos",
        show: false,
      ),
      Route(
        id: "home-paciente",
        path: '/home-paciente',
        widget: const HomePaciente(title: 'Consultorios UTN'),
        icon: const Icon(Icons.accessibility_new), // Paciente
        title: "Inicio Paciente",
        subtitle: "Opciones para pacientes",
        show: false,
      ),
      Route(
        id: "home-admin",
        path: '/home-admin',
        widget: const HomeAdmin(title: 'Panel de administración'),
        icon: const Icon(Icons.accessibility_new), // Administrador
        title: "Inicio admin",
        subtitle: "",
        show: false,
      ),
      Route(
        id: "login",
        path: '/login',
        widget: const LoginPage(title: 'Iniciar sesión'),
        icon: const Icon(Icons.logout), // Cerrar sesión
        title: "Cerrar sesión",
        subtitle: "Volver a la página de Iniciar sesión.",
        show: true,
      ),
    ];
    adminRoutes = [
      Route(
        id: "register-medico",
        path: '/register-medico',
        widget: const RegisterMedicoPage(),
        icon: const Icon(Icons.person_add_alt_1), // Alta de usuario
        title: "Registrar Medico",
        subtitle: "Registrar una nueva cuenta para un medico",
        show: true,
      ),
      Route(
        id: "register",
        path: '/register',
        widget: const RegisterPage(),
        icon: const Icon(Icons.person_add_alt_1), // Ícono de registro
        title: "Registrar Paciente",
        subtitle: "Registrar una nueva cuenta para un paciente",
        show: true,
      ),
      Route(
        id: "paciente-list-delete",
        path: '/users-list',
        widget: const UsersListPage(),
        icon: const Icon(Icons.delete_forever), // Eliminar
        title: "Resetear contraseña de Usuarios",
        subtitle: "Resetear la contraseña de cualquier usuario del sistema",
        show: true,
      ),
      Route(
        id: "paciente-list-delete",
        path: '/paciente-list-delete',
        widget: const PacientesListForDeletePage(),
        icon: const Icon(Icons.delete_forever), // Eliminar
        title: "Eliminar un paciente de la base de datos",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "eliminar-paciente",
        path: '/eliminar-paciente',
        widget: const EliminarPacientePage(),
        icon: const Icon(Icons.delete_forever), // Eliminar
        title: "Eliminar un paciente de la base de datos",
        subtitle: "",
        show: false,
      ),
      Route(
        id: "Cambiar estado de médico",
        path: '/estado-medico',
        widget: const MedicosAllListPage(),
        icon: const Icon(Icons.delete_forever), // Eliminar
        title: "Habilitar o deshabilitar un médico para atender.",
        subtitle: "",
        show: true,
      ),
      Route(
        id: "medicos-list",
        path: '/medicos-list',
        widget: const MedicoListPage(),
        icon: const Icon(Icons.group), // Lista de pacientes
        title: "Médicos disponibles en Consultorio UTN",
        subtitle: "Ver especialistas disponibles.",
        show: true,
      ),
      Route(
        id: "logout",
        path: '/logout',
        widget: const LogoutPage(),
        icon: const Icon(Icons.logout), // Cerrar sesión
        title: "Cerrar sesión",
        subtitle: "Volver a la página de Iniciar sesión.",
        show: true,
      ),
    ];
    medicoRoutes = [
      Route(
        id: "profile-medico",
        path: '/profile-medico',
        widget: const ProfileMedicoPage(),
        icon: const Icon(Icons.person), // Perfil
        title: "Perfil",
        subtitle: "Ver y editar perfil",
        show: true,
      ),
      Route(
        id: "register",
        path: '/register',
        widget: const RegisterPage(),
        icon: const Icon(Icons.person_add_alt_1), // Ícono de registro
        title: "Registrar Paciente",
        subtitle: "Registrar una nueva cuenta para un paciente",
        show: true,
      ),
      Route(
        id: "pacientes-list",
        path: '/pacientes-list',
        widget: const PacienteListPage(),
        icon: const Icon(Icons.group), // Lista de pacientes
        title: "Ver pacientes",
        subtitle:
            "Cargar consulta médica, ver información e historia clinica de pacientes",
        show: true,
      ),
      Route(
        id: "Datos de paciente",
        path: '/datos-paciente',
        widget: const PacienteInfoPage(),
        icon: const Icon(Icons.info_outline), // Información
        title: "Datos de paciente",
        subtitle: "Datos de paciente",
        show: false,
      ),
      Route(
        id: "Historia Clinica",
        path: '/historia-clinica',
        widget: const HistoriaClinicaInfoPage(),
        icon: const Icon(Icons.medical_information), // Historia clínica
        title: "Historia Clínica del paciente",
        subtitle: "Historia Clínica del paciente",
        show: false,
      ),
      Route(
        id: "Cargar consulta",
        path: '/cargar-consulta',
        widget: const CargarConsultaPage(),
        icon: const Icon(Icons.note_add), // Agregar consulta
        title: "Cargar información de una consulta de un paciente",
        subtitle: "",
        show: false,
      ),
      Route(
        id: "soporte",
        path: '/soporte',
        widget: const SoporteTecnicoPage(),
        icon: const Icon(Icons.support_agent), // Mismo ícono para consistencia
        title: "Soporte Técnico",
        subtitle: "Ayuda con el acceso y asistencia técnica",
        show: true,
      ),
      Route(
        id: "logout",
        path: '/logout',
        widget: const LogoutPage(),
        icon: const Icon(Icons.logout), // Cerrar sesión
        title: "Cerrar sesión",
        subtitle: "Volver a la página de Iniciar sesión.",
        show: true,
      ),
    ];

    pacienteRoutes = [
      Route(
        id: "profile-paciente",
        path: '/profile-paciente',
        widget: const ProfilePacientePage(),
        icon: const Icon(Icons.person), // Perfil
        title: "Perfil",
        subtitle: "Ver y editar perfil",
        show: true,
      ),
      Route(
        id: "mi-historia-clinica",
        path: '/mi-historia-clinica',
        widget: const MiHistoriaClinicaInfoPage(),
        icon: const Icon(Icons.description), // Historia médica
        title: "Mi Historia Clínica",
        subtitle: "Ver mi historia en la Clínica UTN y exportar a PDF.",
        show: true,
      ),
      Route(
        id: "medicos-list",
        path: '/medicos-list',
        widget: const MedicoListPage(),
        icon: const Icon(Icons.group), // Lista de pacientes
        title: "Médicos en Consultorio UTN",
        subtitle: "Ver especialistas disponibles.",
        show: true,
      ),
      Route(
        id: "soporte",
        path: '/soporte',
        widget: const SoporteTecnicoPage(),
        icon: const Icon(Icons.support_agent), // Mismo ícono para consistencia
        title: "Soporte Técnico",
        subtitle: "Ayuda con el acceso y asistencia técnica",
        show: true,
      ),
      Route(
        id: "logout",
        path: '/logout',
        widget: const LogoutPage(),
        icon: const Icon(Icons.logout), // Cerrar sesión
        title: "Cerrar sesión",
        subtitle: "Volver a la página de Iniciar sesión.",
        show: true,
      ),
    ];
  }

  static Map<String, WidgetBuilder> generateRoutes(BuildContext context) {
    final all = [
      ...generalRoutes,
      ...medicoRoutes,
      ...pacienteRoutes,
      ...adminRoutes,
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
