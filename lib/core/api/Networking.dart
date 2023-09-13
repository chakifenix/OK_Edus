import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SubjectsService {
  static final String _baseUrl =
      'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru';
  static final storage = FlutterSecureStorage();

  static Future<Response<dynamic>> fetchSubjects(
      String input, String token) async {
    Dio dio = Dio();

    // dio.options.connectTimeout = 30000 as Duration?; // 5 секунд
    // dio.options.receiveTimeout = 30000 as Duration?; // 30 секунд

    final path = input; // Путь к эндпоинту API

    final url = '$_baseUrl$path';
    final response = await dio.get(
      url,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      }),
    );
    print('${url}');

    return response;
  }

  static Future<Response<dynamic>> fetchSubjectsPost(
      String id_predmet, String chetvert, String month) async {
    Dio dio = Dio();
    final path = '/jurnal-grades'; // Путь к эндпоинту API

    final url = '$_baseUrl$path';
    final data = {
      'id_predmet': id_predmet,
      'chetvert': chetvert,
      'month': month
    };

    Response response;

    response = await dio.post(
      url,
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1483|TyLoBW6gE53TmeuFn2yebIUgGeDcWf88cFiXrBXN',
      }),
    );
    return response;
  }

  late final Dio dio;
  static Future<Response<dynamic>> fetchProfile(String input) async {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://mobile.mektep.edu.kz',
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );
    Dio dio = Dio(options);

    final path = input; // Путь к эндпоинту API

    final url = '$_baseUrl$path';

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] =
              'Bearer 1483|TyLoBW6gE53TmeuFn2yebIUgGeDcWf88cFiXrBXN';
          options.headers['accept'] = 'application/json';
          print('Request Headers: ${options.headers}');
          return handler.next(options);
        },
      ),
    );
    print('${url}');
    final response = await dio.get(
      url,
    );

    return response;
  }

  static Future<Response<dynamic>> fetchChatPost(
      String socketId, String channelId, String token) async {
    Dio dio = Dio();
    final path = '/jurnal-grades'; // Путь к эндпоинту API

    final url =
        'https://mobile.mektep.edu.kz/api_ok_edus/public/broadcasting/auth';
    final data = {
      'socket_id': socketId,
      'channel_name': 'presence-chat.${channelId}',
    };

    Response response;

    response = await dio.post(
      url,
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token}',
      }),
    );
    return response;
  }

  static Future<Response<dynamic>> fetchChatHistoryPost(
      String channelId, String token) async {
    Dio dio = Dio();
    final url =
        'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/messenger/get-chat-history';
    final data = {'channel_id': 'presence-chat.$channelId', 'page': '1'};

    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
      print(response);
      return response;
    } catch (e) {
      print('status $e');
      throw e;
    }
  }

  static Future<Response<dynamic>> fetchSendMessageToWebSocket(
      String channelId, String socketId, String token) async {
    Dio dio = Dio();
    final url =
        'https://mobile.mektep.edu.kz/api_ok_edus/public/broadcasting/auth';
    final data = {
      'socket_id': '${socketId}',
      'channel_name': 'presence-chat.$channelId'
    };

    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }),
      );
      print(response);
      return response;
    } catch (e) {
      print('status $e');
      throw e;
    }
  }

  static Future<Response<dynamic>> fetchSendMessageToPerson(
      String channelId, String text, String token) async {
    Dio dio = Dio();
    final url =
        'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/messenger/send-message';
    final data = {'channel_id': '$channelId', 'text': '$text'};

    Response response;
    try {
      response = await dio.post(
        url,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}',
        }),
      );
      print(response);
      return response;
    } catch (e) {
      print('status $e');
      throw e;
    }
  }

  static Future<void> storeToken(String token) async {
    await storage.write(
      key: 'token',
      value: '$token',
    );
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}

// Future<void> chatSendMessage(String text) async {
//     var scopedToken = await SubjectsService.getToken();
//     Dio dio = Dio();
//     Response response;
//     final data = {
//       'channel_id': '${widget.chatModel.channelId}',
//       'text': '$text',
//     };
//     print(data);
//     try {
//       response = await dio.post(
//         'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/messenger/send-message',
//         data: data,
//         options: Options(headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer ${scopedToken}',
//         }),
//       );
//     } catch (e) {
//       if (e is DioError) {
//         if (e.response != null) {
//           //Text('data');
//           print('Request failed with status code: ${e.response!.statusCode}');
//         }
//       }
//       throw e; // Пробрасываем ошибку дальше
//     }
//   }

// Future<Map<String, dynamic>> chatHistoryApi() async {
//   Dio dio = Dio();
//   var scopedToken = await SubjectsService.getToken();
//   Response response;
//   print(widget.chatModel.channelId);
//   final data = {
//     'channel_id': '${widget.chatModel.channelId}',
//     'page': '1',
//   };
//   print(data);
//   try {
//     response = await dio.post(
//       'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/messenger/get-chat-history',
//       data: data,
//       options: Options(headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${scopedToken}',
//       }),
//     );

//     Map<String, dynamic> responseData = response.data;
//     print(responseData);
//     for (Map<String, dynamic> index in responseData['messages_list']) {
//       print(index);
//       messagesHistory.add(ChatHistoryModel.fromJson(index));
//     }
//     print(messagesHistory);

//     for (var item in messagesHistory) {
//       Map<String, dynamic> selectedItems = {
//         'text': item.text,
//         'is_my': item.isMy,
//         'date': item.date
//       };
//       mesages.add(selectedItems);
//       reversedItems = mesages.reversed.toList();
//       print(reversedItems);
//     }
//     setState(() {});

//     return responseData; // Возвращаем JSON-данные вместо response
//   } catch (e) {
//     if (e is DioError) {
//       if (e.response != null) {
//         //Text('data');
//         print('Request failed with status code: ${e.response!.statusCode}');
//       }
//     }
//     print(e);
//     throw e; // Пробрасываем ошибку дальше
//   }
// }


// Future<Map<String, dynamic>> sMesages() async {
//   var scopedToken = await SubjectsService.getToken();
//   Dio dio = Dio();
//   Response response;
//   final data = {
//     'socket_id': socketId,
//     'channel_name': 'presence-chat.${widget.chatModel.channelId}',
//   };
//   print(data);
//   try {
//     response = await dio.post(
//       'https://mobile.mektep.edu.kz/api_ok_edus/public/broadcasting/auth',
//       data: data,
//       options: Options(headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${scopedToken}',
//       }),
//     );

//     Map<String, dynamic> responseData = response.data;
//     jsonList = responseData;
//     //print(jsonList);
//     jsonList!['channel'] = "presence-chat.${widget.chatModel.channelId}";
//     print(jsonList);
//     sendMessage();
//     return responseData; // Возвращаем JSON-данные вместо response
//   } catch (e) {
//     if (e is DioError) {
//       if (e.response != null) {
//         //Text('data');
//         print('Request failed with status code: ${e.response!.statusCode}');
//       }
//     }
//     throw e; // Пробрасываем ошибку дальше
//   }
// }
