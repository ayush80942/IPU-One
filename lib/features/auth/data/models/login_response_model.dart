import 'student_model.dart';

class LoginResponseModel {
  final bool success;
  final String accessToken;
  final String refreshToken;
  final StudentModel student;

  LoginResponseModel({
    required this.success,
    required this.accessToken,
    required this.refreshToken,
    required this.student,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json["data"];

    return LoginResponseModel(
      success: json["success"],
      accessToken: data["accessToken"],
      refreshToken: data["refreshToken"],
      student: StudentModel.fromJson(data["student"]),
    );
  }
}