import 'package:dio/dio.dart';
import 'package:ok_edus/model/user_model.dart';

class LoginService {
  @override
  Future<UserModel?> login(String email, String password) async {
    final api = 'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/login';
    final data = {"login": email, "password": password};

    final dio = Dio();
    Response response;

    try {
      response = await dio.post(api, data: data);
      if (response.statusCode == 200) {
        final body = response.data;
        print(body);
        return UserModel(email: email, token: body['access_token']);
      } else {
        return null;
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          print('Request failed with status code: ${e.response!.statusCode}');
        } else {
          print('Request failed without a response');
        }
      } else {
        print('An error occurred: $e');
      }
    }
  }
}
