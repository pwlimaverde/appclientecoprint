import 'package:dependency_module/dependency_module.dart';

class UploadCsvController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    coreModuleController.statusLoad(false);
  }
}
