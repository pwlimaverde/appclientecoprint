import 'package:dependency_module/dependency_module.dart';

class ParametrosCancelarOpsMutation implements ParametersReturnResult {
  final OpsModel model;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosCancelarOpsMutation({
    required this.model,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
