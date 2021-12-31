import 'package:dependency_module/dependency_module.dart';

class OpsInsertMutationHasuraDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosOpsMutation) {
        final result = await Get.find<HasuraConnect>()
            .mutation(parameters.mutation, variables: parameters.variables);
        if (result["data"]["insert_ops"]["affected_rows"].toString() == "1") {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      throw ErroCarregarTodasOps(
        message: "Falha ao alterar os dados: Op não encontrada - Cod.03-1",
      );
    }
  }
}
