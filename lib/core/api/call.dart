import 'package:ok_edus/core/api/api-call2.dart';
import 'package:ok_edus/model/profile-model.dart';
//import 'package:ok_edus/repo/profile_data.dart';

//import 'api_name.dart';

class RepoProfile {
  final api = Api();

  Future<ResultRepoProfile> getProfile() async {
    try {
      final resultRequest = await api.dio.get(
        '/api_ok_edus/public/api/ru/profile',
      );
      final Map<String, dynamic> jsonDataMap = resultRequest.data ?? {};
      final result = ProfileModel.fromJson(jsonDataMap);

      return ResultRepoProfile(profileData: result);
    } catch (error) {
      return ResultRepoProfile(errorMessage: "Что-то пошло не так!");
    }
  }
}

class ResultRepoProfile {
  final String? errorMessage;
  final ProfileModel? profileData;

  ResultRepoProfile({
    this.errorMessage,
    this.profileData,
  });
}
