import 'dart:typed_data';

import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'widgets/botoes/botao_form/botao_form_widget.dart';
import 'widgets/botoes/botao_limpar/botao_limpar_widget.dart';
import 'widgets/botoes/botao_print/botao_print_widget.dart';
import 'widgets/botoes/botao_search/botao_search_widget.dart';
import 'widgets/forms/form_geral/form_geral_widget.dart';
import 'widgets/header/header_widget.dart';
import 'widgets/menu/menu_widget.dart';
import 'widgets/opslist/opslist_print_widget.dart';
import 'widgets/opslist/opslist_widget.dart';
import 'widgets/right/right_widget.dart';

class DesignSystemController extends GetxController {
  //Widgets Pages
  Scaffold scaffold({
    required Widget body,
    required int page,
    required BuildContext context,
  }) {
    coreModuleController.getQuery(context: context);

    return Scaffold(
      drawer: coreModuleController.showMenu
          ? Drawer(
              child: MenuWidget(
                page: page,
              ),
            )
          : null,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(hederHeight),
        child: HeaderWidget(
          titulo: "Sistema Ecoprint",
          actions: coreModuleController.pageAtual.value == 2
              ? <Widget>[
                  _iconButtonSearch(),
                  _iconButtonPrint(),
                ]
              : [],
        ),
      ),
      backgroundColor: Get.theme.primaryColor,
      body: Column(
        children: <Widget>[
          Obx(() {
            return _body(
              body: body,
              page: page,
            );
          }),
        ],
      ),
    );
  }

  Widget _iconButtonSearch() {
    return Obx(
      () {
        return opsController.buscando.value
            ? BotaoForm(
                form: FormGeral(
                  controllerText: opsController.crtlBusca,
                  hintText: "Digite a busca",
                  labelText: "Busca",
                  onChanged: (String value) {
                    opsController.busca(value);
                  },
                ),
                button: BotaoLimpar(
                  size: 20,
                  onPressed: _setLimpar,
                ),
              )
            : BotaoSearch(
                size: 20,
                onPressed: _setBuscando,
              );
      },
    );
  }

  Widget _iconButtonPrint() {
    return Obx(
      () {
        return opsController.indexPrint.value != 4
            ? BotaoPrint(
                size: 20,
                ativo: true,
                onPressed: _showPrintDialog,
              )
            : const BotaoPrint(
                size: 20,
                ativo: false,
              );
      },
    );
  }

  void _setBuscando() {
    opsController.buscando(!opsController.buscando.value);
  }

  void _setLimpar() {
    opsController.crtlBusca.clear();
    opsController.busca.value = null;
    _setBuscando();
  }

  Widget _body({
    required Widget body,
    required int page,
  }) {
    return SizedBox(
      width: coreModuleController.size,
      height: coreModuleController.sizeH,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          coreModuleController.showMenu
              ? RightWidget(
                  widget: SizedBox(
                    width: coreModuleController.sizeW,
                    height: coreModuleController.sizeH,
                    child: body,
                  ),
                  menuWidth: menuWidth,
                  showMenu: coreModuleController.showMenu,
                  sizeW: coreModuleController.sizeW,
                )
              : Row(
                  children: <Widget>[
                    MenuWidget(
                      page: page,
                    ),
                    RightWidget(
                      widget: SizedBox(
                        width: coreModuleController.sizeW,
                        height: coreModuleController.sizeH,
                        child: body,
                      ),
                      menuWidth: menuWidth,
                      showMenu: coreModuleController.showMenu,
                      sizeW: coreModuleController.sizeW,
                    ),
                  ],
                )
        ],
      ),
    );
  }

  pw.Widget opslistPrintWidget({
    required filtro,
  }) {
    return OpslistPrintWidget(
      filtro: filtro,
    );
  }

  //Widgets OpsList
  Widget opslistWidget({
    required filtro,
    required check,
    required Function(OpsModel) can,
    required Function(OpsModel) prioridade,
    required save,
    required up,
  }) {
    return OpslistWidget(
      up: up,
      showMenu: coreModuleController.showMenu,
      filtro: filtro,
      check: (OpsModel o) {
        setOpCheck(o);
        check(o);
        setOpCheckCan();
      },
      can: (OpsModel o) {
        setOpCan(o);
        can(o);
        setOpCanCan();
      },
      save: (OpsModel o) {
        save(o);
      },
      prioridade: (OpsModel o) {
        setOpPrioridadeCheck(o);
        prioridade(o);
        setOpPrioridadeCheckCan();
      },
    );
  }

  //Controle OpsList
  DateTime now = DateTime.now();
  final f = DateFormat('dd/MM/yy');
  final f2 = DateFormat('dd/MM');
  final fc = DateFormat('dd/MM/yyyy');
  final df = DateFormat('yyyy/MM/dd');
  final numMilhar = NumberFormat(",##0", "pt_BR");

  final colorCrtRyobi = false.obs;

  void setColorCrtRyobi(bool crt) {
    colorCrtRyobi(crt);
  }

  final colorCrtSm2c = false.obs;

  void setColorCrtSm2c(bool crt) {
    colorCrtSm2c(crt);
  }

  final colorCrtryobi750 = false.obs;

  void setColorCrtryobi750(bool crt) {
    colorCrtryobi750(crt);
  }

  final colorCrtFlexo = false.obs;

  void setColorCrtFlexo(bool crt) {
    colorCrtFlexo(crt);
  }

  final colorCrtImp = false.obs;

  void setColorCrtImp(bool crt) {
    colorCrtImp(crt);
  }

  final loadOpCheck = 0.obs;

  void setOpCheck(OpsModel op) {
    loadOpCheck(op.op);
  }

  void setOpCheckCan() async {
    await 800.milliseconds.delay();
    loadOpCheck(0);
  }

  final loadOpCan = 0.obs;

  void setOpCan(OpsModel op) {
    loadOpCan(op.op);
  }

  void setOpCanCan() async {
    await 800.milliseconds.delay();
    loadOpCan(0);
  }

  final loadOpPrioridadeCheck = 0.obs;

  void setOpPrioridadeCheck(OpsModel op) {
    loadOpPrioridadeCheck(op.op);
  }

  void setOpPrioridadeCheckCan() async {
    await 800.milliseconds.delay();
    loadOpPrioridadeCheck(0);
  }

  String getAtraso(OpsModel model) {
    final df = DateFormat('yyyy-MM-dd');
    var now = DateTime.parse(df.format(DateTime.now()));
    String dayProd;
    String dayExped;
    String dayEnt;
    int dif = int.parse(
        now.difference(model.entregaprog ?? model.entrega).inDays.toString());
    if (model.cancelada) {
      return "";
    }
    if (model.entregue != null) {
      int difEnt = int.parse(now.difference(model.entregue!).inDays.toString());
      if (difEnt == 0) {
        dayEnt = "- Entregue hoje";
      } else if (difEnt > 30) {
        dayEnt = "- Entregue";
      } else {
        dayEnt = "- Entregue a $difEnt dia(s)";
      }
      return dayEnt;
    }
    if (model.produzido != null) {
      int difExped =
          int.parse(now.difference(model.produzido!).inDays.toString());
      if (difExped == 0) {
        dayExped = "- Entrou hoje em expedição";
      } else {
        dayExped = "- Entrou em expedição a $difExped dia(s)";
      }
      return dayExped;
    }
    if (dif >= 1) {
      dayProd = "- Atrasado à ${dif.toString()} dias";
    } else if (dif == 0) {
      dayProd = "- Entrega hoje";
    } else if (-dif == 1) {
      dayProd = "- Entrega amanhã";
    } else {
      dayProd = "- Faltam ${-dif} dia(s) para entrega";
    }
    return dayProd;
  }

  Color? getCorCard(OpsModel model) {
    final df = DateFormat('yyyy-MM-dd');
    var now = DateTime.parse(df.format(DateTime.now()));
    int dif = int.parse(now.difference(model.entrega).inDays.toString());
    if (model.cancelada == true) {
      return Colors.grey[100];
    } else if (model.entregue != null) {
      return Colors.grey[100];
    } else if (model.produzido != null) {
      return Colors.grey[100];
    } else if (dif > 0) {
      return Colors.redAccent[100];
    } else if (dif == 0) {
      return Colors.orangeAccent[100];
    } else if (dif == -1) {
      return Colors.yellowAccent[100];
    }
    return Colors.grey[100];
  }

  PdfColor? getPrintCorCard(OpsModel model) {
    final df = DateFormat('yyyy-MM-dd');
    var now = DateTime.parse(df.format(DateTime.now()));
    int dif = int.parse(now.difference(model.entrega).inDays.toString());
    if (model.cancelada == true) {
      return PdfColors.grey100;
    } else if (model.entregue != null) {
      return PdfColors.grey100;
    } else if (model.produzido != null) {
      return PdfColors.grey100;
    } else if (dif > 0) {
      return PdfColors.red100;
    } else if (dif == 0) {
      return PdfColors.orange100;
    } else if (dif == -1) {
      return PdfColors.yellow100;
    }
    return PdfColors.grey100;
  }

  _showPrintDialog() {
    return Get.dialog(
      AlertDialog(
        title: const Text("Impressão da listagem das Ops"),
        content: SizedBox(
          width: coreModuleController.getSizeProporcao(
            size: coreModuleController.size,
            proporcao: 70,
          ),
          height: coreModuleController.getSizeProporcao(
            size: coreModuleController.sizeH,
            proporcao: 70,
          ),
          child: _pdf2(
            filtro: opsController.filtroPrint,
            titulo: opsController.myTabs[opsController.indexPrint.value].text
                .toString(),
          ),
        ),
      ),
    );
  }

  _pdf2({
    required List<OpsModel> filtro,
    required String titulo,
  }) {
    return PdfPreview(
      build: (format) =>
          _generatePdf2(format: format, title: titulo, filtro: filtro),
    );
  }

  Future<Uint8List> _generatePdf2({
    required PdfPageFormat format,
    required String title,
    required List<OpsModel> filtro,
  }) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format.copyWith(
          marginBottom: 10,
          marginLeft: 20,
          marginRight: 20,
          marginTop: 20,
        ),
        build: (context) => [
          pw.SizedBox(
            height: 20,
            child: pw.FittedBox(
              child: pw.Text(title, style: pw.TextStyle(font: font)),
            ),
          ),
          pw.SizedBox(height: 10),
          designSystemController.opslistPrintWidget(
            filtro: filtro,
          ),
          pw.SizedBox(height: 20),
        ],
      ),
    );

    return pdf.save();
  }
}
