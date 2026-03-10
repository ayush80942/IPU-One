class CheckEnrollmentResponseModel {
  final bool exists;
  final bool isRegistered;
  final bool isActive;
  final String verificationStatus;
  final int profileCompletion;

  CheckEnrollmentResponseModel({
    required this.exists,
    required this.isRegistered,
    required this.isActive,
    required this.verificationStatus,
    required this.profileCompletion,
  });

  factory CheckEnrollmentResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckEnrollmentResponseModel(
      exists: json["exists"] ?? false,
      isRegistered: json["registered"] ?? false,
      isActive: json["active"] ?? false,
      verificationStatus: json["verificationStatus"] ?? "",
      profileCompletion: json["profileCompletion"] ?? 0,
    );
  }
}
