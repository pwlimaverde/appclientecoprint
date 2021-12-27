import 'package:dependency_module/dependency_module.dart';

class MutationOpsUsecase extends UseCaseImplement<bool> {
  final Datasource<bool> datasource;

  MutationOpsUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<bool>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
