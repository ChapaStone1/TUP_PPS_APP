class GeneralValidator {
  static String? campoRequerido(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo requerido';
    }
    return null;
  }

  static String? validarEmail(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo requerido';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(valor)) {
      return 'Correo inválido';
    }
    return null;
  }

  static String? validarFecha(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo requerido';
    }

    // Verifica formato YYYY-MM-DD
    final exp = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!exp.hasMatch(valor)) {
      return 'Formato inválido (YYYY-MM-DD)';
    }

    try {
      DateTime.parse(valor);
    } catch (e) {
      return 'Fecha inválida';
    }

    return null;
  }

  static String? validarDNI(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo requerido';
    }
    if (!RegExp(r'^\d{7,8}$').hasMatch(valor)) {
      return 'DNI inválido';
    }
    return null;
  }

  static String? validarTelefono(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo requerido';
    }
    if (!RegExp(r'^\d{6,15}$').hasMatch(valor)) {
      return 'Teléfono inválido';
    }
    return null;
  }

  static String? validarPassword(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo requerido';
    }

    if (valor.length < 6) {
      return 'Debe tener al menos 6 caracteres';
    }

    if (valor.contains('ñ') || valor.contains('Ñ')) {
      return 'La contraseña no puede contener la letra ñ';
    }

    final tieneLetra = RegExp(r'[A-Za-z]').hasMatch(valor);
    final tieneNumero = RegExp(r'[0-9]').hasMatch(valor);

    if (!tieneLetra || !tieneNumero) {
      return 'Debe contener al menos una letra y un número';
    }

    return null;
  }

  static String? validarDropdown(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return 'Campo requerido';
    }
    return null;
  }

  static String? validarDropdownEspecialidad(int? valor) {
    if (valor == null) {
      return 'Seleccioná una especialidad'; // mensaje de error
    }
    return null; // es válido
  }
}
