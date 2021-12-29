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
  final uploadCsvOpsListError = <OpsModel>[].obs;

  Future<void> uploadCsvOps() async {
    try {
      final stringList = await carregarCsvUsecase(
        parameters: NoParams(
            error: ErroUploadCsv(
              message: 'Erro ao carregar o arquivo CSV',
            ),
            showRuntimeMilliseconds: false,
            nameFeature: "Upload Csv"),
      );
      if (stringList is SuccessReturn<List<String>>) {
        final opsProcessadas = await processarCsvUsecase(
          parameters: ParametrosProcessarCsvEmOps(
            listaBruta: stringList.result,
            nameFeature: "Processamento Csv",
            showRuntimeMilliseconds: false,
            error: ErroProcessamentoCsv(
              message: 'Erro ao processar o arquivo CSV',
            ),
          ),
        );

        if (opsProcessadas is SuccessReturn<Map<String, List<OpsModel>>>) {
          uploadCsvOpsList(opsProcessadas.result["listOps"]);
          uploadCsvOpsListError(opsProcessadas.result["listOpsError"]);
          coreModuleController.message(
            MessageModel.info(
              title: "Processamento de OPS",
              message:
                  "${opsProcessadas.result["listOps"]?.length} Processadas com Sucesso! \n ${opsProcessadas.result["listOpsError"]?.length} Processadas com Erro!",
            ),
          );
        } else {
          coreModuleController.message(
            MessageModel.error(
              title: 'Processamento de OPS',
              message: 'Erro ao processar as OPS!',
            ),
          );
        }
      } else {
        coreModuleController.message(
          MessageModel.error(
            title: 'Carregamento de arquivo CVS',
            message:
                'Erro ao carregar o arquivo - ${stringList.fold(success: (value) => value.result, error: (erro) => erro.error)}',
          ),
        );
      }
    } catch (e) {
      coreModuleController.message(
        MessageModel.error(
          title: 'Erro Upload CSV',
          message: 'Erro ao fazer o upload das OPS - Erro: $e',
        ),
      );
    }
  }
}
