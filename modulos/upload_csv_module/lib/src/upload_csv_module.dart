import 'package:dependency_module/dependency_module.dart';
import 'upload_csv_bindings.dart';
import 'ui/upload_csv_page.dart';

class UploadCsvModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: Routes.uploadcsv.caminho,
      transition: Transition.noTransition,
      page: () => const UploadCsvPage(),
      bindings: [
        UploadCsvBiding(),
      ],
    ),
  ];
}
