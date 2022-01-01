import 'package:dependency_module/dependency_module.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class OpslisttilePrintWidget extends pw.StatelessWidget {
  final double sizeGeral;
  final double sizeCont;
  final double sizeFontTile;
  final double sizeFontSubTile;
  final String title;
  final String subTile;
  final double heightT;
  final double heightS;
  final bool? cardAux;
  final int? line;
  final bool? threeLine;
  final String? labelT;
  final String? labelS;
  final bool? alingL;
  final bool? select;

  OpslisttilePrintWidget({
    required this.sizeGeral,
    required this.sizeCont,
    required this.sizeFontTile,
    required this.sizeFontSubTile,
    required this.title,
    required this.subTile,
    required this.heightT,
    required this.heightS,
    this.cardAux,
    this.line,
    this.threeLine,
    this.labelT,
    this.labelS,
    this.alingL,
    this.select,
  });

  @override
  pw.Widget build(pw.Context context) {
    return _buildContainer2();
  }

  _buildContainer2() {
    return pw.Container(
        padding: const pw.EdgeInsets.all(0),
        width: cardAux == true
            ? coreModuleController.getSizeProporcao(
                  size: sizeGeral,
                  proporcao: sizeCont,
                ) -
                130
            : coreModuleController.getSizeProporcao(
                size: sizeGeral,
                proporcao: sizeCont,
              ),
        child: pw.Column(
          children: [
            pw.Stack(
            alignment: pw.Alignment.topLeft,
            children: <pw.Widget>[
              pw.Container(
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                    bottom: pw.BorderSide(width: 1.0, color: PdfColors.grey,),
                  ),
                ),
                alignment: alingL ?? false
                    ? const pw.Alignment(-1.0, 0.0)
                    : const pw.Alignment(0.0, 0.0),
                height: heightT,
                child: pw.Text(
                  title,
                  maxLines: 1,
                  style: pw.TextStyle(
                      fontSize: coreModuleController.getSizeProporcao(
                              size: sizeGeral, proporcao: sizeFontTile) *
                          0.75,
                      fontWeight: pw.FontWeight.bold),
                ),
              ),
              pw.Positioned(
                top: 0,
                left: 0,
                child: pw.Text(
                  labelT ?? "",
                  maxLines: 2,
                  style: pw.TextStyle(
                      fontSize: coreModuleController.getSizeProporcao(
                              size: sizeGeral, proporcao: sizeFontTile) *
                          0.45,
                      fontWeight: pw.FontWeight.bold),
                ),
              ),
            ],
          ),
          pw.Stack(
            alignment: pw.Alignment.topLeft,
            children: <pw.Widget>[
              pw.Container(
                alignment: alingL ?? false
                    ? const pw.Alignment(-1.0, -0.0)
                    : const pw.Alignment(0.0, 0.0),
                height: heightS,
                child: pw.Text(
                  subTile,
                  maxLines: line ?? 1,
                  style: pw.TextStyle(
                    fontSize: coreModuleController.getSizeProporcao(
                          size: sizeGeral,
                          proporcao: sizeFontSubTile,
                        ) *
                        0.65,
                  ),
                ),
              ),
              pw.Positioned(
                top: 1,
                left: 0,
                child: pw.Text(
                  labelS ?? "",
                  maxLines: 1,
                  style: pw.TextStyle(
                      fontSize: coreModuleController.getSizeProporcao(
                            size: sizeGeral,
                            proporcao: sizeFontSubTile,
                          ) *
                          0.45),
                ),
              ),
            ],
          ),
          ]
        ),
      );
  }
}
