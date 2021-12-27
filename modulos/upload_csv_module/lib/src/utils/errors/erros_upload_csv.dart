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
