import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ApiService {
  ApiService._privateConstructor();

  static final ApiService instance = ApiService._privateConstructor();

  factory ApiService() => instance;

  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  Future<void> apiCall(
      {required Function execute,
      required Function(dynamic) onSuccess,
      Function(dynamic)? onError,
      Function? onLoading}) async {
    try {
      if (onLoading != null) onLoading();
      // hide keyboard
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      var response = await execute();
      return onSuccess(response);
    } catch (error) {
      if (onError == null) return;
      onError(error);
      return;
    }
  }

  ///get api request
  Future<T> get<T>(
      String url, T Function(Map<String, dynamic> json) fromJson) async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    return _processResponse(response, fromJson);
  }

  ///post api request
  Future<T> post<T>(String url, T Function(Map<String, dynamic> json) fromJson,
      {Map<String, dynamic>? body}) async {
    http.Response response = await http.post(Uri.parse(url),
        headers: headers, body: body != null ? jsonEncode(body) : null);
    return _processResponse(response, fromJson);
  }

  ///patch api request
  Future<T> patch<T>(String url, T Function(Map<String, dynamic> json) fromJson,
      {Map<String, dynamic>? body}) async {
    http.Response response = await http.patch(Uri.parse(url),
        headers: headers, body: body != null ? jsonEncode(body) : null);
    return _processResponse(response, fromJson);
  }

  ///delete api request
  Future<T> delete<T>(
      String url, T Function(Map<String, dynamic> json) fromJson) async {
    http.Response response =
        await http.delete(Uri.parse(url), headers: headers);
    return _processResponse(response, fromJson);
  }

  ///check if the response is valid (everything went fine) / else throw error
  T _processResponse<T>(
      var response, T Function(Map<String, dynamic> json) fromJson) {
    debugPrint('url:- ${response.request?.url}');
    debugPrint('statusCode:- ${response.statusCode}');
    debugPrint('response:- ${response.body}');

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return fromJson(jsonData);
    } else {
      throw Exception('Data parsing error');
    }
  }
}
