import 'package:dio/dio.dart';
import 'package:stickify/core/logger.dart';

final dio = Dio();

String serverHost() {
  final url = 'http://localhost:8080';
  logger.i('URL: $url');
  return url;
}
