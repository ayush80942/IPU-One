import '../../models/check_enrollment_request_model.dart';
import '../../models/check_enrollment_response_model.dart';
import '../../models/login_request_model.dart';
import '../../models/login_response_model.dart';
import '../../models/register_request_model.dart';
import '../../models/register_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<CheckEnrollmentResponseModel> checkEnrollment(
    CheckEnrollmentRequestModel request,
  );
  Future<RegisterResponseModel> register(RegisterRequestModel request);
  Future<void> verifyEmail(String email, String otp);
  Future<void> resendOtp(String email);
}
