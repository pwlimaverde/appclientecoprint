import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';
import 'widgets/header/header_widget.dart';
import 'widgets/menu/menu_widget.dart';
import 'widgets/opslist/opslist_widget.dart';
import 'widgets/right/right_widget.dart';

class DesignSystemController extends GetxController {
  //Widgets Pages
  Scaffold scaffold({
    required Widget body,
    required int page,
    required BuildContext context,
  }) {
    coreModuleController.getQuery(context: context);

    return Scaffold(
      drawer: coreModuleController.showMenu
          ? Drawer(
              child: MenuWidget(
                page: page,
              ),
            )
          : null,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(hederHeight),
        child: HeaderWidget(
          titulo: "Sistema Ecoprint",
        ),
      ),
      backgroundColor: Get.theme.primaryColor,
      body: Column(
        children: <Widget>[
          Obx(() {
            return _body(
              body: body,
              page: page,
            );
          }),
        ],
      ),
    );
  }

  Widget _body({
    required Widget body,
    required int page,
  }) {
    return SizedBox(
      width: coreModuleController.size,
      height: coreModuleController.sizeH,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          coreModuleController.showMenu
              ? RightWidget(
                  widget: SizedBox(
                    width: coreModuleController.sizeW,
                    height: coreModuleController.sizeH,
                    child: body,
                  ),
                  menuWidth: menuWidth,
                  showMenu: coreModuleController.showMenu,
                  sizeW: coreModuleController.sizeW,
                )
              : Row(
                  children: <Widget>[
                    MenuWidget(
                      page: page,
                    ),
                    RightWidget(
                      widget: SizedBox(
                        width: coreModuleController.sizeW,
                        height: coreModuleController.sizeH,
                        child: body,
                      ),
                      menuWidth: menuWidth,
                      showMenu: coreModuleController.showMenu,
                      sizeW: coreModuleController.sizeW,
                    ),
                  ],
                )
        ],
      ),
    );
  }

  //Widgets OpsList
  Widget opslistWidget({
    required filtro,
    required check,
    required Function(OpsModel) can,
    required save,
    required up,
  }) {
    return OpslistWidget(
      up: up,
      showMenu: coreModuleController.showMenu,
      filtro: filtro,
      check: (OpsModel o) {
        setOpCheck(o);
        check(o);
        setOpCheckCan();
      },
      can: (OpsModel o) {
        setOpCan(o);
        can(o);
        setOpCanCan();
      },
      save: (OpsModel o) {
        save(o);
      },
    );
  }

  //Controle OpsList
  DateTime now = DateTime.now();
  final f = DateFormat('dd/MM/yy');
  final f2 = DateFormat('dd/MM');
  final fc = DateFormat('dd/MM/yyyy');
  final df = DateFormat('yyyy/MM/dd');
  final numMilhar = NumberFormat(",##0", "pt_BR");

  final colorCrtRyobi = false.obs;

  void setColorCrtRyobi(bool crt) {
    colorCrtRyobi(crt);
  }

  final colorCrtSm2c = false.obs;

  void setColorCrtSm2c(bool crt) {
    colorCrtSm2c(crt);
  }

  final colorCrtSm4c = false.obs;

  void setColorCrtSm4c(bool crt) {
    colorCrtSm4c(crt);
  }

  final colorCrtFlexo = false.obs;

  void setColorCrtFlexo(bool crt) {
    colorCrtFlexo(crt);
  }

  final colorCrtImp = false.obs;

  void setColorCrtImp(bool crt) {
    colorCrtImp(crt);
  }

  final loadOpCheck = 0.obs;

  void setOpCheck(OpsModel op) {
    loadOpCheck(op.op);
  }

  void setOpCheckCan() async {
    await 300.milliseconds.delay();
    loadOpCheck(0);
  }

  final loadOpCan = 0.obs;

  void setOpCan(OpsModel op) {
    loadOpCan(op.op);
  }

  void setOpCanCan() async {
    await 300.milliseconds.delay();
    loadOpCan(0);
  }

  String getAtraso(OpsModel model) {
    final df = DateFormat('yyyy-MM-dd');
    var now = DateTime.parse(df.format(DateTime.now()));
    String dayProd;
    String dayExped;
    String dayEnt;
    int dif = int.parse(
        now.difference(model.entregaprog ?? model.entrega).inDays.toString());
    if (model.cancelada) {
      return "";
    }
    if (model.entregue != null) {
      int difEnt = int.parse(now.difference(model.entregue!).inDays.toString());
      if (difEnt == 0) {
        dayEnt = "- Entregue hoje";
      } else if (difEnt > 30) {
        dayEnt = "- Entregue";
      } else {
        dayEnt = "- Entregue a $difEnt dia(s)";
      }
      return dayEnt;
    }
    if (model.produzido != null) {
      int difExped =
          int.parse(now.difference(model.produzido!).inDays.toString());
      if (difExped == 0) {
        dayExped = "- Entrou hoje em expedição";
      } else {
        dayExped = "- Entrou em expedição a $difExped dia(s)";
      }
      return dayExped;
    }
    if (dif >= 1) {
      dayProd = "- Atrasado à ${dif.toString()} dias";
    } else if (dif == 0) {
      dayProd = "- Entrega hoje";
    } else if (-dif == 1) {
      dayProd = "- Entrega amanhã";
    } else {
      dayProd = "- Faltam ${-dif} dia(s) para entrega";
    }
    return dayProd;
  }

  Color? getCorCard(OpsModel model) {
    final df = DateFormat('yyyy-MM-dd');
    var now = DateTime.parse(df.format(DateTime.now()));
    int dif = int.parse(now.difference(model.entrega).inDays.toString());
    if (model.cancelada == true) {
      return Colors.grey[100];
    } else if (model.entregue != null) {
      return Colors.grey[100];
    } else if (model.produzido != null) {
      return Colors.grey[100];
    } else if (dif > 0) {
      return Colors.redAccent[100];
    } else if (dif == 0) {
      return Colors.orangeAccent[100];
    } else if (dif == -1) {
      return Colors.yellowAccent[100];
    }
    return Colors.grey[100];
  }
}
