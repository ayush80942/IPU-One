import 'package:flutter/material.dart';
import 'package:ipu_one/features/auth/presentation/pages/otp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipu_one/features/auth/presentation/widgets/build_footer.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/build_header.dart';
import '../widgets/build_locked_field.dart';

class SignUpPage extends StatefulWidget {
  final String enrollmentNo;

  const SignUpPage({super.key, required this.enrollmentNo});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool _isValidPassword(String password) {
    final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return passwordRegex.hasMatch(password);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegistrationLoading) {
          setState(() => _isLoading = true);
        }

        if (state is RegistrationSuccess) {
          setState(() => _isLoading = false);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpPage(email: _emailController.text.trim()),
            ),
          );
        }

        if (state is AuthError) {
          setState(() => _isLoading = false);
          _showError(state.message);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildHeader(context: context, isBack: true),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        "Create Account",
                        style: theme.textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Register into the system to get started.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 32),

                      buildLockedField(
                        context,
                        label: "ENROLLMENT NUMBER",
                        value: widget.enrollmentNo,
                      ),
                      const SizedBox(height: 20),

      
                      _buildInputField(
                        context,
                        label: "E-MAIL ADDRESS",
                        controller: _emailController,
                        hint: "e.g. student@ipu.ac.in",
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 20),

                      _buildPasswordField(
                        label: "ENTER PASSWORD",
                        controller: _passwordController,
                        obscure: _obscurePassword,
                        hint: "Enter Password",
                        toggle: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      _buildPasswordField(
                        label: "CONFIRM PASSWORD",
                        controller: _confirmPasswordController,
                        obscure: _obscureConfirmPassword,
                        hint: "Confirm Password",
                        toggle: () {
                          setState(() {
                            _obscureConfirmPassword = !_obscureConfirmPassword;
                          });
                        },
                      ),

                      const SizedBox(height: 36),

                      /// Register Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: _isLoading
                              ? null
                              : () {
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text
                                      .trim();
                                  final confirmPassword =
                                      _confirmPasswordController.text.trim();

                                  if (email.isEmpty ||
                                      password.isEmpty ||
                                      confirmPassword.isEmpty) {
                                    _showError("All fields are required");
                                    return;
                                  }

                                  if (!_isValidEmail(email)) {
                                    _showError("Enter a valid email address");
                                    return;
                                  }

                                  if (!_isValidPassword(password)) {
                                    _showError(
                                      "Password must be at least 8 characters, include uppercase, lowercase and number",
                                    );
                                    return;
                                  }

                                  if (password != confirmPassword) {
                                    _showError("Passwords do not match");
                                    return;
                                  }

                                  context.read<AuthCubit>().register(
                                    enrollmentNo: widget.enrollmentNo,
                                    email: email,
                                    password: password,
                                  );
                                },
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      buildFooter(context: context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback toggle,
    required String hint,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: toggle,
            ),
          ),
        ),
      ],
    );
  }
}
