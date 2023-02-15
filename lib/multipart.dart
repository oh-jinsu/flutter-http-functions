import 'dart:io';

import 'package:http/http.dart' as http;
import "package:http_parser/http_parser.dart" as parser;

Future<http.Response> multipart(
  String uri, {
  Map<String, String>? headers,
  required File file,
}) async {
  final request = http.MultipartRequest("POST", Uri.parse(uri));

  if (headers != null) {
    request.headers.addAll(headers);
  }

  final split = file.path.split("/");

  final last = split[split.length - 1].split(".");

  final extension = last.length > 1 ? last[1] : "";

  final multipartFile = await http.MultipartFile.fromPath(
    "file",
    file.path,
    contentType: parser.MediaType("image", extension),
  );

  request.files.add(multipartFile);

  final stream = await request.send();

  return http.Response.fromStream(stream);
}
