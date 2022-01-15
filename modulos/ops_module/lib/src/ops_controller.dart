import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

class OpsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final SubscriptionHasuraOpsUsecase carregarArteFinalOpsUsecase;
  final SubscriptionHasuraOpsUsecase carregarProducaoOpsUsecase;
  final SubscriptionHasuraOpsUsecase carregarExpedicaoOpsUsecase;
  final CarregarTodasOpsQueryUsecase carregarTodasOpsQueryUsecase;
  final MutationOpsUsecase mutationUpdateOpsUsecase;
  final MutationOpsUsecase mutationInsetOpsUsecase;

  OpsController({
    required this.carregarArteFinalOpsUsecase,
    required this.carregarProducaoOpsUsecase,
    required this.carregarExpedicaoOpsUsecase,
    required this.carregarTodasOpsQueryUsecase,
    required this.mutationUpdateOpsUsecase,
    required this.mutationInsetOpsUsecase,
  });

  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Liberação Arte Final"),
    const Tab(text: "Em Produção"),
    const Tab(text: "Em Urgência"),
    const Tab(text: "Em Expedição"),
    const Tab(text: "Todas Ops"),
  ];

  final List<Tab> myTabsSmall = <Tab>[
    const Tab(text: "Art. Fin."),
    const Tab(text: "Prod."),
    const Tab(text: "Urgên."),
    const Tab(text: "Exped."),
    const Tab(text: "Todas"),
  ];

  late TabController _tabController;

  TabController get tabController => _tabController;

  @override
  void onInit() async {
    super.onInit();
    _getOpsQueryListAll();
    _getOpsListArteFinal();
    _getOpsListProducao();
    _tabController = TabController(vsync: this, length: myTabs.length);
    await _setIndex();
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

  final List<OpsModel> _opsListAll = [];

  final _opsListEmArteFinal = <OpsModel>[].obs;

  final _opsListEmProducao = <OpsModel>[].obs;

  final _opsListEmExpedicao = <OpsModel>[].obs;

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

  List<OpsModel> get opsListAllCompleta => _opsListAll;

  List<OpsModel> get opsListAll => buscando.value && busca.value != null
      ? _opsListAll.where(
          (element) {
            String termos =
                "${element.op} - ${element.cliente} - ${element.servico} - ${element.quant} - ${element.vendedor} - ${element.obs}";
            return termos.toLowerCase().contains(busca.value!.toLowerCase());
          },
        ).toList()
      : _opsListAll;

  List<OpsModel> get _opsListArtefinalFiltro =>
      buscando.value && busca.value != null
          ? _opsListEmArteFinal.where(
              (element) {
                String termos =
                    "${element.op} - ${element.cliente} - ${element.servico} - ${element.quant} - ${element.vendedor} - ${element.obs}";
                return termos
                    .toLowerCase()
                    .contains(busca.value!.toLowerCase());
              },
            ).toList()
          : _opsListEmArteFinal;

  List<OpsModel> get opsListEmArteFinal => _opsListArtefinalFiltro
    ..sort(
      (a, b) => a.entrega.compareTo(b.entrega),
    );

  List<OpsModel> get _opsListEmProducaoFiltro =>
      buscando.value && busca.value != null
          ? _opsListEmProducao.where(
              (element) {
                String termos =
                    "${element.op} - ${element.cliente} - ${element.servico} - ${element.quant} - ${element.vendedor} - ${element.obs}";
                return termos
                    .toLowerCase()
                    .contains(busca.value!.toLowerCase());
              },
            ).toList()
          : _opsListEmProducao;

  List<OpsModel> get opsListEmProducao => _opsListEmProducaoFiltro
    ..sort(
      (a, b) => a.entrega.compareTo(b.entrega),
    );

  List<OpsModel> get opsListEmUrgencia => _opsListEmProducaoFiltro
      .where(
        (element) => element.prioridade == true,
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

  List<OpsModel> get _opsListEmExpedicaoFiltro =>
      buscando.value && busca.value != null
          ? _opsListEmExpedicao.where(
              (element) {
                String termos =
                    "${element.op} - ${element.cliente} - ${element.servico} - ${element.quant} - ${element.vendedor} - ${element.obs}";
                return termos
                    .toLowerCase()
                    .contains(busca.value!.toLowerCase());
              },
            ).toList()
          : _opsListEmExpedicao;

  List<OpsModel> get opsListEmExpedicao => _opsListEmExpedicaoFiltro
    ..sort(
      (a, b) => a.entrega.compareTo(b.entrega),
    );

  void limparBusca() {
    buscando(false);
    crtlBusca.clear();
    busca.value = null;
  }

  Future<void> _setIndex() async {
    final result = await Get.find<GetStorage>().read("opstabIndex");
    if (result == null) {
      Get.find<GetStorage>().write("opstabIndex", 0);
    }
  }

  void _getOpsListArteFinal() async {
    try {
      final allOps = await carregarArteFinalOpsUsecase(
        parameters: NoParams(
          error: ErroCarregarTodasOps(
            message: "Falha ao carregar os dados: Error usecase - Cod.01-1",
          ),
          showRuntimeMilliseconds: true,
          nameFeature: "Carregar Ops em Arte Final",
        ),
      );
      if (allOps is SuccessReturn<Stream<List<OpsModel>>>) {
        _opsListEmArteFinal.bindStream(allOps.result);
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

  void _getOpsListProducao() async {
    try {
      final allOps = await carregarProducaoOpsUsecase(
        parameters: NoParams(
          error: ErroCarregarTodasOps(
            message: "Falha ao carregar os dados: Error usecase - Cod.01-1",
          ),
          showRuntimeMilliseconds: true,
          nameFeature: "Carregar Ops em Producao",
        ),
      );
      if (allOps is SuccessReturn<Stream<List<OpsModel>>>) {
        _opsListEmProducao.bindStream(allOps.result);
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

  void _getOpsListExpedicao() async {
    try {
      final allOps = await carregarExpedicaoOpsUsecase(
        parameters: NoParams(
          error: ErroCarregarTodasOps(
            message: "Falha ao carregar os dados: Error usecase - Cod.01-1",
          ),
          showRuntimeMilliseconds: true,
          nameFeature: "Carregar Ops em Expedicao",
        ),
      );
      if (allOps is SuccessReturn<Stream<List<OpsModel>>>) {
        _opsListEmProducao.bindStream(allOps.result);
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

  void _getOpsQueryListAll() async {
    try {
      final allOps = await carregarTodasOpsQueryUsecase(
        parameters: NoParams(
          error: ErroCarregarTodasOps(
            message: "Falha ao carregar os dados: Error usecase - Cod.01-1",
          ),
          showRuntimeMilliseconds: false,
          nameFeature: "Carregar Todas Ops",
        ),
      );
      if (allOps is SuccessReturn<List<OpsModel>>) {
        _opsListAll.assignAll(allOps.result);
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

  OpsModel _whereOpList({required OpsModel model}) {
    return opsListAllCompleta
        .where(
          (element) => element.op == model.op,
        )
        .first;
  }

  void setCancelarOP(OpsModel model) {
    mutationUpdateOps(
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
    _whereOpList(model: model).cancelada = !model.cancelada;
    if (model.prioridade == true) {
      setPrioridadeOP(model);
    }
  }

  void setCheckOP(OpsModel model) {
    if (model.artefinal != null &&
        model.produzido != null &&
        model.entregue != null) {
      return;
    }
    if (model.artefinal == null) {
      _whereOpList(model: model).artefinal = designSystemController.now;
      mutationUpdateOps(
        parametros: ParametrosOpsMutation(
          nameFeature: 'Check Arte Final',
          error: ErroMutationOp(message: 'Erro ao alterar o Check Arte Final'),
          showRuntimeMilliseconds: false,
          mutation: opsArteFinalMutation,
          variables: {
            "op": model.op,
            "artefinal":
                designSystemController.df.format(designSystemController.now)
          },
          messageError: MessageModel.error(
            message: 'Check Arte Final',
            title: 'Erro ao confirmar Arte Final!',
          ),
          messageInfo: MessageModel.info(
            title: "Check Arte Final",
            message:
                "O status Check Arte Final da op ${model.op} foi alterado com sucesso!",
          ),
        ),
      );
    } else if (model.produzido == null) {
      _whereOpList(model: model).produzido = designSystemController.now;
      mutationUpdateOps(
        parametros: ParametrosOpsMutation(
          nameFeature: 'Check Produzido',
          error: ErroMutationOp(message: 'Erro ao alterar o Check Produzido'),
          showRuntimeMilliseconds: false,
          mutation: opsProdMutation,
          variables: {
            "op": model.op,
            "produzido":
                designSystemController.df.format(designSystemController.now)
          },
          messageError: MessageModel.error(
            message: 'Check Produzido',
            title: 'Erro ao confirmar a produção!',
          ),
          messageInfo: MessageModel.info(
            title: "Check Produzido",
            message:
                "O status Check Produzidol da op ${model.op} foi alterado com sucesso!",
          ),
        ),
      );
    } else {
      _whereOpList(model: model).entregue = designSystemController.now;
      mutationUpdateOps(
        parametros: ParametrosOpsMutation(
          nameFeature: 'Check Entregue',
          error: ErroMutationOp(message: 'Erro ao alterar o Check Entregue'),
          showRuntimeMilliseconds: false,
          mutation: opsEntMutation,
          variables: {
            "op": model.op,
            "entregue":
                designSystemController.df.format(designSystemController.now)
          },
          messageError: MessageModel.error(
            message: 'Check Arte Final',
            title: 'Erro ao confirmar Arte Final!',
          ),
          messageInfo: MessageModel.info(
            title: "Check Arte Final",
            message:
                "O status Check Entregue da op ${model.op} foi alterado com sucesso!",
          ),
        ),
      );
    }
  }

  void setPrioridadeOP(OpsModel model) {
    if (model.cancelada == false && model.entregue == null) {
      mutationUpdateOps(
        parametros: ParametrosOpsMutation(
          nameFeature: 'Prioridade da Op',
          error: ErroMutationOp(message: 'Erro ao alterar a prioridade!'),
          showRuntimeMilliseconds: false,
          mutation: opsPrioridadeMutation,
          variables: {
            "op": model.op,
            "prioridade": !model.prioridade,
            "orderpcp": model.prioridade == true ? null : model.orderpcp,
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
      _whereOpList(model: model).prioridade = !model.prioridade;
    } else if (model.cancelada == true) {
      coreModuleController.message(
        MessageModel.error(
          message: 'Prioridade da Op',
          title:
              'Erro ao alterar a Prioridade da Op, pois o status dela está cancelada!',
        ),
      );
    } else {
      coreModuleController.message(
        MessageModel.error(
          message: 'Prioridade da Op',
          title:
              'Erro ao alterar a Prioridade da Op, pois o status dela está entregue!',
        ),
      );
    }
  }

  void setInfoOP(OpsModel model) {
    print(opsListEmArteFinal.length);
    print(opsListEmProducao.length);
    mutationUpdateOps(
      parametros: ParametrosOpsMutation(
        nameFeature: 'Atualização de informações da OP',
        error: ErroMutationOp(message: 'Erro ao Atualizar as informações'),
        showRuntimeMilliseconds: true,
        mutation: opsInfoMutation,
        variables: {
          "op": model.op,
          "orderpcp": model.orderpcp,
          "entrega": designSystemController.df.format(model.entrega),
          "entregaprog": model.entregaprog != null
              ? designSystemController.df.format(model.entregaprog!)
              : null,
          "entregue": model.entregue != null
              ? designSystemController.df.format(model.entregue!)
              : null,
          "produzido": model.produzido != null
              ? designSystemController.df.format(model.produzido!)
              : null,
          "artefinal": model.artefinal != null
              ? designSystemController.df.format(model.artefinal!)
              : null,
          "obs": model.obs,
          "ryobi": model.ryobi,
          "sm2c": model.sm2c,
          "ryobi750": model.ryobi750,
          "flexo": model.flexo,
          "impressao": model.impressao != null
              ? designSystemController.df.format(model.impressao!)
              : null,
        },
        messageError: MessageModel.error(
          message: 'Atualização de informações da OP',
          title: 'Erro ao Atualizar as informações da Op!',
        ),
        messageInfo: null,
      ),
    );
    // _whereOpList(model: model).orderpcp = model.orderpcp;
    // _whereOpList(model: model).entrega = model.entrega;
    // _whereOpList(model: model).entregaprog = model.entregaprog;
    // _whereOpList(model: model).entregue = model.entregue;
    // _whereOpList(model: model).produzido = model.produzido;
    // _whereOpList(model: model).artefinal = model.artefinal;
    // _whereOpList(model: model).obs = model.obs;
    // _whereOpList(model: model).impressao = model.impressao;
  }

  Future<void> mutationUpdateOps(
      {required ParametrosOpsMutation parametros}) async {
    try {
      final result = await mutationUpdateOpsUsecase(
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

  Future<void> mutationInsertOps(
      {required ParametrosOpsMutation parametros}) async {
    try {
      final result = await mutationInsetOpsUsecase(
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
