class RegistroMedico {
  final String nombre;
  final String apellido;
  final String dni;
  final String sexo;
  final String fechaNac;
  final String email;
  final String telefono;
  final String password;
  final String matricula;
  final String consultorio;
  final int? especialidad_id;

  RegistroMedico({
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.sexo,
    required this.fechaNac,
    required this.email,
    required this.telefono,
    required this.password,
    required this.matricula,
    required this.consultorio,
    required this.especialidad_id,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'apellido': apellido,
      'dni': dni,
      'sexo': sexo,
      'fecha_nac': fechaNac,
      'email': email,
      'telefono': telefono,
      'password': password,
      'matricula': matricula,
      'consultorio': consultorio,
      'especialidad_id': especialidad_id ?? 0,
    };
  }
}
