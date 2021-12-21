import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

class FormBusca extends StatelessWidget {
  const FormBusca({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: opsController.crtlBusca,
      onChanged: (value) {
        opsController.busca(value);
        opsController.buscando(true);
      },
      style: const TextStyle(fontSize: 15, color: Colors.white),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
          labelText: "Busca",
          labelStyle: const TextStyle(color: Colors.white),
          hintText: "Digite a busca",
          hintStyle: const TextStyle(fontSize: 10, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white),
          )),
    );
  }
}
