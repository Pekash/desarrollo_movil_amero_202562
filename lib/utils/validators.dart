// utils/validators.dart
class Validadores {
  static String? validarCedula(String? valor) {
    if (valor == null || valor.isEmpty) return 'Ingrese la cedula';
    if (valor.length != 10) return 'La cedula debe tener 10 numeros';
    if (!RegExp(r'^\d+$').hasMatch(valor)) return 'Solo numeros en la cedula';
    int provincia = int.parse(valor.substring(0, 2));
    if (provincia < 1 || (provincia > 24 && provincia != 30)) return 'Codigo de provincia invalido';
    int tercerDigito = int.parse(valor[2]);
    if (tercerDigito >= 6) return 'El tercer digito debe ser menor a 6';
    List<int> digitos = valor.split('').map((e) => int.parse(e)).toList();
    int suma = 0;
    for (int i = 0; i < 9; i++) {
      int resultado = digitos[i];
      if (i % 2 == 0) {
        resultado = digitos[i] * 2;
        if (resultado >= 10) resultado -= 9;
      }
      suma += resultado;
    }
    int ultimoDigito = suma % 10;
    int digitoVerificador = ultimoDigito == 0 ? 0 : 10 - ultimoDigito;
    if (digitoVerificador != digitos[9]) return 'Cedula invalida - digito verificador incorrecto';
    return null;
  }

  static String? validarCorreo(String? valor) {
    if (valor == null || valor.isEmpty) return 'El correo electronico es obligatorio';
    final partes = valor.split('@');
    if (partes.length != 2 || partes[1].isEmpty || !partes[1].contains('.')) return 'El correo debe contener un dominio';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(valor)) return 'Formato de correo electronico invalido';
    if (valor.contains('..')) return 'El correo no puede contener puntos consecutivos';
    if (valor.startsWith('.') || valor.endsWith('.')) return 'El correo no puede empezar o terminar con punto';
    return null;
  }

  static String? validarContrasena(String? valor) {
    if (valor == null || valor.isEmpty) return 'La contraseña es obligatoria';
    if (valor.contains(' ')) return 'La contraseña no puede contener espacios';
    if (!RegExp(r'[A-Z]').hasMatch(valor)) return 'Debe contener al menos una letra mayuscula';
    if (!RegExp(r'[0-9]').hasMatch(valor)) return 'Debe contener al menos un numero';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\;/`~]').hasMatch(valor)) return 'Debe contener al menos un caracter especial';
    if (valor.length < 8) return 'La contrasena debe tener al menos 8 caracteres';
    return null;
  }

  static String? validarNombres(String? valor) {
    if (valor == null || valor.trim().isEmpty) return 'Los nombres son requeridos';
    if (valor.trim().split(RegExp(r'\s+')).length < 2) return 'Ingrese nombres y apellidos';
    return null;
  }

  static String? Function(String?) confirmarContrasena(String original) {
    return (String? valor) {
      if (valor == null || valor.isEmpty) return 'Confirma tu contraseña';
      if (valor != original) return 'Las contraseñas no coinciden';
      return null;
    };
  }
}