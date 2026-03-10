class LoginRequestModel {
  final String enrollmentNo;
  final String password;

  LoginRequestModel({
    required this.enrollmentNo,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "enrollmentNo": enrollmentNo,
      "password": password,
    };
  }
}