import 'package:dependency_module/dependency_module.dart';

import '../../../utils/parametros/parametros_upload_csv_module.dart';

class UploadOpsDatasource implements Datasource<Map<String, List<OpsModel>>> {
  @override
  Future<Map<String, List<OpsModel>>> call(
      {required ParametersReturnResult parameters}) {
    try {
      if (parameters is ParametrosUploadOps) {
        List<OpsModel> listOpsNovas = [];
        List<OpsModel> listOpsUpdate = [];
        List<OpsModel> listOpsDuplicadas = [];
        for (OpsModel op in parameters.listaOpsCarregadas) {
          final consultaOp = opsController.opsListAllCompleta.where(
            (element) => element.op == op.op,
          );
          if (consultaOp.isEmpty) {
            listOpsNovas.add(op);
          } else if (consultaOp.first != op) {
            listOpsUpdate.add(op);
          } else {
            listOpsDuplicadas.add(op);
          }
        }
        return Future.value({
          "listOpsNovas": listOpsNovas,
          "listOpsUpdate": listOpsUpdate,
          "listOpsDuplicadas": listOpsDuplicadas,
        });
      } else {
        throw Exception("Erro ao fazer a triagem das OPS");
      }
    } catch (e) {
      throw Exception("Erro ao fazer a triagem das OPS");
    }
  }
}
