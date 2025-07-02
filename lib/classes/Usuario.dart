class Usuario {
  final int _id;
  final String _nombre;
  final String _apellido;
  final String _dni;
  final String _sexo;
  final String _fechaNac;
  final String _telefono;
  final String _email;
  final String _tipo;

  Usuario({
    required int id,
    required String nombre,
    required String apellido,
    required String dni,
    required String sexo,
    required String fechaNac,
    required String telefono,
    required String email,
    required String tipo,
  })  : _id = id,
        _nombre = nombre,
        _apellido = apellido,
        _dni = dni,
        _sexo = sexo,
        _fechaNac = fechaNac,
        _telefono = telefono,
        _email = email,
        _tipo = tipo;

  // Getters
  int get id => _id;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get dni => _dni;
  String get sexo => _sexo;
  String get fechaNac => _fechaNac;
  String get telefono => _telefono;
  String get email => _email;
  String get tipo => _tipo;

  // Factory constructor
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      dni: json['dni'],
      sexo: json['sexo'],
      fechaNac: json['fecha_nac'],
      telefono: json['telefono'],
      email: json['email'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'nombre': _nombre,
      'apellido': _apellido,
      'dni': _dni,
      'sexo': _sexo,
      'fecha_nac': _fechaNac,
      'telefono': _telefono,
      'email': _email,
      'tipo': _tipo,
    };
  }

  static List<Usuario> listFromJson(List<dynamic> data) {
    return data.map((item) => Usuario.fromJson(item)).toList();
  }
}
