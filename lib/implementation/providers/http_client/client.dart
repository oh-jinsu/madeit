import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:madeit/implementation/providers/http_client/response.dart';
import 'package:madeit/utilities/debug.dart';

String host = "";

Future<Response> get(
  String endpoint, {
  Map<String, String>? headers,
}) async {
  final result = await http.get(toFullUri(endpoint), headers: headers);

  return parseBody(result);
}

Future<Response> post(
  String endpoint, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final result = await http.post(
    toFullUri(endpoint),
    headers: withContentTypeHeader(headers),
    body: stringify(body),
    encoding: encoding,
  );

  return parseBody(result);
}

Future<Response> put(
  String endpoint, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final result = await http.put(
    toFullUri(endpoint),
    headers: withContentTypeHeader(headers),
    body: stringify(body),
    encoding: encoding,
  );

  return parseBody(result);
}

Future<Response> patch(
  String endpoint, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final result = await http.patch(
    toFullUri(endpoint),
    headers: withContentTypeHeader(headers),
    body: stringify(body),
    encoding: encoding,
  );

  return parseBody(result);
}

Future<Response> delete(
  String endpoint, {
  Map<String, String>? headers,
  Object? body,
  Encoding? encoding,
}) async {
  final result = await http.delete(
    toFullUri(endpoint),
    headers: withContentTypeHeader(headers),
    body: stringify(body),
    encoding: encoding,
  );

  return parseBody(result);
}

Future<Response> multipart(
  String endpoint, {
  String method = "POST",
  required File file,
  Map<String, String>? headers,
}) async {
  final request = http.MultipartRequest(
    method,
    toFullUri(endpoint),
  );

  if (headers != null) {
    request.headers.addAll(headers);
  }

  final mutlipartFile = await http.MultipartFile.fromPath("file", file.path);

  request.files.add(mutlipartFile);

  final streamedResponse = await request.send();

  final result = await http.Response.fromStream(streamedResponse);

  return parseBody(result);
}

Response parseBody(http.Response response) {
  show(
    "Response status ${response.statusCode} from ${response.request?.url} (${response.request?.method})",
  );

  if (response.statusCode == 204) {
    return const SuccessResponse(body: null);
  }

  final body = jsonDecode(response.body);

  show("Response Body: $body");

  if (response.statusCode ~/ 100 == 2) {
    return SuccessResponse(body: body);
  }

  final code = body["code"];

  final message = body["message"];

  return FailureResponse(code: code, message: message);
}

Uri toFullUri(String endpoint) {
  final url = "$host/$endpoint";

  show("Request $url");

  return Uri.parse(url);
}

String? stringify(Object? body) {
  if (body == null) {
    return null;
  }

  return jsonEncode(body);
}

Map<String, String> withContentTypeHeader(Map<String, String>? headers) {
  final result = headers ?? {};

  result[HttpHeaders.contentTypeHeader] = "application/json;charset=utf-8";

  return result;
}
