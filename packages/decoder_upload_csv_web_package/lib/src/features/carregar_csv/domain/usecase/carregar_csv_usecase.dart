import 'package:dependency_module/dependency_module.dart';

class CarregarCsvUsecase extends UseCaseImplement<List<String>> {
  final Datasource<List<String>> datasource;

  CarregarCsvUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<String>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
