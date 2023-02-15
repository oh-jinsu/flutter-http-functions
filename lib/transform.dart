import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_functions/response.dart';

FutureOr<Response> transform(FutureOr<http.Response> response) async {
  final res = await response;

  final statusCode = res.statusCode;

  final body =
      res.body.isNotEmpty ? jsonDecode(utf8.decode(res.bodyBytes)) : null;

  if (statusCode < 400) {
    return SuccessResponse(
      body: body,
    );
  } else {
    return FailureResponse(
      statusCode: statusCode,
      message: body["message"] ?? body,
    );
  }
}
