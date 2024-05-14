import 'dart:io';

import 'package:dio/dio.dart';
import 'package:feed_view/model/json_model.dart';
import 'package:flutter/foundation.dart';

abstract class IJsonServices {
  Future<List<JsonModel>?> fetchJsonModelAdvance();
}

class JsonServices implements IJsonServices {
  late final Dio _dio;
  JsonServices() : _dio = Dio(BaseOptions(baseUrl: _JsonPath.baserUrlPath._pathUrl()));

  @override
  Future<List<JsonModel>?> fetchJsonModelAdvance() async {
    try {
      final response = await _dio.get(_JsonPath.getPath._pathUrl());
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data['data'];

        if (datas is List) {
          return datas.map<JsonModel>((e) => JsonModel.fromJson(e)).toList();
        }
      }
    } on DioException catch (exception) {
      _DioDebbug()._showException(exception, this);
    }
    return null;
  }
}

enum _JsonPath { baserUrlPath, getPath }

extension _JsonPathExtension on _JsonPath {
  String _pathUrl() {
    switch (this) {
      case _JsonPath.baserUrlPath:
        return 'https://reqres.in/api/';
      case _JsonPath.getPath:
        return 'users?page=2';
    }
  }
}

class _DioDebbug {
  void _showException<T>(DioException exception, T type) {
    if (kDebugMode) {
      print(exception.message);
      print(type);
      print('----------------------------------------');
    }
  }
}
