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
    uploadCsvOps();
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

  List<String> _processamentoCsv({required String listaBruta}) {
    try {
      List<String> listaProcessamentoInicial = listaBruta
          .replaceAll("\r\n", " | ")
          .trim()
          .replaceAll('${designSystemController.ano},',
              '${designSystemController.ano}","')
          .replaceAll(',","', '","')
          .replaceFirst(',', ',"')
          .trim()
          .split(',"');
      return listaProcessamentoInicial;
    } catch (e) {
      coreModuleController.message(
        MessageModel.error(
          title:
              'Erro ao processar a OP. Parâmetros incarretos: ${listaBruta.substring(0, 5)}',
          message: 'Teste Erro',
        ),
      );
      return [];
    }
  }

  DateTime? _processamentoCsvEntrada({
    required List<String> listaProcessamentoInicial,
  }) {
    try {
      String entradaBruta = listaProcessamentoInicial[4]
          .substring(listaProcessamentoInicial[4].indexOf('",') + 2)
          .replaceAll('"', '')
          .trim();
      DateTime? entradaProcessada = DateTime.parse(
        "${entradaBruta.substring(6, 10)}-${entradaBruta.substring(3, 5)}-${entradaBruta.substring(0, 2)}",
      );
      return entradaProcessada;
    } catch (e) {
      return null;
    }
  }

  int? _processamentoCsvOp({
    required List<String> listaProcessamentoInicial,
  }) {
    try {
      String voe = listaProcessamentoInicial[5];
      String oe = voe.substring(voe.indexOf(',') + 1);
      int? op = int.parse(oe.substring(0, oe.indexOf(',')));
      return op;
    } catch (e) {
      return null;
    }
  }

  int? _processamentoCsvOrcamento({
    required List<String> listaProcessamentoInicial,
  }) {
    try {
      int? orcamento =
          int.parse(listaProcessamentoInicial[0].replaceAll("|", " ").trim());
      return orcamento;
    } catch (e) {
      return null;
    }
  }

  int? _processamentoCsvQuantidade({
    required List<String> listaProcessamentoInicial,
  }) {
    try {
      int? quantidade = int.parse(listaProcessamentoInicial[3]
          .replaceAll('"', '')
          .replaceAll(',00', '')
          .replaceAll('.', '')
          .trim());
      return quantidade;
    } catch (e) {
      return null;
    }
  }

  String? _processamentoCsvServico({
    required List<String> listaProcessamentoInicial,
  }) {
    try {
      String? servico = listaProcessamentoInicial[2].replaceAll('"', '').trim();
      return servico;
    } catch (e) {
      return null;
    }
  }

  String? _processamentoCsvCliente({
    required List<String> listaProcessamentoInicial,
  }) {
    try {
      String? cliente = listaProcessamentoInicial[1].replaceAll('"', '').trim();
      return cliente;
    } catch (e) {
      return null;
    }
  }

  String? _processamentoCsvVendedor({
    required List<String> listaProcessamentoInicial,
  }) {
    try {
      String voe = listaProcessamentoInicial[5];
      String vendedor =
          voe.substring(0, voe.indexOf(',')).replaceAll('"', '').trim();
      return vendedor;
    } catch (e) {
      return null;
    }
  }

  DateTime? _processamentoCsvEntrega({
    required List<String> listaProcessamentoInicial,
    required DateTime? entrada,
  }) {
    try {
      String voe = listaProcessamentoInicial[5];
      String oe = voe.substring(voe.indexOf(',') + 1);

      String entregaBruta =
          "${oe.substring(oe.indexOf(',') + 1).substring(0, 6)}-${designSystemController.ano}";

      DateTime entregaProcessada = DateTime.parse(
        "${entregaBruta.substring(7, 11)}-${_convertMes(entregaBruta.substring(3, 6))}-${entregaBruta.substring(0, 2)}",
      );

      if (entrada != null && entrada.month > entregaProcessada.month) {
        entregaProcessada = DateTime.parse(
          "${(int.parse(designSystemController.ano) + 1).toString()}-${_convertMes(entregaBruta.substring(3, 6))}-${entregaBruta.substring(0, 2)}",
        );
      }

      return entregaProcessada;
    } catch (e) {
      return null;
    }
  }

  Future<void> uploadCsvOps() async {
    try {
      final stringList = await carregarCsvUsecase(
        parameters: NoParams(
            error: ErroUploadCsv(message: 'teste upload erro'),
            showRuntimeMilliseconds: true,
            nameFeature: "Teste upload Csv"),
      );
      if (stringList is SuccessReturn<List<String>>) {
        List<OpsModel> listOps = [];

        for (String item in stringList.result) {
          List<String> i2 = _processamentoCsv(listaBruta: item);

          if (i2.isNotEmpty) {
            DateTime? entrada = _processamentoCsvEntrada(
              listaProcessamentoInicial: i2,
            );
            DateTime? entrega = _processamentoCsvEntrega(
              listaProcessamentoInicial: i2,
              entrada: entrada,
            );
            int? op = _processamentoCsvOp(
              listaProcessamentoInicial: i2,
            );
            int? orcamento = _processamentoCsvOrcamento(
              listaProcessamentoInicial: i2,
            );
            int? quantidade = _processamentoCsvQuantidade(
              listaProcessamentoInicial: i2,
            );
            String? servico = _processamentoCsvServico(
              listaProcessamentoInicial: i2,
            );
            String? cliente = _processamentoCsvCliente(
              listaProcessamentoInicial: i2,
            );
            String? vendedor = _processamentoCsvVendedor(
              listaProcessamentoInicial: i2,
            );

            if (entrada != null &&
                entrega != null &&
                op != null &&
                orcamento != null &&
                quantidade != null &&
                servico != null &&
                cliente != null &&
                vendedor != null) {
              OpsModel up = OpsModel(
                orcamento: orcamento,
                cliente: cliente,
                servico: servico,
                entrada: entrada,
                entrega: entrega,
                op: op,
                quant: quantidade,
                vendedor: vendedor,
                cancelada: false,
              );
              listOps.add(up);
            }
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
