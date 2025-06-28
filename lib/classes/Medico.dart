// ignore_for_file: non_constant_identifier_names

class Medico {
  final int _id;
  final String _nombre;
  final String _apellido;
  final String _dni;
  final String _sexo;
  final String _fechaNac;
  final String _telefono;
  final String _email;
  final String _matricula;
  final String _consultorio;
  final int? _especialidadId;
  final String _especialidad_nombre;
  final bool _habilitado;

  Medico({
    required int id,
    required String nombre,
    required String apellido,
    required String dni,
    required String sexo,
    required String fechaNac,
    required String telefono,
    required String email,
    required String matricula,
    required String consultorio,
    int? especialidadId,
    required String especialidad_nombre,
    required bool habilitado,
  })  : _id = id,
        _nombre = nombre,
        _apellido = apellido,
        _dni = dni,
        _sexo = sexo,
        _fechaNac = fechaNac,
        _telefono = telefono,
        _email = email,
        _matricula = matricula,
        _consultorio = consultorio,
        _especialidadId = especialidadId,
        _especialidad_nombre =
            especialidad_nombre, // <- FALTABA ESTE PUNTO Y COMA
        _habilitado = habilitado;

  // Getters
  int get id => _id;
  String get nombre => _nombre;
  String get apellido => _apellido;
  String get dni => _dni;
  String get sexo => _sexo;
  String get fechaNac => _fechaNac;
  String get telefono => _telefono;
  String get email => _email;
  String get matricula => _matricula;
  String get consultorio => _consultorio;
  int? get especialidadId => _especialidadId;
  String get especialidad_nombre => _especialidad_nombre;
  bool get habilitado => _habilitado;

  // Factory
  factory Medico.fromJson(Map<String, dynamic> json) {
    return Medico(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      dni: json['dni'],
      sexo: json['sexo'],
      fechaNac: json['fecha_nac'],
      telefono: json['telefono'],
      email: json['email'],
      matricula: json['matricula'],
      consultorio: json['consultorio'],
      especialidadId: json['especialidad'] is Map
          ? json['especialidad']['id']
          : json['especialidad_id'],
      especialidad_nombre: json['especialidad_nombre'] ?? 'Sin especialidad',
      habilitado: json['habilitado'] == 1, // <-- cambio clave
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': _nombre,
      'apellido': _apellido,
      'dni': _dni,
      'sexo': _sexo,
      'fecha_nac': _fechaNac,
      'telefono': _telefono,
      'email': _email,
      'matricula': _matricula,
      'consultorio': _consultorio,
      'especialidad_id': _especialidadId,
      'especialidad_nombre': _especialidad_nombre,
    };
  }

  static List<Medico> listFromJson(List<dynamic> data) {
    return data.map((item) => Medico.fromJson(item)).toList();
  }
}
