import 'package:flutter/material.dart';
import 'package:dependency_module/dependency_module.dart';
import 'widgets/bodyops/bodyops_widget.dart';

class OpsPage extends GetView<OpsController> {
  const OpsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return designSystemController.scaffold(
      body: const BodyOpsWidget(),
      page: 2,
      context: context,
    );
  }
}
