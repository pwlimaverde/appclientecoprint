import 'package:dependency_module/dependency_module.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'components/opslisttile/opslisttile_print_widget.dart';

class OpslistPrintWidget extends pw.StatelessWidget {
  final List<OpsModel> filtro;

  OpslistPrintWidget({
    required this.filtro,
  });

  @override
  pw.Widget build(pw.Context context) {
    return _listOpsProdL(context);
  }

  _listOpsProdL(context) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(4),
      child: pw.ListView.builder(
        itemCount: filtro.length,
        itemBuilder: (context, index) {
          OpsModel o = filtro[index];
          double size = 1300;
          String cliente =
              o.cliente.length >= 35 ? o.cliente.substring(0, 35) : o.cliente;
          return pw.Container(
            decoration: pw.BoxDecoration(
              border: const pw.Border(
                top: pw.BorderSide(color: PdfColors.black),
              ),
              color: designSystemController.getPrintCorCard(o),
            ),
            width: size,
            child: pw.Row(
              children: <pw.Widget>[
                OpslisttilePrintWidget(
                  sizeGeral: size,
                  sizeCont: 5,
                  sizeFontTile: 1,
                  sizeFontSubTile: 0.8,
                  title: "${o.op}",
                  labelT: "OP:",
                  labelS: "Entrada:",
                  subTile: designSystemController.f.format(o.entrada),
                  heightT: 15,
                  heightS: 25,
                ),
                pw.Expanded(
                  child: OpslisttilePrintWidget(
                    cardAux: true,
                    heightT: 15,
                    heightS: 25,
                    sizeGeral: size,
                    sizeCont: 81,
                    sizeFontTile: 1,
                    sizeFontSubTile: 0.8,
                    line: 2,
                    alingL: true,
                    title:
                        "${o.cancelada == true ? cliente + " - OP CANCELADA" : o.entregue != null ? cliente + " - OP ENTREGUE" : o.produzido != null ? cliente + " - OP PRODUZIDA" : cliente} ${designSystemController.getAtraso(o)} ${o.impressao != null ? " - Impresso" : ""}",
                    subTile: o.servico.length >= 300
                        ? o.servico.substring(0, 300)
                        : o.servico,
                  ),
                ),
                OpslisttilePrintWidget(
                  heightT: 15,
                  heightS: 25,
                  sizeGeral: size,
                  sizeCont: 7,
                  sizeFontTile: 1,
                  sizeFontSubTile: 0.8,
                  labelT: "QT:",
                  title: designSystemController.numMilhar.format(o.quant),
                  labelS: "Vend:",
                  subTile: o.vendedor.length >= 12
                      ? o.vendedor.substring(0, 12)
                      : o.vendedor,
                ),
                OpslisttilePrintWidget(
                  select: false,
                  heightT: 15,
                  heightS: 25,
                  sizeGeral: size,
                  sizeCont: 7,
                  sizeFontTile: 1,
                  sizeFontSubTile: 0.8,
                  line: 2,
                  labelT: o.entregaprog != null
                      ? "Ini ${designSystemController.f2.format(o.entregaprog!)}:"
                      : "Entrega:",
                  title: designSystemController.f.format(o.entrega),
                  subTile:
                      "${o.obs != null ? o.obs!.length >= 68 ? o.obs!.substring(0, 68) : o.obs : ""}",
                ),
              ],
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.start,
            ),
          );
        },
      ),
    );
  }
}
