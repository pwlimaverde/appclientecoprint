import 'package:dependency_module/dependency_module.dart';

class CoreModuleBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<CoreModuleController>(
      CoreModuleController(),
      permanent: true,
    );
    Get.put<DesignSystemController>(
      DesignSystemController(),
      permanent: true,
    );
    Get.put<OpsController>(
      OpsController(
        carregarTodasOpsQueryUsecase: CarregarTodasOpsQueryUsecase(
          datasource: CarregarTodasOpsQueryDatasource(),
        ),
        mutationUpdateOpsUsecase: MutationOpsUsecase(
          datasource: OpsUpdateMutationHasuraDatasource(),
        ),
        mutationInsetOpsUsecase: MutationOpsUsecase(
          datasource: OpsInsertMutationHasuraDatasource(),
        ),
        carregarArteFinalOpsUsecase: SubscriptionHasuraOpsUsecase(
          datasource: SubscriptionHasuraOpsDatasource(
            subscription: opsArteFinalSubscription,
          ),
        ),
        carregarProducaoOpsUsecase: SubscriptionHasuraOpsUsecase(
          datasource: SubscriptionHasuraOpsDatasource(
            subscription: opsProducaoSubscription,
          ),
        ),
        carregarExpedicaoOpsUsecase: SubscriptionHasuraOpsUsecase(
          datasource: SubscriptionHasuraOpsDatasource(
            subscription: opsExpedicaoSubscription,
          ),
        ),
        carregarTodasOpsUsecase: SubscriptionHasuraOpsUsecase(
          datasource: SubscriptionHasuraOpsDatasource(
            subscription: opsAllSubscription,
          ),
        ),
      ),
      permanent: true,
    );
  }
}
