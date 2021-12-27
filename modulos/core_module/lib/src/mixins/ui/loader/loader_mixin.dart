import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

mixin LoaderMixin on GetxController {
  void loaderListener({
    required RxBool statusLoad,
  }) {
    ever<bool>(
      statusLoad,
      (loading) {
        if (loading) {
          WidgetsBinding.instance?.addPostFrameCallback((duration) async {
            await Get.dialog(
              const Center(
                child: CircularProgressIndicator(),
              ),
              barrierDismissible: false,
            );
          });
        } else {
          Get.back();
        }
      },
    );
  }
}
