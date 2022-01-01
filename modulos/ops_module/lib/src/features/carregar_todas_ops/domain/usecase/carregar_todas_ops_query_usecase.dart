import 'package:dependency_module/dependency_module.dart';

class CarregarTodasOpsQueryUsecase extends UseCaseImplement<List<OpsModel>> {
  final Datasource<List<OpsModel>> datasource;

  CarregarTodasOpsQueryUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<OpsModel>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
