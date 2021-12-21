import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

import '../../forms/form_busca/form_busca_widget.dart';

class BotaoLimpar extends StatelessWidget {
  const BotaoLimpar({Key? key}) : super(key: key);

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
            child: const FormBusca(),
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
