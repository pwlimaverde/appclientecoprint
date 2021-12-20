import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

import 'components/item/item_widget.dart';

class MenuWidget extends StatelessWidget {
  final int page;

  const MenuWidget({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _itensMenu();
  }

  _itensMenu() {
    return Container(
      width: menuWidth,
      color: Colors.grey[400],
      child: ListView(
        children: <Widget>[
          ItemWidget(
            page: page,
            indice: 0,
            nav: Routes.initial.caminho,
            icon: const Icon(Icons.home),
            title: "Home",
          ),
          ItemWidget(
            page: page,
            indice: 1,
            nav: Routes.uploadcsv.caminho,
            icon: const Icon(Icons.cloud_upload),
            title: "Upload Ops",
          ),
          ItemWidget(
            page: page,
            indice: 2,
            nav: Routes.ops.caminho,
            icon: const Icon(Icons.cloud),
            title: "Ops",
          ),
          ItemWidget(
            page: page,
            indice: 3,
            icon: const Icon(Icons.cloud_done),
            title: "Pcp",
          ),
          ItemWidget(
            page: page,
            indice: 4,
            icon: const Icon(Icons.extension),
            title: "Orçamento Flexo ...",
          ),
        ],
      ),
    );
  }
}
