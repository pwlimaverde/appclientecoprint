import 'package:dependency_module/dependency_module.dart';
import 'package:ecoprint_design_system_module/src/widgets/forms/form_geral/form_geral_widget.dart';
import 'package:flutter/material.dart';

class BotaoForm extends StatelessWidget {
  final Widget form;
  const BotaoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(0),
            width: 110,
            height: 30,
            child: form,
          ),
          Container(
            padding: const EdgeInsets.all(0),
            width: 20,
            height: 30,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.clear,
                color: Colors.red,
                size: 20,
              ),
              onPressed: () {
                opsController.limparBusca();
              },
            ),
          ),
        ],
      ),
    );
  }
}
