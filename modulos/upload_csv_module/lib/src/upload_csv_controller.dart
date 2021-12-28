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
    _uploadCsvOps();
  }

  final uploadCsvOpsList = <OpsModel>[].obs;

  String _convertMes(String mes) {
    switch (mes) {
      case "jan":
        return "01";
      case "fev":
        return "02";
      case "mar":
        return "03";
      case "abr":
        return "04";
      case "mai":
        return "05";
      case "jun":
        return "06";
      case "jul":
        return "07";
      case "ago":
        return "08";
      case "set":
        return "09";
      case "out":
        return "10";
      case "nov":
        return "11";
      default:
        return "12";
    }
  }

  Future<void> _uploadCsvOps() async {
    try {
      final ano =
          designSystemController.formatAno.format(designSystemController.now);
      final stringList = await carregarCsvUsecase(
        parameters: NoParams(
            error: ErroUploadCsv(message: 'teste upload erro'),
            showRuntimeMilliseconds: true,
            nameFeature: "Teste upload Csv"),
      );
      if (stringList is SuccessReturn<List<String>>) {
        List<OpsModel> listOps = [];

        for (String item in stringList.result) {
          try {
            if (item.isNotEmpty) {
              List<String> i2 = item
                  .replaceAll("\r\n", " | ")
                  .trim()
                  .replaceAll('$ano,', '$ano","')
                  .replaceAll(',","', '","')
                  .replaceFirst(',', ',"')
                  .trim()
                  .split(',"');

              String entrada = i2[4]
                  .substring(i2[4].indexOf('",') + 2)
                  .replaceAll('"', '')
                  .trim();
              DateTime entradaFD = DateTime.parse(
                "${entrada.substring(6, 10)}-${entrada.substring(3, 5)}-${entrada.substring(0, 2)}",
              );
              String voe = i2[5];
              String oe = voe.substring(voe.indexOf(',') + 1);
              String op = oe.substring(0, oe.indexOf(','));
              String entrega = oe.substring(oe.indexOf(',') + 1);
              String entregaOk = "${entrega.substring(0, 6)}-$ano";
              DateTime entregaFD = DateTime.parse(
                "${entregaOk.substring(7, 11)}-${_convertMes(entregaOk.substring(3, 6))}-${entregaOk.substring(0, 2)}",
              );

              OpsModel up = OpsModel(
                orcamento: int.parse(i2[0].replaceAll("|", " ").trim()),
                cliente: i2[1].replaceAll('"', '').trim(),
                servico: i2[2].replaceAll('"', '').trim(),
                quant: int.parse(i2[3]
                    .replaceAll('"', '')
                    .replaceAll(',00', '')
                    .replaceAll('.', '')
                    .trim()),
                entrada: entradaFD,
                vendedor: voe
                    .substring(0, voe.indexOf(','))
                    .replaceAll('"', '')
                    .trim(),
                op: int.parse(op),
                entrega: entregaFD,
                cancelada: false,
              );

              listOps.add(up);
            }
          } catch (e) {
            coreModuleController.message(
              MessageModel.error(
                message: 'Erro ao processa a op!',
                title: 'Erro de upload',
              ),
            );
          }
        }

        uploadCsvOpsList(listOps);

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
