import 'package:dependency_module/dependency_module.dart';

class ErroCarregarTodasOps implements AppError {
  @override
  String message;
  ErroCarregarTodasOps({
    required this.message,
  });

  @override
  String toString() {
    return "ErroCarregarTodasOps - $message";
  }
}

class ErroCancelarOp implements AppError {
  @override
  String message;
  ErroCancelarOp({
    required this.message,
  });

  @override
  String toString() {
    return "ErroCarregarTodasOps - $message";
  }
}
