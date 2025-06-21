class HistoriaClinica {
  final int _id;
  final String _fecha;
  final String _nota;
  final String _medicacion;
  final String _medico;
  final String _consultorio;
  final String _especialidad;

  HistoriaClinica({
    required int id,
    required String fecha,
    required String nota,
    required String medicacion,
    required String medico,
    required String consultorio,
    required String especialidad,
  })  : _id = id,
        _fecha = fecha,
        _nota = nota,
        _medicacion = medicacion,
        _medico = medico,
        _consultorio = consultorio,
        _especialidad = especialidad;

  // Getters
  int get id => _id;
  String get fecha => _fecha;
  String get nota => _nota;
  String get medicacion => _medicacion;
  String get medico => _medico;
  String get consultorio => _consultorio;
  String get especialidad => _especialidad;

  // Factory
  factory HistoriaClinica.fromJson(Map<String, dynamic> json) {
    return HistoriaClinica(
      id: json['id'],
      fecha: json['fecha'],
      nota: json['nota'],
      medicacion: json['medicacion'],
      medico: json['medico'],
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
      'medico': _medico,
      'consultorio': _consultorio,
      'especialidad': _especialidad,
    };
  }

  static List<HistoriaClinica> listFromJson(List<dynamic> data) {
    return data.map((item) => HistoriaClinica.fromJson(item)).toList();
  }
}
