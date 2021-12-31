import 'package:dependency_module/dependency_module.dart';
import 'features/upload_ops/datasources/upload_ops_datasource.dart';
import 'features/upload_ops/domain/usecase/upload_ops_usecase.dart';

class UploadCsvBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadCsvController>(() {
      return UploadCsvController(
        carregarCsvUsecase: CarregarCsvUsecase(
          datasource: UploadCsvHtmlDatasource(),
        ),
        processarCsvUsecase: ProcessarCsvUsecase(
          datasource: ProcessarCsvEmOpsDatasource(),
        ),
        uploadOpsUsecase: UploadOpsUsecase(
          datasource: UploadOpsDatasource(),
        ),
      );
    });
  }
}
