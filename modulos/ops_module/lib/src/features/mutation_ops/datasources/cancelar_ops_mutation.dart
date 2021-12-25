import 'package:dependency_module/dependency_module.dart';
import 'package:ops_module/src/utils/parametros/parametros.dart';

import '../../../utils/documents/ops_document.dart';
import '../../../utils/errors/erros_ops.dart';

class CancelarOpsMutationDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosCancelarOpsMutation) {
        final result = await Get.find<HasuraConnect>().mutation(opsCanMutation,
            variables: {
              "op": parameters.model.op,
              "cancelada": !parameters.model.cancelada
            });

        print(result);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw ErroCarregarTodasOps(
        message: "Falha ao carregar os dados: Ops não encontradas - Cod.03-1",
      );
    }
  }
}
