import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

class BodyUploadCsvWidget extends StatelessWidget {
  const BodyUploadCsvWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: coreModuleController.sizeH,
      child: Container(
        color: Colors.black12,
        child: const Center(
          child: Text(
            "UploadCsv.",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
