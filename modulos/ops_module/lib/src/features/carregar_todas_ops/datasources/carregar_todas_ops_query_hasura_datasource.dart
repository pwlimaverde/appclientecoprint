import 'package:dependency_module/dependency_module.dart';

class CarregarTodasOpsQueryDatasource implements Datasource<List<OpsModel>> {
  @override
  Future<List<OpsModel>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      final result = await Get.find<HasuraConnect>().query(opsAllQuery);

      return (result['data']['ops'] as List)
          .map((map) => OpsModel.fromMap(map))
          .toList();
    } catch (e) {
      throw ErroCarregarTodasOps(
        message: "Falha ao carregar os dados: Ops não encontradas - Cod.03-1",
      );
    }
  }
}
