import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  CoreModulePreBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema Ecoprint',
      initialBinding: CoreModuleBindings(),
      getPages: [
        ...SplashModule().routers,
        ...HomeModule().routers,
        ...OpsModule().routers,
        ...UploadCsvModule().routers,
      ],
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
    );
  }
}
