import 'package:flutter/material.dart';
import 'package:dependency_module/dependency_module.dart';
import '../upload_csv_controller.dart';
import 'widgets/bodyops/bodyupload_csv_widget.dart';

class UploadCsvPage extends GetView<UploadCsvController> {
  const UploadCsvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return designSystemController.scaffold(
      body: const BodyUploadCsvWidget(),
      page: 1,
      context: context,
    );
  }
}
