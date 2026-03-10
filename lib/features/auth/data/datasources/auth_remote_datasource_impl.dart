import 'package:dio/dio.dart';
import 'package:ipu_one/features/auth/data/datasources/auth_remote_datasource.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/check_enrollment_request_model.dart';
import '../models/check_enrollment_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.login,
        data: request.toJson(),
      );

      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Login failed");
    }
  }

  @override
  Future<CheckEnrollmentResponseModel> checkEnrollment(
    CheckEnrollmentRequestModel request,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.checkEnrollment,
        data: request.toJson(),
      );

      return CheckEnrollmentResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Enrollment check failed");
    }
  }

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final response = await _dio.post(
        ApiConstants.register,
        data: request.toJson(),
      );

      return RegisterResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Registration failed");
    }
  }

  @override
  Future<void> verifyEmail(String email, String otp) async {
    try {
      await _dio.post(
        ApiConstants.verifyEmail,
        data: {"email": email, "otp": otp},
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Verification failed");
    }
  }

  @override
  Future<void> resendOtp(String email) async {
    try {
      await _dio.post(ApiConstants.resendOtp, data: {"email": email});
    } on DioException catch (e) {
      throw Exception(e.response?.data["message"] ?? "Failed to resend OTP");
    }
  }
}
