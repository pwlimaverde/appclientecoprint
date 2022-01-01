import 'package:dependency_module/dependency_module.dart';

class ParametrosUploadOps implements ParametersReturnResult {
  final List<OpsModel> listaOpsCarregadas;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosUploadOps({
    required this.listaOpsCarregadas,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
