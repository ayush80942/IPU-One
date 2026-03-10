import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../data/models/check_enrollment_request_model.dart';
import '../../data/models/login_request_model.dart';
import '../../data/domain/repositories/auth_repository.dart';
import '../../data/models/register_request_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  final SecureStorageService storage;

  AuthCubit({required this.repository, required this.storage})
    : super(AuthInitial());

  Future<void> checkEnrollment(String enrollmentNo) async {
    emit(EnrollmentChecking());

    try {
      final response = await repository.checkEnrollment(
        CheckEnrollmentRequestModel(enrollmentNo: enrollmentNo),
      );

      emit(EnrollmentChecked(response));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String enrollmentNo, String password) async {
    emit(AuthLoading());

    try {
      final response = await repository.login(
        LoginRequestModel(enrollmentNo: enrollmentNo, password: password),
      );

      await storage.saveTokens(response.accessToken, response.refreshToken);

      emit(AuthAuthenticated(response.student));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String enrollmentNo,
    required String email,
    required String password,
  }) async {
    emit(RegistrationLoading());

    try {
      final response = await repository.register(
        RegisterRequestModel(
          enrollmentNo: enrollmentNo,
          email: email,
          password: password,
        ),
      );

      if (response.success) {
        emit(RegistrationSuccess(response.message));
      } else {
        emit(AuthError(response.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> verifyEmail({required String email, required String otp}) async {
    emit(OtpVerifying());

    try {
      await repository.verifyEmail(email, otp);
      emit(OtpVerified());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resendOtp(String email) async {
    try {
      await repository.resendOtp(email);
      emit(OtpResent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
