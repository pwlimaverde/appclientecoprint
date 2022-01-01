import 'package:dependency_module/dependency_module.dart';

class ProcessarCsvUsecase
    extends UseCaseImplement<Map<String, List<OpsModel>>> {
  final Datasource<Map<String, List<OpsModel>>> datasource;

  ProcessarCsvUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<Map<String, List<OpsModel>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
