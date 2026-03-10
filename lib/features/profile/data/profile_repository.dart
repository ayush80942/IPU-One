import 'package:dio/dio.dart';
import 'package:ipu_one/core/storage/secure_storage_service.dart';
import 'models/profile_model.dart';

class ProfileRepository {
  final Dio dio;
  final SecureStorageService storage;

  ProfileRepository(this.dio, this.storage);

  Future<ProfileModel> getProfile() async {
    final token = await storage.getAccessToken();

    final response = await dio.get(
      "/student/profile",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return ProfileModel.fromJson(response.data["data"]);
  }
}