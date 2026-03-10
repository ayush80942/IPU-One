import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipu_one/features/auth/presentation/widgets/build_footer.dart';
import 'package:ipu_one/features/auth/presentation/widgets/build_header.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class OtpPage extends StatefulWidget {
  final String email;

  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  static const int otpLength = 6;
  static const int otpTimerSeconds = 30;

  final List<TextEditingController> _controllers = List.generate(
    otpLength,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    otpLength,
    (_) => FocusNode(),
  );

  bool _isLoading = false;

  int _secondsRemaining = otpTimerSeconds;
  Timer? _timer;

  String get _otp => _controllers.map((e) => e.text).join();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    setState(() {
      _secondsRemaining = otpTimerSeconds;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (final c in _controllers) {
      c.dispose();
    }

    for (final n in _focusNodes) {
      n.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is OtpVerifying) {
          setState(() => _isLoading = true);
        }

        if (state is OtpVerified) {
          setState(() => _isLoading = false);

          Navigator.popUntil(context, (route) => route.isFirst);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email verified successfully")),
          );
        }

        if (state is OtpResent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("OTP resent successfully")),
          );
        }

        if (state is AuthError) {
          setState(() => _isLoading = false);

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              buildHeader(context: context, isBack: true),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 32),

                      /// Title
                      Text(
                        "Verify Email",
                        style: theme.textTheme.headlineLarge,
                      ),

                      const SizedBox(height: 12),

                      /// Description
                      Text(
                        "A 6-digit code has been sent to your registered email address. Please enter it below to continue.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 32),

                      /// OTP Fields
                      _buildOtpFields(),

                      const SizedBox(height: 28),

                      /// Verify Button
                      _buildVerifyButton(theme),

                      const SizedBox(height: 28),

                      /// Timer
                      _buildOtpTimer(theme, colors),

                      /// Push bottom section down
                      const Spacer(),

                      /// Help Section
                      buildFooter(context: context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(otpLength, (index) => _buildOtpField(index)),
    );
  }

  Widget _buildVerifyButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: (_otp.length == otpLength && !_isLoading)
            ? () {
                context.read<AuthCubit>().verifyEmail(
                  email: widget.email,
                  otp: _otp,
                );
              }
            : null,
        child: _isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verify Identity"),
                  SizedBox(width: 8),
                  Icon(Icons.verified_user_outlined),
                ],
              ),
      ),
    );
  }

  Widget _buildOtpTimer(ThemeData theme, ColorScheme colors) {
    if (_secondsRemaining == 0) {
      return _buildResendButton(theme, colors);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: colors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.primary.withOpacity(0.20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTimerBox("00", "MIN", colors),
          const SizedBox(width: 40),
          _buildTimerBox(
            _secondsRemaining.toString().padLeft(2, '0'),
            "SEC",
            colors,
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String value, String label, ColorScheme colors) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.primary.withOpacity(0.2)),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: colors.primary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: colors.onSurface.withOpacity(0.6),
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildResendButton(ThemeData theme, ColorScheme colors) {
    return Column(
      children: [
        Text(
          "Didn't receive the code?",
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            _startTimer();
            context.read<AuthCubit>().resendOtp(widget.email);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh, color: colors.primary, size: 20),
              const SizedBox(width: 6),
              Text(
                "Resend OTP",
                style: TextStyle(
                  color: colors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 48,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(counterText: ""),
        onChanged: (value) {
          if (value.isNotEmpty && index < otpLength - 1) {
            _focusNodes[index + 1].requestFocus();
          }

          if (value.isEmpty && index > 0) {
            _focusNodes[index - 1].requestFocus();
          }

          setState(() {});
        },
      ),
    );
  }
}
