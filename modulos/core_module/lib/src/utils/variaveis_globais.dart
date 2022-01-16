import 'package:dependency_module/dependency_module.dart';

final CoreModuleController coreModuleController = Get.find();
final DesignSystemController designSystemController = Get.find();
final OpsController opsController = Get.find();
final UploadCsvController uploadCsvController = Get.find();

const double menuWidth = 200;
const double hederHeight = 60;
const double tabHeight = 40;
const String versaoAtual = "1.0.3";

const String baseHasura = "https://sistemaecoprint.herokuapp.com/v1/graphql";
