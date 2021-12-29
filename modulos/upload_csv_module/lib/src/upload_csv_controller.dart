import 'package:dependency_module/dependency_module.dart';

import 'utils/errors/erros_upload_csv.dart';

class UploadCsvController extends GetxController {
  final CarregarCsvUsecase carregarCsvUsecase;
  final ProcessarCsvUsecase processarCsvUsecase;
  UploadCsvController({
    required this.carregarCsvUsecase,
    required this.processarCsvUsecase,
  });

  @override
  void onReady() {
    super.onReady();
    uploadCsvOps();
  }

  final uploadCsvOpsList = <OpsModel>[].obs;

  Future<void> uploadCsvOps() async {
    try {
      final stringList = await carregarCsvUsecase(
        parameters: NoParams(
            error: ErroUploadCsv(
              message: 'Erro ao carregar o arquivo CSV',
            ),
            showRuntimeMilliseconds: true,
            nameFeature: "Upload Csv"),
      );
      if (stringList is SuccessReturn<List<String>>) {
        final opsProcessadas = await processarCsvUsecase(
          parameters: ParametrosProcessarCsvEmOps(
            listaBruta: stringList.result,
            nameFeature: "Processamento Csv",
            showRuntimeMilliseconds: true,
            error: ErroProcessamentoCsv(
              message: 'Erro ao processar o arquivo CSV',
            ),
          ),
        );

        if (opsProcessadas is SuccessReturn<Map<String, List<OpsModel>>>) {
          // print("listOps - ${opsProcessadas.result["listOps"]?.length}");
          print("listOps - ${opsProcessadas.result["listOpsError"]?[0].op}");
          print(
              "listOpsError - ${opsProcessadas.result["listOpsError"]?.length}");

          uploadCsvOpsList(opsProcessadas.result["listOpsError"]);
        }

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
            title: 'Erro ao Ler o arquivo! 2',
          ),
        );
      }
    } catch (e) {
      coreModuleController.message(
        MessageModel.error(
          message: 'Teste Erro catch',
          title: 'Erro ao Ler o arquivo!3',
        ),
      );
    }
  }
}
