import 'package:dependency_module/dependency_module.dart';

class ErroUploadCsv implements AppError {
  @override
  String message;
  ErroUploadCsv({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadCsv - $message";
  }
}

class ErroProcessamentoCsv implements AppError {
  @override
  String message;
  ErroProcessamentoCsv({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadCsv - $message";
  }
}

class ErroUploadOps implements AppError {
  @override
  String message;
  ErroUploadOps({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadOps - $message";
  }
}
