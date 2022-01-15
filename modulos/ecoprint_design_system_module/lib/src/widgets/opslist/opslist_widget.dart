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
  final List<OpsModel> filtro;

  const OpslistWidget({
    Key? key,
    required this.showMenu,
    required this.check,
    required this.can,
    required this.save,
    required this.prioridade,
    required this.up,
    required this.filtro,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _listOpsProdL(context);
  }

  _listOpsProdL(context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: filtro.length,
        itemBuilder: (context, index) {
          OpsModel opModel = filtro[index];
          double size = coreModuleController.size;
          String cliente = opModel.cliente.length >= 35
              ? opModel.cliente.substring(0, 35)
              : opModel.cliente;
          return Card(
            color: designSystemController.getCorCard(opModel),
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
                    title: "${opModel.op}",
                    labelT: "OP:",
                    labelS: "Entrada:",
                    subTile: designSystemController.f.format(opModel.entrada),
                    heightT: 30,
                    heightS: 40,
                  ),
                  Expanded(
                    child: OpslisttileWidget(
                      cardAux: true,
                      heightT: 30,
                      heightS: 40,
                      sizeGeral: size,
                      sizeCont: 65,
                      sizeFontTile: 1.5,
                      sizeFontSubTile: 1.4,
                      line: 2,
                      alingL: true,
                      title:
                          "${opModel.cancelada == true ? cliente + " - OP CANCELADA" : opModel.entregue != null ? cliente + " - OP ENTREGUE" : opModel.produzido != null ? cliente + " - OP PRODUZIDA" : cliente} ${designSystemController.getAtraso(opModel)} ${opModel.impressao != null ? " - Impresso" : ""}",
                      subTile: opModel.servico.length >= 300
                          ? opModel.servico.substring(0, 300)
                          : opModel.servico,
                    ),
                  ),
                  OpslisttileWidget(
                    heightT: 30,
                    heightS: 40,
                    sizeGeral: size,
                    sizeCont: 10,
                    sizeFontTile: 1.8,
                    sizeFontSubTile: 1.5,
                    labelT: "QT:",
                    title:
                        designSystemController.numMilhar.format(opModel.quant),
                    labelS: "Vend:",
                    subTile: opModel.vendedor.length >= 12
                        ? opModel.vendedor.substring(0, 12)
                        : opModel.vendedor,
                  ),
                  OpslisttileWidget(
                    select: false,
                    heightT: 30,
                    heightS: 40,
                    sizeGeral: size,
                    sizeCont: 10,
                    sizeFontTile: 1.3,
                    sizeFontSubTile: 1.2,
                    line: 2,
                    labelT: opModel.entregaprog != null
                        ? "Ini ${designSystemController.f2.format(opModel.entregaprog!)}:"
                        : "Entrega:",
                    title: designSystemController.f.format(opModel.entrega),
                    subTile:
                        "${opModel.orderpcp != null ? "Sequência: ${opModel.orderpcp}; " : ""} ${opModel.obs != null ? opModel.obs!.length >= 68 ? opModel.obs!.substring(0, 68) : opModel.obs : ""}",
                    ontap: () {
                      _showDialog(opModel);
                    },
                  ),
                  up == false
                      ? Obx(
                          () => Card(
                            elevation: 0.5,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              width: 75,
                              height: 82,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SwitcherWidget(
                                    imp: opModel.impressao,
                                    title: "Ryobi ",
                                    crtL: opModel.ryobiBuff ?? opModel.ryobi,
                                    mini: true,
                                    onTap: () {
                                      opModel.ryobiBuff =
                                          opModel.impressao != null
                                              ? false
                                              : !opModel.ryobi;
                                      opModel.ryobi = opModel.impressao != null
                                          ? false
                                          : !opModel.ryobi;
                                      save(opModel);
                                    },
                                  ),
                                  SwitcherWidget(
                                    imp: opModel.impressao,
                                    title: "Ry750 ",
                                    crtL: opModel.ryobi750Buff ??
                                        opModel.ryobi750,
                                    mini: true,
                                    onTap: () {
                                      opModel.ryobi750Buff =
                                          opModel.impressao != null
                                              ? false
                                              : !opModel.ryobi750;
                                      opModel.ryobi750 =
                                          opModel.impressao != null
                                              ? false
                                              : !opModel.ryobi750;
                                      save(opModel);
                                    },
                                  ),
                                  SwitcherWidget(
                                    imp: opModel.impressao,
                                    title: "SM 2c ",
                                    crtL: opModel.sm2cBuff ?? opModel.sm2c,
                                    mini: true,
                                    onTap: () {
                                      opModel.sm2cBuff =
                                          opModel.impressao != null
                                              ? false
                                              : !opModel.sm2c;
                                      opModel.sm2c = opModel.impressao != null
                                          ? false
                                          : !opModel.sm2c;
                                      save(opModel);
                                    },
                                  ),
                                  SwitcherWidget(
                                    imp: opModel.impressao,
                                    title: "Flexo ",
                                    crtL: opModel.flexoBuff ?? opModel.flexo,
                                    mini: true,
                                    onTap: () {
                                      opModel.flexoBuff =
                                          opModel.impressao != null
                                              ? false
                                              : !opModel.flexo;
                                      opModel.flexo = opModel.impressao != null
                                          ? false
                                          : !opModel.flexo;
                                      save(opModel);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  Card(
                    elevation: 0.5,
                    color: opModel.entregue != null
                        ? Colors.green[100]
                        : opModel.cancelada == true
                            ? Colors.red[100]
                            : opModel.prioridade == true
                                ? Colors.yellow[100]
                                : null,
                    child: SizedBox(
                      width: 30,
                      height: 82,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 22,
                            child: Obx(() {
                              if (designSystemController
                                      .loadOpPrioridadeCheck.value ==
                                  opModel.op) {
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
                                  color: opModel.prioridade == true
                                      ? Colors.orange
                                      : Colors.grey,
                                  onPressed: () {
                                    prioridade(opModel);
                                  },
                                );
                              }
                            }),
                          ),
                          SizedBox(
                            height: 22,
                            child: Obx(() {
                              if (designSystemController.loadOpCheck.value ==
                                  opModel.op) {
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
                                  isImp: opModel.ryobi ||
                                      opModel.sm2c ||
                                      opModel.ryobi750 ||
                                      opModel.flexo,
                                  icon: Icons.check,
                                  color: opModel.ryobi ||
                                          opModel.sm2c ||
                                          opModel.ryobi750 ||
                                          opModel.flexo
                                      ? Colors.green
                                      : Colors.grey,
                                  onPressed: () {
                                    check(opModel);
                                  },
                                );
                              }
                            }),
                          ),
                          SizedBox(
                            height: 22,
                            child: Obx(() {
                              if (designSystemController.loadOpCan.value ==
                                  opModel.op) {
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
                                  color: opModel.cancelada == true
                                      ? Colors.red
                                      : Colors.grey,
                                  onPressed: () {
                                    can(opModel);
                                  },
                                );
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
          );
        },
      ),
    );
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
                    keyboardType: TextInputType.number,
                    initialValue:
                        model.orderpcp != null ? model.orderpcp.toString() : "",
                    onChanged: (value) => value.isEmpty
                        ? model.orderpcp = null
                        : int.tryParse(value) == null
                            ? model.orderpcp = null
                            : model.orderpcp = int.parse(value),
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
                          crtL: model.ryobi,
                          crtC: designSystemController.colorCrtRyobi.value,
                          onTap: () {
                            designSystemController.setColorCrtRyobi(
                                model.impressao != null ? false : !model.ryobi);
                            model.ryobi =
                                model.impressao != null ? false : !model.ryobi;
                            save(model);
                          },
                        ),
                        SwitcherWidget(
                          imp: model.impressao,
                          title: "Ryobi750 ",
                          crtL: model.ryobi750,
                          crtC: designSystemController.colorCrtryobi750.value,
                          onTap: () {
                            designSystemController.setColorCrtryobi750(
                                model.impressao != null
                                    ? false
                                    : !model.ryobi750);
                            model.ryobi750 = model.impressao != null
                                ? false
                                : !model.ryobi750;
                            save(model);
                          },
                        ),
                        SwitcherWidget(
                          imp: model.impressao,
                          title: "SM 2 cor ",
                          crtL: model.sm2c,
                          crtC: designSystemController.colorCrtSm2c.value,
                          onTap: () {
                            designSystemController.setColorCrtSm2c(
                                model.impressao != null ? false : !model.sm2c);
                            model.sm2c =
                                model.impressao != null ? false : !model.sm2c;
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
                          crtL: model.flexo,
                          crtC: designSystemController.colorCrtFlexo.value,
                          onTap: () {
                            designSystemController.setColorCrtFlexo(
                                model.impressao != null ? false : !model.flexo);
                            model.flexo =
                                model.impressao != null ? false : !model.flexo;
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
          onPressed: () {
            model.entregue = null;
            model.produzido = null;
            model.artefinal = null;
            model.entregaprog = null;
            save(model);
            designSystemController.setColorCrtRyobi(false);
            designSystemController.setColorCrtryobi750(false);
            designSystemController.setColorCrtSm2c(false);
            designSystemController.setColorCrtFlexo(false);
            Get.back();
          },
          child: const Text(
            "Limpar Status",
            style: TextStyle(
              color: Colors.orange,
            ),
          ),
        ),
        TextButton(
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
