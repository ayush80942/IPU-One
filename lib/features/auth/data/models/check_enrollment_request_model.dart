class CheckEnrollmentRequestModel {
  final String enrollmentNo;

  CheckEnrollmentRequestModel({required this.enrollmentNo});

  Map<String, dynamic> toJson() {
    return {
      "enrollmentNo": enrollmentNo,
    };
  }
}