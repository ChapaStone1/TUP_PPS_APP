class HistoriaClinica {
  final int _id;
  final String _fecha;
  final String _nota;
  final String _medicacion;
  final String _medicoNombre;
  final String _medicoApellido;
  final String _consultorio;
  final String _especialidad;

  HistoriaClinica({
    required int id,
    required String fecha,
    required String nota,
    required String medicacion,
    required String medicoNombre,
    required String medicoApellido,
    required String consultorio,
    required String especialidad,
  })  : _id = id,
        _fecha = fecha,
        _nota = nota,
        _medicacion = medicacion,
        _medicoNombre = medicoNombre,
        _medicoApellido = medicoApellido,
        _consultorio = consultorio,
        _especialidad = especialidad;

  // Getters
  int get id => _id;
  String get fecha => _fecha;
  String get nota => _nota;
  String get medicacion => _medicacion;
  String get medicoNombre => _medicoNombre;
  String get medicoApellido => _medicoApellido;
  String get consultorio => _consultorio;
  String get especialidad => _especialidad;

  // Factory
  factory HistoriaClinica.fromJson(Map<String, dynamic> json) {
    return HistoriaClinica(
      id: json['id'],
      fecha: json['fecha'],
      nota: json['nota'],
      medicacion: json['medicacion'],
      medicoNombre: json['medico_nombre'] ??
          json['medicoNombre'] ??
          '', // se adapta a posible clave
      medicoApellido: json['medico_apellido'] ?? json['medicoApellido'] ?? '',
      consultorio: json['consultorio'],
      especialidad: json['especialidad'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'fecha': _fecha,
      'nota': _nota,
      'medicacion': _medicacion,
      'medico_nombre': _medicoNombre,
      'medico_apellido': _medicoApellido,
      'consultorio': _consultorio,
      'especialidad': _especialidad,
    };
  }

  static List<HistoriaClinica> listFromJson(List<dynamic> data) {
    return data.map((item) => HistoriaClinica.fromJson(item)).toList();
  }
}
