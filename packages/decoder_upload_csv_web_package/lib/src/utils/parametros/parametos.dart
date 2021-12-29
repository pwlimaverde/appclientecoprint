import 'package:dependency_module/dependency_module.dart';

class ParametrosProcessarCsvEmOps implements ParametersReturnResult {
  final List<String> listaBruta;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosProcessarCsvEmOps({
    required this.listaBruta,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
