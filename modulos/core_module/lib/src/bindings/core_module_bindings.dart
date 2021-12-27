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
        carregarTodasOpsUsecase: CarregarTodasOpsUsecase(
          datasource: CarregarTodasOpsDatasource(),
        ),
        carregarTodasOpsQueryUsecase: CarregarTodasOpsQueryUsecase(
          datasource: CarregarTodasOpsQueryDatasource(),
        ),
        mutationOpsUsecase: MutationOpsUsecase(
          datasource: OpsMutationDatasource(),
        ),
      ),
      permanent: true,
    );
  }
}
