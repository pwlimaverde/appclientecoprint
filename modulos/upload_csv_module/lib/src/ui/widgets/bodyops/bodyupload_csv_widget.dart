import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

class BodyUploadCsvWidget extends StatelessWidget {
  const BodyUploadCsvWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: coreModuleController.sizeH,
      child: Container(
        color: Colors.black12,
        child: Center(
          child: Obx(() {
            // if (uploadCsvController.uploadCsvOpsList.isNotEmpty ||
            //     uploadCsvController.updateCsvOpsList.isNotEmpty ||
            //     uploadCsvController.duplicadasCsvOpsList.isNotEmpty ||
            //     uploadCsvController.uploadCsvOpsListError.isNotEmpty) {
            //   coreModuleController.statusLoad(false);
            // } else {
            //   coreModuleController.statusLoad(true);
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
      controller: uploadCsvController.tabController,
      labelColor: Colors.white,
      indicatorColor: Colors.blue,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      tabs: coreModuleController.showMenu
          ? uploadCsvController.myTabsSmall
          : uploadCsvController.myTabs,
    ),
  );
}

_tabBarView() {
  return SizedBox(
    width: coreModuleController.sizeW,
    height: coreModuleController.sizeH - tabHeight,
    child: TabBarView(
      controller: uploadCsvController.tabController,
      children: [
        _uploadOpsList(),
        _updateOpsList(),
        _duplicadasOpsList(),
        _uploadOpsListError(),
      ],
    ),
  );
}

_uploadOpsList() {
  return designSystemController.opslistWidget(
    filtro: uploadCsvController.uploadCsvOpsList,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: true,
  );
}

_updateOpsList() {
  return designSystemController.opslistWidget(
    filtro: uploadCsvController.updateCsvOpsList,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: true,
  );
}

_duplicadasOpsList() {
  return designSystemController.opslistWidget(
    filtro: uploadCsvController.duplicadasCsvOpsList,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: true,
  );
}

_uploadOpsListError() {
  return designSystemController.opslistWidget(
    filtro: uploadCsvController.uploadCsvOpsListError,
    can: opsController.setCancelarOP,
    check: opsController.setCheckOP,
    save: opsController.setInfoOP,
    prioridade: opsController.setPrioridadeOP,
    up: true,
  );
}
