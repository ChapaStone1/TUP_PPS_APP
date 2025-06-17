class Registro {
  final String nombre;
  final String dni;
  final String sexo;
  final String fechaNac;
  final String telefono;
  final String email;
  final String password;
  final String grupoSanguineo;
  final String obraSocial;

  Registro({
    required this.nombre,
    required this.dni,
    required this.sexo,
    required this.fechaNac,
    required this.telefono,
    required this.email,
    required this.password,
    required this.grupoSanguineo,
    required this.obraSocial,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'dni': dni,
      'sexo': sexo,
      'fecha_nac': fechaNac,
      'telefono': telefono,
      'email': email,
      'password': password,
      'grupo_sanguineo': grupoSanguineo,
      'obra_social': obraSocial,
    };
  }

  factory Registro.fromJson(Map<String, dynamic> json) {
    return Registro(
      nombre: json['nombre'],
      dni: json['dni'],
      sexo: json['sexo'],
      fechaNac: json['fecha_nac'],
      telefono: json['telefono'],
      email: json['email'],
      password: json['password'],
      grupoSanguineo: json['grupo_sanguineo'] ?? '',
      obraSocial: json['obra_social'] ?? '',
    );
  }
}
