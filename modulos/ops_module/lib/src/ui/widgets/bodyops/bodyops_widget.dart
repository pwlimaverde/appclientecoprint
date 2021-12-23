import 'dart:typed_data';

import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BodyOpsWidget extends StatelessWidget {
  const BodyOpsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: coreModuleController.sizeH,
      child: Container(
        color: Colors.black12,
        child: Center(
          child: Obx(() {
            if (opsController.opsListAll.isEmpty) {
              coreModuleController.statusLoad(true);
            } else {
              coreModuleController.statusLoad(false);
            }
            return Column(
              children: <Widget>[
                _tabBar(),
                _tabBarView(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

_tabBar() {
  return Container(
    height: tabHeight,
    color: Colors.grey[700],
    child: TabBar(
      controller: opsController.tabController,
      labelColor: Colors.white,
      indicatorColor: Colors.blue,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      tabs: opsController.myTabs,
    ),
  );
}

_tabBarView() {
  return SizedBox(
    width: coreModuleController.sizeW,
    height: coreModuleController.sizeH - tabHeight,
    child: TabBarView(
      controller: opsController.tabController,
      children: [
        _emArteFinal(),
        _emProducao(),
        _emExpedicao(),
        // _todasOps(),
        _pdf2(),
      ],
    ),
  );
}

_emArteFinal() {
  final filtro = opsController.opsListAll
      .where(
        (element) =>
            element.produzido == null &&
            element.cancelada == false &&
            element.artefinal == null &&
            element.entregue == null,
      )
      .toList()
    ..sort(
      (a, b) => a.entrega.compareTo(b.entrega),
    );
  return designSystemController.opslistWidget(
    filtro: filtro,
    can: testeFunc,
    check: testeFunc,
    save: testeFunc,
    up: false,
  );
}

_emProducao() {
  final filtro = opsController.opsListAll
      .where(
        (element) =>
            element.produzido == null &&
            element.cancelada == false &&
            element.artefinal != null &&
            element.entregue == null,
      )
      .toList()
    ..sort(
      (a, b) => a.entrega.compareTo(b.entrega),
    );
  return designSystemController.opslistWidget(
    filtro: filtro,
    can: testeFunc,
    check: testeFunc,
    save: testeFunc,
    up: false,
  );
}

_emExpedicao() {
  final filtro = opsController.opsListAll
      .where(
        (element) =>
            element.produzido != null &&
            element.cancelada == false &&
            element.artefinal != null &&
            element.entregue == null,
      )
      .toList()
    ..sort(
      (a, b) => a.entrega.compareTo(b.entrega),
    );
  return designSystemController.opslistWidget(
    filtro: filtro,
    can: testeFunc,
    check: testeFunc,
    save: testeFunc,
    up: false,
  );
}

_todasOps() {
  return designSystemController.opslistWidget(
    filtro: opsController.opsListAll,
    can: testeFunc,
    check: testeFunc,
    save: testeFunc,
    up: false,
  );
}

testeFunc(OpsModel o) {
  print("op: ${o.op}");
}

_pdf() {
  return PdfPreview(
    build: (format) => _generatePdf(format, "teste impressão"),
  );
}

Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
  final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
  final font = await PdfGoogleFonts.nunitoExtraLight();

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Column(
          children: [
            pw.SizedBox(
              height: 30,
              child: pw.FittedBox(
                child: pw.Text(title, style: pw.TextStyle(font: font)),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Flexible(
              child: designSystemController.opslistPrintWidget(
                filtro: opsController.opsListAll,
              ),
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

_pdf2() {
  return PdfPreview(
    build: (format) => _generatePdf2(format, "teste impressão"),
  );
}

Future<Uint8List> _generatePdf2(PdfPageFormat format, String title) async {
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
              height: 30,
              child: pw.FittedBox(
                child: pw.Text(title, style: pw.TextStyle(font: font)),
              ),
            ),
        pw.SizedBox(height: 20),
        designSystemController.opslistPrintWidget(
          filtro: opsController.opsListAll
              .where(
                (element) =>
                    element.produzido == null &&
                    element.cancelada == false &&
                    element.artefinal != null &&
                    element.entregue == null,
              )
              .toList()
            ..sort(
              (a, b) => a.entrega.compareTo(b.entrega),
            ),
        ),
        pw.SizedBox(height: 20),
      ],
    ),
  );

  return pdf.save();
}
