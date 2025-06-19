class Paciente {
  final int _id;
  final String _nombre;
  final String _dni;
  final String _sexo;
  final String _fechaNac;
  final int _telefono;
  final String _email;
  final String _grupoSanguineo;
  final String _obraSocial;

  Paciente({
    required int id,
    required String nombre,
    required String dni,
    required String sexo,
    required String fechaNac,
    required int telefono,
    required String email,
    required String grupoSanguineo,
    required String obraSocial,
  })  : _id = id,
        _nombre = nombre,
        _dni = dni,
        _sexo = sexo,
        _fechaNac = fechaNac,
        _telefono = telefono,
        _email = email,
        _grupoSanguineo = grupoSanguineo,
        _obraSocial = obraSocial;

  // Getters
  int get id => _id;
  String get nombre => _nombre;
  String get dni => _dni;
  String get sexo => _sexo;
  String get fechaNac => _fechaNac;
  int get telefono => _telefono;
  String get email => _email;
  String get grupoSanguineo => _grupoSanguineo;
  String get obraSocial => _obraSocial;

  // Factory
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
      'id': _id,
      'nombre': _nombre,
      'dni': _dni,
      'sexo': _sexo,
      'fecha_nac': _fechaNac,
      'telefono': _telefono,
      'email': _email,
      'grupo_sanguineo': _grupoSanguineo,
      'obra_social': _obraSocial,
    };
  }

  static List<Paciente> listFromJson(List<dynamic> data) {
    return data.map((item) => Paciente.fromJson(item)).toList();
  }
}
