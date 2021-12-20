import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

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
        _todasOps(),
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
