import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppNetworkClient {
  static final _logNetworking = PrettyDioLogger();
  static String baseurl = '';

  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseurl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  )..interceptors.add(_logNetworking);

  AppNetworkClient._();

  static final AppNetworkClient _instance = AppNetworkClient._();

  factory AppNetworkClient() {
    return _instance;
  }

  // TODO add SSL Certificate
  static Future<void> addCertificateToDio(String caCertificate) async {
    _dio.httpClientAdapter = DefaultHttpClientAdapter()
      ..onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return cert.pem == caCertificate;
        };
        return client;
      };
  }

  static Future<Response> _makeGetRequest(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? customHeader,
    Map<String, dynamic>? jsonMap,
  }) async {
    try {
      final res = await _dio.get(
        baseurl + path,
        data: jsonMap ?? FormData.fromMap(data ?? {}),
        options: Options(headers: customHeader),
      );

      debugPrint("CALLING GET ${res.requestOptions.path}");
      debugPrint("Json GET ${res.requestOptions.data}");

      return res;
    } on DioError catch (e) {
      _errorCatch(e);
      throw "[${e.response?.statusCode}] Server Error, try again later";
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<Response> _makePostRequest(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? customHeader,
    FormData? form,
    Map<String, dynamic>? jsonMap,
  }) async {
    try {
      final res = await _dio.post(
        baseurl + path,
        data: form ?? jsonMap ?? FormData.fromMap(data ?? {}),
        options: Options(headers: customHeader),
      );

      debugPrint("CALLING POST ${res.requestOptions.path}");
      debugPrint("Data POST ${res.requestOptions.data}");

      return res;
    } on DioError catch (e) {
      _errorCatch(e);
      throw "[${e.response?.statusCode}] Server Error, try again later";
    } catch (e) {
      throw e.toString();
    }
  }

  static void _errorCatch(DioError e) {
    if (e.response != null) {
      debugPrint("Error CALLING ${e.requestOptions.path}");
      debugPrint("Error Status Code ${e.response!.statusCode}");
      debugPrint("Error Response ${e.response!.data}");
    } else {
      debugPrint("CALLING ${e.requestOptions}");
      print(e.error);
      print(e.message);
    }
  }

  static Future<Response> get({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? customHeader,
    Map<String, dynamic>? jsonMap,
  }) async {
    return _makeGetRequest(
      path,
      data: data,
      customHeader: customHeader,
      jsonMap: jsonMap,
    );
  }

  static Future<Response> post({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? customHeader,
    FormData? form,
    Map<String, dynamic>? jsonMap,
  }) async {
    return _makePostRequest(
      path,
      data: data,
      customHeader: customHeader,
      form: form,
      jsonMap: jsonMap,
    );
  }
}
