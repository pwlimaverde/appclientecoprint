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
  void onInit() {
    super.onInit();
    getOpsListAll();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onReady() async {
    _tabController.index = await Get.find<GetStorage>().read("opstabIndex");
    _tabController.addListener(() {
      Get.find<GetStorage>().write("opstabIndex", _tabController.index);
    });
    super.onReady();
  }

  final formKey = GlobalKey<FormState>();

  final crtlBusca = TextEditingController();

  final buscando = false.obs;

  final busca = Rxn<String>();

  final opsListAll = <OpsModel>[].obs;

  void limparBusca() {
    buscando(false);
    crtlBusca.clear();
    busca.value = null;
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
        opsListAll.bindStream(allOps.result);
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
        opsListAll(allOps.result);
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
