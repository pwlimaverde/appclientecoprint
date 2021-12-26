import 'package:dependency_module/dependency_module.dart';

class ParametrosOpsMutation implements ParametersReturnResult {
  final String mutation;
  final Map<String, dynamic> variables;
  final MessageModel messageInfo;
  final MessageModel messageError;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosOpsMutation({
    required this.mutation,
    required this.variables,
    required this.messageInfo,
    required this.messageError,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
