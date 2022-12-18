// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';

import '../../eng_tr_uyg/model/es_anlam_model.dart';

abstract class IReqresService {
  final Dio dio;
  IReqresService(this.dio);
  Future<EsAnlamModel?> fetchHavaDurumuIte(String kelimee);
}

class ReqresService extends IReqresService {
  ReqresService(
    super.dio,
  );

  @override
  Future<EsAnlamModel?> fetchHavaDurumuIte(String kelimee) async {
    final response = await dio.get(
        "https://wordsapiv1.p.rapidapi.com/words/$kelimee/synonyms",
        options: Options(headers: {
          "X-RapidAPI-Key":
              "4d0a8a2967mshe37232d5cdea211p193d59jsnbcaa589db7e1",
          "X-RapidAPI-Host": "wordsapiv1.p.rapidapi.com",
        }));

    if (response.statusCode == HttpStatus.ok) {
      final jsonBody = response.data;
      if (jsonBody is Map<String, dynamic>) {
        return EsAnlamModel.fromJson(jsonBody);
      }
    }
    return null;
  }
}
