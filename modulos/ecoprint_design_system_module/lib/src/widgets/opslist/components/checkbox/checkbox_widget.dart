import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

class CheckboxWidget extends StatelessWidget {
  final double sizeGeral;
  final double sizeCont;
  final double sizeFontTile;
  final double value;
  final void Function()? ontap;
  final void Function()? onChanged;
  final String title;
  final String? labelT;
  final bool? alingL;
  final double heightT;

  const CheckboxWidget({
    Key? key,
    required this.sizeGeral,
    required this.sizeCont,
    required this.sizeFontTile,
    required this.title,
    this.labelT,
    this.alingL = false,
    required this.heightT,
    this.ontap,
    this.onChanged,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildContainer2();
  }

  _buildContainer2() {
    return Card(
      elevation: 0.5,
      child: Container(
//      color: Colors.greenAccent,
        padding: const EdgeInsets.all(0),
        width: coreModuleController.getSizeProporcao(
            proporcao: sizeGeral, size: sizeCont),
        child: ListTile(
          onTap: ontap,
          contentPadding: const EdgeInsets.all(2),
          title: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
//              CustomCheckBoxGroup(
//                buttonColor: Colors.grey,
//                buttonLables: [
//                  "Monday",
//                  "Tuesday",
//                ],
//                buttonValuesList: [
//                  "Monday",
//                  "Tuesday",
//                ],
//                checkBoxButtonValues: (values) {
//                  print(values);
//                },
//                defaultSelected: "Monday",
//                horizontal: true,
//                width: 20,
//                 hight: 20,
//                selectedColor: Colors.greenAccent,
//                padding: 5,
//                // enableShape: true,
//              ),
//              Checkbox(
//                value: value ?? false,
//                onChanged: onChanged,
//              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  ),
                ),
                alignment: alingL!
                    ? const Alignment(-1.0, 0.0)
                    : const Alignment(0.0, 0.0),
                height: heightT,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: coreModuleController.getSizeProporcao(
                              size: sizeGeral, proporcao: sizeFontTile) *
                          0.45,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
