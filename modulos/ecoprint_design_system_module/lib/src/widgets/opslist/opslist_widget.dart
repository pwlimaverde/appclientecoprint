import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

import 'components/circularprogress/circularprogress_widget.dart';
import 'components/iconbutton/iconbutton_widget.dart';
import 'components/opslisttile/opslisttile_widget.dart';
import 'components/switcher/switcher_widget.dart';

class OpslistWidget extends StatelessWidget {
  final bool showMenu;
  final void Function(OpsModel) check;
  final void Function(OpsModel) can;
  final void Function(OpsModel) save;
  final void Function(OpsModel) prioridade;
  final bool up;
  final List<OpsModel>? filtro;

  const OpslistWidget({
    Key? key,
    required this.showMenu,
    required this.check,
    required this.can,
    required this.save,
    required this.prioridade,
    required this.up,
    this.filtro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _listOpsProdL(context);
  }

  _listOpsProdL(context) {
//    if (!showMenu) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: filtro != null ? filtro?.length : 0,
        itemBuilder: (context, index) {
          OpsModel o = filtro![index];
          double size = coreModuleController.size;
          String cliente =
              o.cliente.length >= 35 ? o.cliente.substring(0, 35) : o.cliente;
          return Card(
            color: designSystemController.getCorCard(o),
            child: SizedBox(
              width: size,
              child: Row(
                children: <Widget>[
                  // Text(cliente),
                  OpslisttileWidget(
                    sizeGeral: size,
                    sizeCont: 10,
                    sizeFontTile: 1.8,
                    sizeFontSubTile: 1.5,
                    title: "${o.op}",
                    labelT: "OP:",
                    labelS: "Entrada:",
                    subTile: designSystemController.f.format(o.entrada),
                    heightT: 25,
                    heightS: 35,
                  ),
                  Expanded(
                    child: OpslisttileWidget(
                      cardAux: true,
                      heightT: 25,
                      heightS: 35,
                      sizeGeral: size,
                      sizeCont: 65,
                      sizeFontTile: 1.5,
                      sizeFontSubTile: 1.4,
                      line: 2,
                      alingL: true,
                      title:
                          "${o.cancelada == true ? cliente + " - OP CANCELADA" : o.entregue != null ? cliente + " - OP ENTREGUE" : o.produzido != null ? cliente + " - OP PRODUZIDA" : cliente} ${designSystemController.getAtraso(o)} ${o.impressao != null ? " - Impresso" : ""}",
                      subTile: o.servico.length >= 300
                          ? o.servico.substring(0, 300)
                          : o.servico,
                    ),
                  ),
                  OpslisttileWidget(
                    heightT: 25,
                    heightS: 35,
                    sizeGeral: size,
                    sizeCont: 10,
                    sizeFontTile: 1.8,
                    sizeFontSubTile: 1.5,
                    labelT: "QT:",
                    title: designSystemController.numMilhar.format(o.quant),
                    labelS: "Vend:",
                    subTile: o.vendedor.length >= 12
                        ? o.vendedor.substring(0, 12)
                        : o.vendedor,
                  ),
                  OpslisttileWidget(
                    select: false,
                    heightT: 25,
                    heightS: 35,
                    sizeGeral: size,
                    sizeCont: 10,
                    sizeFontTile: 1.5,
                    sizeFontSubTile: 1.2,
                    line: 2,
                    labelT: o.entregaprog != null
                        ? "Ini ${designSystemController.f2.format(o.entregaprog!)}:"
                        : "Entrega:",
                    title: designSystemController.f.format(o.entrega),
                    subTile:
                        "${o.obs != null ? o.obs!.length >= 68 ? o.obs!.substring(0, 68) : o.obs : ""}",
                    ontap: () {
                      _showDialog(o);
                    },
                  ),
                  up == false
                      ? Card(
                          elevation: 0.5,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            width: 75,
                            height: 72,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SwitcherWidget(
                                  imp: o.impressao,
                                  title: "Ryobi ",
                                  crtL: o.ryobi ?? false,
                                  mini: true,
                                  onTap: () {
                                    o.ryobi =
                                        o.impressao != null ? false : !o.ryobi!;
                                    save(o);
                                  },
                                ),
                                SwitcherWidget(
                                  imp: o.impressao,
                                  title: "SM 4c ",
                                  crtL: o.ryobi750 ?? false,
                                  mini: true,
                                  onTap: () {
                                    o.ryobi750 = o.impressao != null
                                        ? false
                                        : !o.ryobi750!;
                                    save(o);
                                  },
                                ),
                                SwitcherWidget(
                                  imp: o.impressao,
                                  title: "SM 2c ",
                                  crtL: o.sm2c ?? false,
                                  mini: true,
                                  onTap: () {
                                    o.sm2c =
                                        o.impressao != null ? false : !o.sm2c!;
                                    save(o);
                                  },
                                ),
                                SwitcherWidget(
                                  imp: o.impressao,
                                  title: "Flexo ",
                                  crtL: o.flexo ?? false,
                                  mini: true,
                                  onTap: () {
                                    o.flexo =
                                        o.impressao != null ? false : !o.flexo!;
                                    save(o);
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                  Card(
                    elevation: 0.5,
                    color: o.prioridade == true ? Colors.yellow[100] : null,
                    child: SizedBox(
                      width: 30,
                      height: 72,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 22,
                            child: Obx(() {
                              if (designSystemController
                                      .loadOpPrioridadeCheck.value ==
                                  o.op) {
                                return const CircularprogressWidget(
                                  left: 0,
                                  right: 0,
                                  top: 6,
                                  bottom: 6,
                                  swidth: 9,
                                  sheight: 9,
                                  strok: 1,
                                  color: Colors.orange,
                                );
                              } else {
                                return IconbuttonWidget(
                                  isImp: true,
                                  icon: Icons.priority_high,
                                  color: o.prioridade == true
                                      ? Colors.orange
                                      : Colors.grey,
                                  onPressed: () {
                                    prioridade(o);
                                    o.prioridade =
                                        o.prioridade == true ? false : true;
                                  },
                                );
                              }
                            }),
                          ),
                          SizedBox(
                            height: 22,
                            child: Obx(() {
                              if (designSystemController.loadOpCheck.value ==
                                  o.op) {
                                return const CircularprogressWidget(
                                  left: 0,
                                  right: 0,
                                  top: 6,
                                  bottom: 6,
                                  swidth: 9,
                                  sheight: 9,
                                  strok: 1,
                                  color: Colors.green,
                                );
                              } else {
                                return IconbuttonWidget(
                                  isImp: o.ryobi! ||
                                      o.sm2c! ||
                                      o.ryobi750! ||
                                      o.flexo!,
                                  icon: Icons.check,
                                  color: o.ryobi! ||
                                          o.sm2c! ||
                                          o.ryobi750! ||
                                          o.flexo!
                                      ? Colors.green
                                      : Colors.grey,
                                  onPressed: () {
                                    check(o);
                                  },
                                );
                              }
                            }),
                          ),
                          SizedBox(
                            height: 22,
                            child: Obx(() {
                              if (designSystemController.loadOpCan.value ==
                                  o.op) {
                                return const CircularprogressWidget(
                                  left: 0,
                                  right: 0,
                                  top: 6,
                                  bottom: 6,
                                  swidth: 9,
                                  sheight: 9,
                                  strok: 1,
                                  color: Colors.red,
                                );
                              } else {
                                return IconbuttonWidget(
                                  isImp: true,
                                  icon: Icons.cancel,
                                  color: Colors.red,
                                  onPressed: () {
                                    can(o);
                                    o.cancelada = !o.cancelada;
                                  },
                                );
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),

//                    Container(
//                      width: controller.getSize(size, 3),
//                      child: allOps == false
//                          ? Column(
//                              children: <Widget>[
//                                ObserverbuttonWidget(
//                                  upProd: upProd,
//                                  crt: crt,
//                                  model: o,
//                                  color: Colors.green,
//                                  icon: Icons.check,
//                                  controller: controller,
//                                ),
//                                ObserverbuttonWidget(
//                                  upProd: upProd,
//                                  crt: can,
//                                  model: o,
//                                  color: Colors.red,
//                                  icon: Icons.clear,
//                                  controller: controller,
//                                  cancelarOP: true,
//                                ),
//                              ],
//                            )
//                          : Column(
//                              children: <Widget>[
//                                o.cancelada == false
//                                    ? ObserverbuttonWidget(
//                                        crt: can,
//                                        model: o,
//                                        color: Colors.red,
//                                        icon: Icons.clear,
//                                        controller: controller,
//                                        cancelarOP: true,
//                                      )
//                                    : ObserverbuttonWidget(
//                                        crt: can,
//                                        model: o,
//                                        color: Colors.green,
//                                        icon: Icons.settings_backup_restore,
//                                        controller: controller,
//                                        cancelarOP: true,
//                                        reativarOP: true,
//                                      ),
//                              ],
//                            ),
//                    ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          );
        },
      ),
    );
//    }
//    return Container(
//      padding: EdgeInsets.all(12),
//      child: ListView.builder(
//        itemCount: filtro != null ? filtro.length : 0,
//        itemBuilder: (context, index) {
//          OpsModel o = filtro[index];
//          var size = controller.getQueryMed(context, 70, showMenu);
//          bool crt = false;
//          bool can = false;
//          return Card(
//            child: Container(
//              width: size,
//              child: Row(
//                children: <Widget>[
//                  ListtilesizeWidget(
//                    controller: controller,
//                    sizeGeral: size,
//                    sizeCont: 14,
//                    sizeFontTile: 3.5,
//                    sizeFontSubTile: 2.5,
//                    title: "${o.op}",
//                    subTile: "${o.entrada}",
//                  ),
//                  ListtilesizeWidget(
//                    controller: controller,
//                    threeLine: true,
//                    line: 3,
//                    sizeGeral: size,
//                    sizeCont: 40,
//                    sizeFontTile: 3.5,
//                    sizeFontSubTile: 2.5,
//                    title:
//                        "${o.cancelada == false ? o.cliente.length >= 35 ? o.cliente.substring(0, 35) : o.cliente : o.cliente.length >= 25 ? o.cliente.substring(0, 25) + " - OP CANCELADA" : o.cliente + " - OP CANCELADA"}",
//                    subTile:
//                        "${o.servico.length >= 150 ? o.servico.substring(0, 150) : o.servico}",
//                  ),
//                  ListtilesizeWidget(
//                    controller: controller,
//                    sizeGeral: size,
//                    sizeCont: 15,
//                    sizeFontTile: 3.5,
//                    sizeFontSubTile: 2.5,
//                    title: "${o.quant}",
//                    subTile:
//                        "${o.vendedor.length >= 8 ? o.vendedor.substring(0, 8) : o.vendedor}",
//                  ),
//                  ListtilesizeWidget(
//                    controller: controller,
//                    threeLine: true,
//                    line: 3,
//                    sizeGeral: size,
//                    sizeCont: 18,
//                    sizeFontTile: 3.5,
//                    sizeFontSubTile: 2.5,
//                    title: "Ent: ${o.entrega}",
//                    subTile:
//                        "${o.obs != null ? o.obs.length >= 68 ? o.obs.substring(0, 68) : o.obs : ""}",
//                  ),
//                  Container(
//                    width: controller.getSize(size, 3),
//                    child: allOps == false
//                        ? Column(
//                            children: <Widget>[
//                              ObserverbuttonWidget(
//                                upProd: upProd,
//                                crt: crt,
//                                model: o,
//                                color: Colors.green,
//                                icon: Icons.check,
//                                controller: controller,
//                              ),
//                              ObserverbuttonWidget(
//                                upProd: upProd,
//                                crt: can,
//                                model: o,
//                                color: Colors.red,
//                                icon: Icons.clear,
//                                controller: controller,
//                                cancelarOP: true,
//                              ),
//                            ],
//                          )
//                        : Column(
//                            children: <Widget>[
//                              o.cancelada == false
//                                  ? ObserverbuttonWidget(
//                                      crt: can,
//                                      model: o,
//                                      color: Colors.red,
//                                      icon: Icons.clear,
//                                      controller: controller,
//                                      cancelarOP: true,
//                                    )
//                                  : ObserverbuttonWidget(
//                                      crt: can,
//                                      model: o,
//                                      color: Colors.green,
//                                      icon: Icons.settings_backup_restore,
//                                      controller: controller,
//                                      cancelarOP: true,
//                                      reativarOP: true,
//                                    ),
//                            ],
//                          ),
//                  ),
//                ],
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.center,
//              ),
//            ),
//          );
//        },
//      ),
//    );
  }

  _showDialog(OpsModel model) {
    return Get.dialog(AlertDialog(
      title: Text("Alterar dados da OP: ${model.op}"),
      content: SizedBox(
        width: 400,
        height: 120,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 50,
                  height: 60,
                  child: TextFormField(
                    initialValue:
                        model.orderpcp != null ? model.orderpcp.toString() : "",
                    onChanged: (value) => model.orderpcp = int.parse(value),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "N°"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 130,
                  height: 60,
                  child: TextFormField(
                    initialValue:
                        designSystemController.fc.format(model.entrega),
                    onChanged: (value) {
                      if (model.entregaprog == null) {
                        if (value.isNotEmpty) {
                          model.entregaprog = DateTime.parse(value);
                        } else {
                          model.entregaprog = model.entrega;
                        }
                      }
                      if (value.isNotEmpty) {
                        model.entrega = DateTime.parse(
                            "${value.substring(6, 10)}-${value.substring(3, 5)}-${value.substring(0, 2)}");
                      } else {
                        model.entrega = model.entrega;
                      }
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: "Entrega"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  width: 210,
                  height: 60,
                  child: TextFormField(
                    initialValue: model.obs,
                    onChanged: (value) => model.obs = value,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Altere as Observações"),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(3),
              width: 370,
              height: 60,
              child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SwitcherWidget(
                          imp: model.impressao,
                          title: "Ryobi ",
                          crtL: model.ryobi ?? false,
                          crtC: designSystemController.colorCrtRyobi.value,
                          onTap: () {
                            designSystemController.setColorCrtRyobi(
                                model.impressao != null
                                    ? false
                                    : !model.ryobi!);
                            model.ryobi =
                                model.impressao != null ? false : !model.ryobi!;
                            save(model);
                          },
                        ),
                        SwitcherWidget(
                          imp: model.impressao,
                          title: "Ryobi750 ",
                          crtL: model.ryobi750 ?? false,
                          crtC: designSystemController.colorCrtryobi750.value,
                          onTap: () {
                            designSystemController.setColorCrtryobi750(
                                model.impressao != null
                                    ? false
                                    : !model.ryobi750!);
                            model.ryobi750 = model.impressao != null
                                ? false
                                : !model.ryobi750!;
                            save(model);
                          },
                        ),
                        SwitcherWidget(
                          imp: model.impressao,
                          title: "SM 2 cor ",
                          crtL: model.sm2c ?? false,
                          crtC: designSystemController.colorCrtSm2c.value,
                          onTap: () {
                            designSystemController.setColorCrtSm2c(
                                model.impressao != null ? false : !model.sm2c!);
                            model.sm2c =
                                model.impressao != null ? false : !model.sm2c!;
                            save(model);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SwitcherWidget(
                          imp: model.impressao,
                          title: "Flexo ",
                          crtL: model.flexo ?? false,
                          crtC: designSystemController.colorCrtFlexo.value,
                          onTap: () {
                            designSystemController.setColorCrtFlexo(
                                model.impressao != null
                                    ? false
                                    : !model.flexo!);
                            model.flexo =
                                model.impressao != null ? false : !model.flexo!;
                            save(model);
                          },
                        ),
                        SwitcherWidget(
                          impOK: true,
                          imp: model.impressao,
                          title: "Impresso ",
                          crtC: designSystemController.colorCrtImp.value,
                          onTap: () {
                            designSystemController.setColorCrtImp(
                                model.impressao != null ? false : true);
//                              model.impressao = model.impressao != null
//                                  ? null
//                                  : now;
                            if (model.impressao != null) {
                              model.impressao = null;
                            } else {
                              model.impressao = designSystemController.now;
                              model.ryobi = false;
                              model.sm2c = false;
                              model.ryobi750 = false;
                              model.flexo = false;
                            }
                            save(model);
                          },
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          // style: ButtonStyle(
          //   backgroundColor: MaterialStateProperty.all(Colors.red),
          // ),
          onPressed: () {
            designSystemController.setColorCrtRyobi(false);
            designSystemController.setColorCrtryobi750(false);
            designSystemController.setColorCrtSm2c(false);
            designSystemController.setColorCrtFlexo(false);
            Get.back();
          },
          child: const Text(
            "Cancelar",
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
        TextButton(
          // style: ButtonStyle(
          //   backgroundColor: MaterialStateProperty.all(Colors.blue),
          // ),
          onPressed: () {
            save(model);
            designSystemController.setColorCrtRyobi(false);
            designSystemController.setColorCrtryobi750(false);
            designSystemController.setColorCrtSm2c(false);
            designSystemController.setColorCrtFlexo(false);
            Get.back();
          },
          child: const Text(
            "Salvar",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    ));
  }
}
