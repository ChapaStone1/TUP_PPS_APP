class ApiConfig {
  // URL base del backend
  static const String baseUrl = 'https://tup-pps-api.onrender.com';

  // Auth
  static String login() => '$baseUrl/api/auth/login';
  static String registerPaciente() => '$baseUrl/api/auth/register-paciente';

  // Admin
  static String eliminarPaciente(int id) =>
      '$baseUrl/api/admin/eliminar-paciente/$id';
  static String registerMedico() => '$baseUrl/api/admin/register-medico';
  static String cambiarDisponibilidad(int id) =>
      '$baseUrl/api/admin/habilitacion-medico/$id';
  static String allMedicos() => '$baseUrl/api/admin/all-medicos';
  static String allUsers(String query, int limit, int offset) =>
      '$baseUrl/api/admin/all-users?dni=$query&limit=$limit&offset=$offset';
  static String resetearPassword(int id) =>
      '$baseUrl/api/admin/reset-password/$id';

  // Pacientes
  static String perfilPaciente() => '$baseUrl/api/pacientes/mi-perfil';
  static String historiaPaciente() => '$baseUrl/api/pacientes/historia-clinica';
  static String allMedicosHabilitados() =>
      '$baseUrl/api/pacientes/medicos-habilitados';

  // Médicos
  static String perfilMedico() => '$baseUrl/api/medicos/mi-perfil';
  static String buscarPacientePorDni(String dni) =>
      '$baseUrl/api/medicos/buscar-paciente/$dni';
  static String allPacientes(String query, int limit, int offset) =>
      '$baseUrl/api/medicos/all-pacientes?dni=$query&limit=$limit&offset=$offset';
  static String cargarConsulta(int id) =>
      '$baseUrl/api/medicos/cargar-consulta/$id';
  static String historiaClinica(int id) =>
      '$baseUrl/api/medicos/historia-clinica/$id';
  static String especialidadesMedico() => '$baseUrl/api/medicos/especialidades';
}
