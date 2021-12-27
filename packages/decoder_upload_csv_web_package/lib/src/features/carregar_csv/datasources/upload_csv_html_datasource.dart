import 'package:dependency_module/dependency_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert' as convert;

class UploadCsvHtmlDatasource implements Datasource<List<String>> {
  @override
  Future<List<String>> call({required ParametersReturnResult parameters}) {
    List<String> resultOps = [];
    final uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen(
      (e) {
        List<html.File>? files = uploadInput.files;
        if (files != null && files.isNotEmpty) {
          final html.File file = files[0];
          print("Upload file: ${file.name}");

          final reader = html.FileReader();
          reader.onLoadEnd.listen((e) async {
            Object? result = reader.result;
            String s = result.toString();
            String base64 = s.substring(s.indexOf(",") + 1);
            String mimeType = s.substring(s.indexOf(":") + 1, s.indexOf(";"));
            print("mimeType: $mimeType");

            if (!file.name.contains(".csv")) {
              throw Exception("Arquivo carregado não é csv");
            }

            dynamic bytes = convert.base64.decode(base64);
            String decoderByte = convert.utf8.decode(bytes);
            String decoderSplitMap = decoderByte.splitMapJoin(
                (RegExp(r'\d{5},\D')),
                onMatch: (m) => '${m.group(0)}',
                onNonMatch: (n) => "$n--->---");
            List<String> decoderRow = decoderSplitMap.split(RegExp(r'--->---'));
            decoderRow.removeAt(0);
            resultOps = decoderRow;
            print("dentro do listnen: $decoderRow");
          });
          reader.readAsDataUrl(file);
        }
      },
    );

    if (resultOps.isNotEmpty) {
      print("dentro if: $resultOps");
      return Future.value(resultOps);
    } else {
      throw Exception("Erro ao carregar arquivo");
    }
  }
}
