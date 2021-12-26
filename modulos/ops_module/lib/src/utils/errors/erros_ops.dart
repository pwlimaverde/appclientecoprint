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

class ErroMutationOp implements AppError {
  @override
  String message;
  ErroMutationOp({
    required this.message,
  });

  @override
  String toString() {
    return "ErroMutationOp - $message";
  }
}
