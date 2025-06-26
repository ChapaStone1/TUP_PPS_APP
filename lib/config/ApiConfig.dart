class ApiConfig {
  // URL base del backend
  static const String baseUrl = 'https://tup-pps-api.onrender.com/api';

  // Auth
  static String login() => '$baseUrl/auth/login';
  static String registerPaciente() => '$baseUrl/auth/register';

  // Pacientes
  static String perfilPaciente() => '$baseUrl/pacientes/mi-perfil';
  static String historiaPaciente() => '$baseUrl/pacientes/historia-clinica';

  // Médicos
  static String perfilMedico() => '$baseUrl/medicos/mi-perfil';
  static String buscarPacientePorDni(String dni) =>
      '$baseUrl/medicos/buscar-paciente/$dni';
  static String eliminarPaciente(int id) =>
      '$baseUrl/medicos/eliminar-paciente/$id';
  static String allPacientes(String query, int limit, int offset) =>
      '$baseUrl/medicos/all-pacientes?dni=$query&limit=$limit&offset=$offset';
  static String registerMedico() => '$baseUrl/medicos/cargar-medico';
  static String cargarConsulta(int id) =>
      '$baseUrl/medicos/cargar-consulta/$id';
  static String historiaClinica(int id) =>
      '$baseUrl/medicos/historia-clinica/$id';
  static String especialidadesMedico() => '$baseUrl/medicos/especialidades';
}
