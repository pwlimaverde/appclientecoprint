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
        child: Column(
          children: [
            Center(
              child: Obx(() {
                if (uploadCsvController.uploadCsvOpsList.isEmpty) {
                  return const Text(
                    "UploadCsv.",
                    style: TextStyle(fontSize: 30),
                  );
                } else {
                  return Text(uploadCsvController.uploadCsvOpsList.toString(),
                      style: const TextStyle(fontSize: 10));
                }
              }),
            ),
            IconButton(
              onPressed: () {
                uploadCsvController.setUploadOps();
              },
              icon: const Icon(Icons.update),
            ),
          ],
        ),
      ),
    );
  }
}
