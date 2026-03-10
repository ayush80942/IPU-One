import '../../domain/repositories/auth_repository.dart';
import '../../datasources/auth_remote_datasource.dart';
import '../../models/check_enrollment_request_model.dart';
import '../../models/check_enrollment_response_model.dart';
import '../../models/login_request_model.dart';
import '../../models/login_response_model.dart';
import '../../models/register_request_model.dart';
import '../../models/register_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) {
    return remoteDataSource.login(request);
  }

  @override
  Future<CheckEnrollmentResponseModel> checkEnrollment(
    CheckEnrollmentRequestModel request,
  ) {
    return remoteDataSource.checkEnrollment(request);
  }

  @override
  Future<RegisterResponseModel> register(RegisterRequestModel request) {
    return remoteDataSource.register(request);
  }

  @override
  Future<void> verifyEmail(String email, String otp) {
    return remoteDataSource.verifyEmail(email, otp);
  }

  @override
  Future<void> resendOtp(String email) {
    return remoteDataSource.resendOtp(email);
  }
}
