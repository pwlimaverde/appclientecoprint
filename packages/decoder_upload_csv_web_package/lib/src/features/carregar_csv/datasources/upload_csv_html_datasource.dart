import 'package:dependency_module/dependency_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert' as convert;

class UploadCsvHtmlDatasource implements Datasource<List<String>> {
  @override
  Future<List<String>> call(
      {required ParametersReturnResult parameters}) async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.click();

    final testeElement = await uploadInput.onChange.first.then((_) async {
      List<html.File>? files = uploadInput.files;

      if (files != null && files.isNotEmpty) {
        List<String> listaGeral = [];
        for (html.File file in files) {
          listaGeral.addAll(await _listaBruta(file: file));
        }

        return listaGeral;
      } else {
        throw Exception("Erro ao carregar arquivo");
      }
    });
    return testeElement;
  }

  Future<List<String>> _listaBruta({required html.File file}) {
    final reader = html.FileReader();

    final resultReader = reader.onLoadEnd.first.then((_) {
      Object? result = reader.result;
      String s = result.toString();
      String base64 = s.substring(s.indexOf(",") + 1);

      if (!file.name.contains(".csv")) {
        throw Exception("Arquivo carregado não é csv");
      }
      dynamic bytes = convert.base64.decode(base64);
      String decoderByte = convert.utf8.decode(bytes);
      String decoderSplitMap = decoderByte.splitMapJoin((RegExp(r'\d{5},\S\D')),
          onMatch: (m) => '--->---${m.group(0)}', onNonMatch: (n) => n);
      List<String> decoderRow = decoderSplitMap.split(RegExp(r'--->---'));
      decoderRow.removeAt(0);
      return decoderRow;
    });

    reader.readAsDataUrl(file);

    return resultReader;
  }
}
