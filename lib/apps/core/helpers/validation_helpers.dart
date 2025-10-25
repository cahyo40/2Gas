import 'dart:io';

class YoFormValidation {
  YoFormValidation._();
  static String? required(String? value, {required String field}) {
    if (value == null || value.trim().isEmpty) {
      return '$field tidak boleh kosong';
    }
    return null;
  }

  static String? minLength(String? value, int len, {required String field}) {
    if (value != null && value.length < len) {
      return '$field minimal $len karakter';
    }
    return null;
  }

  static String? maxLength(String? value, int len, {required String field}) {
    if (value != null && value.length > len) {
      return '$field maksimal $len karakter';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!reg.hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  static String? phoneID(String? value, {required String field}) {
    if (value == null || value.trim().isEmpty) return null;
    final reg = RegExp(r'^08[0-9]{8,11}$');
    if (!reg.hasMatch(value)) {
      return '$field harus diawali 08 dan 10-13 digit';
    }
    return null;
  }

  static String? password(String? value, {required String field}) {
    if (value == null || value.trim().isEmpty) return null;
    final reg = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!reg.hasMatch(value)) {
      return '$field minimal 8 karakter, terdiri dari huruf besar, kecil dan angka';
    }
    return null;
  }

  // minimal 8 karakter
  static String? passwordMin8(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 8) return 'Password minimal 8 karakter';
    return null;
  }

  // harus ada huruf kecil
  static String? passwordLowerCase(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password harus mengandung huruf kecil';
    }
    return null;
  }

  // harus ada huruf besar
  static String? passwordUpperCase(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password harus mengandung huruf besar';
    }
    return null;
  }

  // harus ada angka
  static String? passwordDigit(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'\d').hasMatch(value)) {
      return 'Password harus mengandung angka';
    }
    return null;
  }

  // harus ada karakter spesial
  static String? passwordSpecial(String? value) {
    if (value == null || value.isEmpty) return null;
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password harus mengandung karakter spesial';
    }
    return null;
  }

  static String? match(
    String? value,
    String? compare, {
    required String field,
  }) {
    if (value != compare) {
      return '$field tidak sama';
    }
    return null;
  }

  /* ==========================
   * VALIDASI GABUNGAN (CHAIN)
   * ========================== */

  /// Jalankan beberapa validasi sekaligus
  /// Contoh:
  /// ValidationHelper.chain(
  ///   value,
  ///   [
  ///     (v) => ValidationHelper.required(v, 'Nama'),
  ///     (v) => ValidationHelper.minLength(v, 3, 'Nama'),
  ///   ],
  /// );
  static String? chain(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final fn in validators) {
      final result = fn(value);
      if (result != null) return result;
    }
    return null;
  }

  static String? fileSize(File? file, double maxMB, [String? field]) {
    if (file == null) return null;
    final bytes = file.lengthSync();
    final mb = bytes / (1024 * 1024);
    if (mb > maxMB) {
      return '${field ?? 'File'} tidak boleh lebih dari ${maxMB}MB';
    }
    return null;
  }

  static String? fileExtension(
    File? file,
    List<String> allowed, [
    String? field,
  ]) {
    if (file == null) return null;
    final ext = file.path.split('.').last.toLowerCase();
    if (!allowed.map((e) => e.toLowerCase()).contains(ext)) {
      return '${field ?? 'File'} harus berformat ${allowed.join(', ')}';
    }
    return null;
  }
}
