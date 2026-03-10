class ProfileModel {
  final String enrollmentNo;
  final String name;
  final String school;
  final String degree;
  final String? specialization;
  final int admissionYear;
  final bool isLe;
  final String gender;
  final String category;
  final String? subCategory;
  final String? phone;
  final String? email;
  final String? parentPhone;
  final String? parentEmail;
  final String? parentName;
  final String? parentProfession;
  final String? correspondenceAddress;
  final String? permanentAddress;
  final String? photographUrl;
  final String? signatureUrl;
  final String verificationStatus;
  final bool isActive;

  ProfileModel({
    required this.enrollmentNo,
    required this.name,
    required this.school,
    required this.degree,
    required this.admissionYear,
    required this.isLe,
    required this.gender,
    required this.category,
    required this.verificationStatus,
    required this.isActive,
    this.specialization,
    this.subCategory,
    this.phone,
    this.email,
    this.parentPhone,
    this.parentEmail,
    this.parentName,
    this.parentProfession,
    this.correspondenceAddress,
    this.permanentAddress,
    this.photographUrl,
    this.signatureUrl,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      enrollmentNo: json['enrollmentNo']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      school: json['school']?.toString() ?? '',
      degree: json['degree']?.toString() ?? '',
      specialization: json['specialization']?.toString(),
      admissionYear: json['admissionYear'] ?? 0,
      isLe: json['isLe'] ?? false,
      gender: json['gender']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      subCategory: json['subCategory']?.toString(),
      phone: json['phone']?.toString(),
      email: json['email']?.toString(),
      parentPhone: json['parentPhone']?.toString(),
      parentEmail: json['parentEmail']?.toString(),
      parentName: json['parentName']?.toString(),
      parentProfession: json['parentProfession']?.toString(),
      correspondenceAddress: json['correspondenceAddress']?.toString(),
      permanentAddress: json['permanentAddress']?.toString(),
      photographUrl: json['photographUrl']?.toString(),
      signatureUrl: json['signatureUrl']?.toString(),
      verificationStatus: json['verificationStatus']?.toString() ?? '',
      isActive: json['isActive'] ?? false,
    );
  }
}
