import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

class OpslisttileWidget extends StatelessWidget {
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
  final void Function()? ontap;
  final bool? threeLine;
  final String? labelT;
  final String? labelS;
  final bool? alingL;
  final bool? select;

  const OpslisttileWidget({
    Key? key,
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
    this.ontap,
    this.threeLine,
    this.labelT,
    this.labelS,
    this.alingL,
    this.select,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContainer2();
  }

//   _buildContainer() {
//     return Card(
//       elevation: 0.5,
//       child: Container(
// //      color: Colors.greenAccent,
//         padding: EdgeInsets.all(0),
//         width: controller.getSize(sizeGeral, sizeCont),
//         child: ListTile(
//           isThreeLine: threeLine ?? false,
//           contentPadding: EdgeInsets.all(4),
//           title: Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//                 fontSize: controller.getSize(sizeGeral, sizeFontTile) * 0.75,
//                 fontWeight: FontWeight.bold),
//           ),
//           subtitle: Text(
//             subTile,
//             maxLines: line ?? 1,
//             style: TextStyle(
//                 fontSize:
//                     controller.getSize(sizeGeral, sizeFontSubTile) * 0.75),
//           ),
//         ),
//       ),
//     );
//   }

  _buildContainer2() {
    return Card(
      elevation: 0.5,
      child: Container(
//      color: Colors.greenAccent,
        padding: const EdgeInsets.all(0),
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
        child: ListTile(
          onTap: ontap,
          isThreeLine: threeLine ?? false,
          contentPadding: const EdgeInsets.all(2),
          title: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                alignment: alingL ?? false
                    ? const Alignment(-1.0, 0.0)
                    : const Alignment(0.0, 0.0),
                height: heightT,
                child: SelectableText(
                  title,
                  onTap: select != null ? ontap : null,
                  enableInteractiveSelection: select != null ? select! : true,
                  showCursor: select != null ? select! : true,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: coreModuleController.getSizeProporcao(
                              size: sizeGeral, proporcao: sizeFontTile) *
                          0.75,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Text(
                  labelT ?? "",
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: coreModuleController.getSizeProporcao(
                              size: sizeGeral, proporcao: sizeFontTile) *
                          0.45,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          subtitle: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
//              color: Colors.greenAccent,
                alignment: alingL ?? false
                    ? const Alignment(-1.0, -0.0)
                    : const Alignment(0.0, 0.0),
                height: heightS,
                child: SelectableText(
                  subTile,
                  onTap: select != null ? ontap : null,
                  enableInteractiveSelection: select != null ? select! : true,
                  showCursor: select != null ? select! : true,
                  maxLines: line ?? 1,
                  style: TextStyle(
                    fontSize: coreModuleController.getSizeProporcao(
                          size: sizeGeral,
                          proporcao: sizeFontSubTile,
                        ) *
                        0.65,
                  ),
                ),
              ),
              Positioned(
                top: 1,
                left: 0,
                child: Text(
                  labelS ?? "",
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: coreModuleController.getSizeProporcao(
                            size: sizeGeral,
                            proporcao: sizeFontSubTile,
                          ) *
                          0.45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
