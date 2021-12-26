import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';
import 'features/mutation_ops/domain/usecase/mutation_ops_mutation.dart';
import 'utils/documents/ops_document.dart';
import 'utils/errors/erros_ops.dart';
import 'utils/parametros/parametros.dart';

class OpsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CarregarTodasOpsUsecase carregarTodasOpsUsecase;
  final CarregarTodasOpsQueryUsecase carregarTodasOpsQueryUsecase;
  final MutationOpsUsecase mutationOpsUsecase;

  OpsController({
    required this.carregarTodasOpsUsecase,
    required this.carregarTodasOpsQueryUsecase,
    required this.mutationOpsUsecase,
  });

  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Liberação Arte Final"),
    const Tab(text: "Em Produção"),
    const Tab(text: "Em Urgência"),
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

  final indexPrint = 4.obs;

  final _opsListAll = <OpsModel>[].obs;

  List<OpsModel> get filtroPrint {
    switch (indexPrint.value) {
      case 1:
        return opsListEmProducao;
      case 2:
        return opsListEmUrgencia;
      case 3:
        return opsListEmExpedicao;
      default:
        return opsListEmArteFinal;
    }
  }

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

  List<OpsModel> get opsListEmUrgencia => opsListAll
      .where(
        (element) =>
            element.produzido == null &&
            element.cancelada == false &&
            element.artefinal != null &&
            element.entregue == null &&
            element.prioridade == true,
      )
      .toList()
    ..sort(
      (a, b) => a.entrega.compareTo(b.entrega),
    )
    ..sort(
      (a, b) =>
          (a.orderpcp == null ? opsListAll.length : a.orderpcp!).compareTo(
        (b.orderpcp == null ? opsListAll.length : b.orderpcp!),
      ),
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

  void setCancelarOP(OpsModel model) {
    _mutationOps(
      parametros: ParametrosOpsMutation(
        nameFeature: 'Cancelar OP',
        error: ErroMutationOp(message: 'Erro ao alterar o cancelamento'),
        showRuntimeMilliseconds: false,
        mutation: opsCanMutation,
        variables: {"op": model.op, "cancelada": !model.cancelada},
        messageError: MessageModel.error(
          message: 'Cancelamento de Op',
          title: 'Erro ao alterar o status de Cancelamento da Op!',
        ),
        messageInfo: MessageModel.info(
            title: "Cancelamento de Op",
            message: model.cancelada
                ? "O status de cancelamento da op ${model.op} foi alterado com sucesso!"
                : "A op ${model.op} foi cancelada com sucesso!"),
      ),
    );
    if (model.prioridade == true) {
      setPrioridadeOP(model);
    }
  }

  void setPrioridadeOP(OpsModel model) {
    if (model.cancelada == false) {
      _mutationOps(
        parametros: ParametrosOpsMutation(
          nameFeature: 'Prioridade da Op',
          error: ErroMutationOp(message: 'Erro ao alterar a prioridade!'),
          showRuntimeMilliseconds: false,
          mutation: opsPrioridadeMutation,
          variables: {
            "op": model.op,
            "prioridade": model.prioridade == true ? false : true
          },
          messageError: MessageModel.error(
            message: 'Prioridade da Op',
            title: 'Erro ao alterar a Prioridade da Op!',
          ),
          messageInfo: MessageModel.info(
            title: "Prioridade da Op",
            message:
                "O status da Prioridade da op ${model.op} foi alterado com sucesso!",
          ),
        ),
      );
    } else {
      coreModuleController.message(
        MessageModel.error(
          message: 'Prioridade da Op',
          title: 'Erro ao alterar a Prioridade da Op, pois ela está cancelada!',
        ),
      );
    }
  }

  Future<void> _mutationOps({required ParametrosOpsMutation parametros}) async {
    try {
      final result = await mutationOpsUsecase(
        parameters: parametros,
      );
      if (result is SuccessReturn<bool>) {
        coreModuleController.message(
          parametros.messageInfo,
        );
      } else {
        coreModuleController.message(
          parametros.messageError,
        );
      }
    } catch (e) {
      coreModuleController.message(
        parametros.messageError,
      );
    }
  }
}
