import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';
import 'utils/errors/erros_ops.dart';

class OpsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CarregarTodasOpsUsecase carregarTodasOpsUsecase;
  final CarregarTodasOpsQueryUsecase carregarTodasOpsQueryUsecase;

  OpsController({
    required this.carregarTodasOpsUsecase,
    required this.carregarTodasOpsQueryUsecase,
  });

  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Liberação Arte Final"),
    const Tab(text: "Em Produção"),
    const Tab(text: "Em Expedição"),
    const Tab(text: "Todas Ops"),
  ];

  late TabController _tabController;

  TabController get tabController => _tabController;

  @override
  void onInit() async {
    super.onInit();
    getOpsListAll();
    _tabController = TabController(vsync: this, length: myTabs.length);
    await setIndex();
  }

  @override
  void onReady() async {
    _tabController.index = await Get.find<GetStorage>().read("opstabIndex");
    indexPrint(Get.find<GetStorage>().read("opstabIndex"));
    _tabController.addListener(() {
      Get.find<GetStorage>().write("opstabIndex", _tabController.index);
      indexPrint(_tabController.index);
    });
    super.onReady();
  }

  final formKey = GlobalKey<FormState>();

  final crtlBusca = TextEditingController();

  final buscando = false.obs;

  final busca = Rxn<String>();

  final indexPrint = 3.obs;

  final _opsListAll = <OpsModel>[].obs;

  List<OpsModel> get filtroPrint => indexPrint.value == 0
      ? opsListEmArteFinal
      : indexPrint.value == 1
          ? opsListEmProducao
          : opsListEmExpedicao;

  List<OpsModel> get opsListAll => buscando.value && busca.value != null
      ? _opsListAll.where(
          (element) {
            String termos =
                "${element.op} - ${element.cliente} - ${element.servico} - ${element.quant} - ${element.vendedor} - ${element.obs}";
            return termos.toLowerCase().contains(busca.value!.toLowerCase());
          },
        ).toList()
      : _opsListAll;

  List<OpsModel> get opsListEmArteFinal => opsListAll
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

  List<OpsModel> get opsListEmProducao => opsListAll
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

  List<OpsModel> get opsListEmExpedicao => opsListAll
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

  void limparBusca() {
    buscando(false);
    crtlBusca.clear();
    busca.value = null;
  }

  Future<void> setIndex() async {
    final result = await Get.find<GetStorage>().read("opstabIndex");
    if (result == null) {
      Get.find<GetStorage>().write("opstabIndex", 0);
    }
  }

  void getOpsListAll() async {
    try {
      final allOps = await carregarTodasOpsUsecase(
        parameters: NoParams(
          error: ErroCarregarTodasOps(
            message: "Falha ao carregar os dados: Error usecase - Cod.01-1",
          ),
          showRuntimeMilliseconds: true,
          nameFeature: "Carregar Todas Ops",
        ),
      );
      if (allOps is SuccessReturn<Stream<List<OpsModel>>>) {
        _opsListAll.bindStream(allOps.result);
      } else {
        coreModuleController.message(
          MessageModel(
            message: 'Erro ao carregar as Ops',
            title: 'Erro Ops',
            type: MessageType.error,
          ),
        );
      }
    } catch (e) {
      coreModuleController.message(
        MessageModel(
          message: 'Erro ao carregar as Ops',
          title: 'Erro Ops',
          type: MessageType.error,
        ),
      );
    }
  }

  void getOpsQueryListAll() async {
    try {
      final allOps = await carregarTodasOpsQueryUsecase(
        parameters: NoParams(
          error: ErroCarregarTodasOps(
            message: "Falha ao carregar os dados: Error usecase - Cod.01-1",
          ),
          showRuntimeMilliseconds: true,
          nameFeature: "Carregar Todas Ops",
        ),
      );
      if (allOps is SuccessReturn<List<OpsModel>>) {
        _opsListAll(allOps.result);
      } else {
        coreModuleController.message(
          MessageModel(
            message: 'Erro ao carregar as Ops',
            title: 'Erro Ops',
            type: MessageType.error,
          ),
        );
      }
    } catch (e) {
      coreModuleController.message(
        MessageModel(
          message: 'Erro ao carregar as Ops',
          title: 'Erro Ops',
          type: MessageType.error,
        ),
      );
    }
  }
}
