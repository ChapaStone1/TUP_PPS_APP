class ConsultaMedica {
  final String _fecha;
  final String _medicacion;
  final String _nota;

  final int _medicoId;
  final String _medicoNombre;
  final String _medicoApellido;

  ConsultaMedica({
    required String fecha,
    required String medicacion,
    required String nota,
    required int medicoId,
    required String medicoNombre,
    required String medicoApellido,
  })  : _fecha = fecha,
        _medicacion = medicacion,
        _nota = nota,
        _medicoId = medicoId,
        _medicoNombre = medicoNombre,
        _medicoApellido = medicoApellido;

  // Getters
  String get fecha => _fecha;
  String get medicacion => _medicacion;
  String get nota => _nota;

  int get medicoId => _medicoId;
  String get medicoNombre => _medicoNombre;
  String get medicoApellido => _medicoApellido;

  // Factory
  factory ConsultaMedica.fromJson(Map<String, dynamic> json) {
    return ConsultaMedica(
      fecha: json['fecha'],
      medicacion: json['medicacion'],
      nota: json['nota'],
      medicoId: json['medico']['id'],
      medicoNombre: json['medico']['nombre'],
      medicoApellido: json['medico']['apellido'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fecha': _fecha,
      'medicacion': _medicacion,
      'nota': _nota,
      'medico': {
        'id': _medicoId,
        'nombre': _medicoNombre,
        'apellido': _medicoApellido,
      },
    };
  }

  static List<ConsultaMedica> listFromJson(List<dynamic> data) {
    return data.map((item) => ConsultaMedica.fromJson(item)).toList();
  }
}
