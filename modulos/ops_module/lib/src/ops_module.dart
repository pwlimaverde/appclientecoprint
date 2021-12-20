import 'package:dependency_module/dependency_module.dart';
import 'ops_bindings.dart';
import 'ui/ops_page.dart';

class OpsModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: Routes.ops.caminho,
      transition: Transition.noTransition,
      page: () => const OpsPage(),
      bindings: [
        OpsBiding(),
      ],
    ),
  ];
}
