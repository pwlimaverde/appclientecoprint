import 'package:dependency_module/dependency_module.dart';
import 'upload_csv_controller.dart';

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
      );
    });
  }
}
