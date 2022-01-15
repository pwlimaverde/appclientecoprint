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
            // if (opsController.opsListAllCompleta.isEmpty) {
            //   coreModuleController.statusLoad(true);
            // } else {
            //   coreModuleController.statusLoad(false);
            // }
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
      tabs: coreModuleController.showMenu
          ? opsController.myTabsSmall
          : opsController.myTabs,
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
        _emUrgencia(),
        _emExpedicao(),
        _todasOps(),
      ],
    ),
  );
}

_emArteFinal() {
  return designSystemController.opslistWidget(
    filtro: opsController.opsListEmArteFinal,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: false,
  );
}

_emProducao() {
  return designSystemController.opslistWidget(
    filtro: opsController.opsListEmProducao,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: false,
  );
}

_emUrgencia() {
  return designSystemController.opslistWidget(
    filtro: opsController.opsListEmUrgencia,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: false,
  );
}

_emExpedicao() {
  return designSystemController.opslistWidget(
    filtro: opsController.opsListEmExpedicao,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: false,
  );
}

_todasOps() {
  return designSystemController.opslistWidget(
    filtro: opsController.opsListAll,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: false,
  );
}
