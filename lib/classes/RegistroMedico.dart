class RegistroMedico {
  final String nombre;
  final String dni;
  final String sexo;
  final String fechaNac;
  final String email;
  final String telefono;
  final String password;
  final String matricula;
  final String especialidad;

  RegistroMedico({
    required this.nombre,
    required this.dni,
    required this.sexo,
    required this.fechaNac,
    required this.email,
    required this.telefono,
    required this.password,
    this.matricula = '',
    this.especialidad = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'dni': dni,
      'sexo': sexo,
      'fecha_nac': fechaNac,
      'email': email,
      'telefono': telefono,
      'password': password,
      'matricula': matricula,
      'especialidad': especialidad,
    };
  }
}
