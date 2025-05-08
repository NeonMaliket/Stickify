import 'package:dio/dio.dart';
import 'package:stickify/core/logger.dart';

final dio = Dio();


String serverHost() {
  final url  = 'https://0fd7-178-158-193-142.ngrok-free.app';
  logger.i('URL: $url');
  return url;
}
