class Paciente {
  final int id;
  final String nombre;
  final String dni;
  final String sexo;
  final String fechaNac;
  final int telefono;
  final String email;
  final String grupoSanguineo;
  final String obraSocial;

  Paciente({
    required this.id,
    required this.nombre,
    required this.dni,
    required this.sexo,
    required this.fechaNac,
    required this.telefono,
    required this.email,
    required this.grupoSanguineo,
    required this.obraSocial,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id: json['id'],
      nombre: json['nombre'],
      dni: json['dni'],
      sexo: json['sexo'],
      fechaNac: json['fecha_nac'],
      telefono: json['telefono'],
      email: json['email'],
      grupoSanguineo: json['grupo_sanguineo'],
      obraSocial: json['obra_social'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'dni': dni,
      'sexo': sexo,
      'fecha_nac': fechaNac,
      'telefono': telefono,
      'email': email,
      'grupo_sanguineo': grupoSanguineo,
      'obra_social': obraSocial,
    };
  }

  static List<Paciente> listFromJson(List<dynamic> data) {
    return data.map((item) => Paciente.fromJson(item)).toList();
  }
}
