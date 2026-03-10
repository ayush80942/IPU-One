class RegisterRequestModel {
  final String enrollmentNo;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.enrollmentNo,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "enrollmentNo": enrollmentNo,
      "email": email,
      "password": password,
    };
  }
}