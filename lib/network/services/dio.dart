import 'package:dio/dio.dart';

Dio dio() {
  Dio dio = new Dio();
  // dio.options.baseUrl = 'http://10.0.2.2:8000/api';
//dio.options.baseUrl = 'http://localhost:8000/api';
  dio.options.baseUrl = 'http://192.168.1.65:8000/api';
  dio.options.headers['accept'] = 'Application/Json';
  return dio;
}
