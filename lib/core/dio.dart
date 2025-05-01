import 'package:dio/dio.dart';
import 'package:stickify/core/logger.dart';

final dio = Dio();


String serverHost() {
  final url  = const String.fromEnvironment('STICKIFY_API', defaultValue: "http://10.0.2.2:8080");
  logger.i('URL: $url');
  return url;
}
