import 'package:dependency_module/dependency_module.dart';

class CarregarTodasOpsUsecase extends UseCaseImplement<Stream<List<OpsModel>>> {
  final Datasource<Stream<List<OpsModel>>> datasource;

  CarregarTodasOpsUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<Stream<List<OpsModel>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
