import 'package:dependency_module/dependency_module.dart';

class CoreModulePreBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<GetStorage>(
      GetStorage(),
      permanent: true,
    );
    Get.put<HasuraConnect>(
      HasuraConnect(baseHasura),
      permanent: true,
    );
  }
}
