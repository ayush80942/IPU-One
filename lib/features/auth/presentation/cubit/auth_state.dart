import 'package:equatable/equatable.dart';
import '../../data/models/check_enrollment_response_model.dart';
import '../../data/models/student_model.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class EnrollmentChecking extends AuthState {}

class RegistrationLoading extends AuthState {}

class OtpVerifying extends AuthState {}

class OtpVerified extends AuthState {}

class OtpResent extends AuthState {}

class RegistrationSuccess extends AuthState {
  final String message;

  RegistrationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class EnrollmentChecked extends AuthState {
  final CheckEnrollmentResponseModel response;

  EnrollmentChecked(this.response);

  @override
  List<Object?> get props => [response];
}

class AuthAuthenticated extends AuthState {
  final StudentModel student;

  AuthAuthenticated(this.student);

  @override
  List<Object?> get props => [student];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}