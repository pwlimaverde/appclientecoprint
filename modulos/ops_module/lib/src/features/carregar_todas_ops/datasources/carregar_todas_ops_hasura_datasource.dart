import 'package:dependency_module/dependency_module.dart';

class CarregarTodasOpsDatasource implements Datasource<Stream<List<OpsModel>>> {
  @override
  Future<Stream<List<OpsModel>>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      print("CarregarTodasOpsDatasource ");
      final Snapshot snapshot =
          await Get.find<HasuraConnect>().subscription(opsAllQuery);

      return snapshot.map((event) {
        return (event['data']['ops'] as List).map((map) {
          return OpsModel.fromMap(map);
        }).toList();
      });
    } catch (e) {
      throw ErroCarregarTodasOps(
        message: "Falha ao carregar os dados: Ops não encontradas - Cod.03-1",
      );
    }
  }
}
