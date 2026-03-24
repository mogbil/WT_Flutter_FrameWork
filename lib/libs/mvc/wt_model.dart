// ************************************************************
// * WT Flutter FrameWork
// * @version : 1.0
// * @copyright : 2024 WondTech for Integrated Digital Solutions
// * @link : http://www.wondtech.com
// ************************************************************

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/wt_config.dart';
import '../helpers/wt_security.dart';

abstract class WtModel<T> {
  String get endpoint;

  T fromJson(Map<String, dynamic> json);

  List<T> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<T> fetch({Map<String, String>? params}) async {
    final uri = _buildUri(params);
    final response = await http.get(uri, headers: _headers());
    _checkStatus(response);
    return fromJson(json.decode(response.body));
  }

  Future<List<T>> fetchAll({Map<String, String>? params}) async {
    final uri = _buildUri(params);
    final response = await http.get(uri, headers: _headers());
    _checkStatus(response);
    final data = json.decode(response.body) as List;
    return fromJsonList(data);
  }

  Future<T> create(Map<String, dynamic> data) async {
    final uri = _buildUri(null);
    final response = await http.post(
      uri,
      headers: _headers(),
      body: json.encode(WtSecurity.sanitize(data)),
    );
    _checkStatus(response);
    return fromJson(json.decode(response.body));
  }

  Future<T> update(String id, Map<String, dynamic> data) async {
    final uri = Uri.parse('${WtConfig.instance.baseUrl}$endpoint/$id');
    final response = await http.put(
      uri,
      headers: _headers(),
      body: json.encode(WtSecurity.sanitize(data)),
    );
    _checkStatus(response);
    return fromJson(json.decode(response.body));
  }

  Future<bool> delete(String id) async {
    final uri = Uri.parse('${WtConfig.instance.baseUrl}$endpoint/$id');
    final response = await http.delete(uri, headers: _headers());
    _checkStatus(response);
    return response.statusCode == 200;
  }

  Uri _buildUri(Map<String, String>? params) {
    final base = '${WtConfig.instance.baseUrl}$endpoint';
    return params != null
        ? Uri.parse(base).replace(queryParameters: params)
        : Uri.parse(base);
  }

  Map<String, String> _headers() => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-WT-Key': WtConfig.instance.secretKey,
      };

  void _checkStatus(http.Response response) {
    if (response.statusCode >= 400) {
      throw WtModelException(
        'HTTP ${response.statusCode}: ${response.body}',
        response.statusCode,
      );
    }
  }
}

class WtModelException implements Exception {
  final String message;
  final int statusCode;
  WtModelException(this.message, this.statusCode);
  @override
  String toString() => 'WtModelException($statusCode): $message';
}
