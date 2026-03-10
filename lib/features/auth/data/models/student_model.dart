class StudentModel {
  final String name;
  final String enrollmentNo;
  final String verificationStatus;
  final bool isActive;
  final int profileCompletion;

  StudentModel({
    required this.name,
    required this.enrollmentNo,
    required this.verificationStatus,
    required this.isActive,
    required this.profileCompletion,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json["name"],
      enrollmentNo: json["enrollmentNo"],
      verificationStatus: json["verificationStatus"],
      isActive: json["isActive"],
      profileCompletion: json["profileCompletion"],
    );
  }
}