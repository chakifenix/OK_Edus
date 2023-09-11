import 'package:dio/dio.dart';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  late final Dio dio;
  //final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Api() {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://mobile.mektep.edu.kz',
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );

    dio = Dio(options);
    String? token = '2075|rYtI0FPM0gXXYpKkBK4LomBc2vknbI8twpbOP8T6';
    // await secureStorage.read(key: 'access_token') ?? 'null';

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer $token';
          options.headers['accept'] = 'application/json';
          print('Request Headers: ${options.headers}');
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response> fetchData(String endpoint) async {
    try {
      Response response = await dio.get(endpoint);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
