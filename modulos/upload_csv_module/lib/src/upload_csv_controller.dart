import 'package:dependency_module/dependency_module.dart';

import 'utils/errors/erros_upload_csv.dart';

class UploadCsvController extends GetxController {
  final CarregarCsvUsecase carregarCsvUsecase;
  UploadCsvController({
    required this.carregarCsvUsecase,
  });

  @override
  void onReady() {
    super.onReady();
    _testeUpload();
  }

  final testeList = <List<String>>[].obs;

  Future<void> _testeUpload() async {
    try {
      final result = await carregarCsvUsecase(
        parameters: NoParams(
            error: ErroUploadCsv(message: 'teste upload erro'),
            showRuntimeMilliseconds: true,
            nameFeature: "Teste upload Csv"),
      );
      if (result is SuccessReturn<List<String>>) {
        coreModuleController.message(
          MessageModel.info(
            title: "Teste sucesso",
            message: "Arquivo lido com sucesso!",
          ),
        );
      } else {
        coreModuleController.message(
          MessageModel.error(
            message: 'Teste Erro',
            title: 'Erro ao Ler o arquivo!',
          ),
        );
      }
    } catch (e) {
      coreModuleController.message(
        MessageModel.error(
          message: 'Teste Erro catch',
          title: 'Erro ao Ler o arquivo!',
        ),
      );
    }
  }
}
