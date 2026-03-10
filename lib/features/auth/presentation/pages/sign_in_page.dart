import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipu_one/features/auth/presentation/widgets/build_footer.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../../../../core/navigation/app_shell.dart';
import '../widgets/build_header.dart';
import '../widgets/build_locked_field.dart';

class SignInPage extends StatefulWidget {
  final String enrollmentNo;

  const SignInPage({super.key, required this.enrollmentNo});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool obscurePassword = true;
  bool isSignIn = true;
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() => _isLoading = true);
        }

        if (state is AuthAuthenticated) {
          setState(() => _isLoading = false);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AppShell()),
            (route) => false,
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
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [  
                        Text(
                          "Welcome Back, Ayush",
                          style: theme.textTheme.headlineLarge,
                        ),
                                  
                        const SizedBox(height: 8),
                                  
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "Please enter the password to access your student dashboard",
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                                  
                        const SizedBox(height: 32),
                                  
                        /// Enrollment
                        buildLockedField(
                          context,
                          label: "ENROLLMENT NUMBER",
                          value: widget.enrollmentNo,
                        ),
                                  
                        const SizedBox(height: 20),
                                  
                        /// Password
                        _buildPasswordField(context),
                                  
                        const SizedBox(height: 12),
                                  
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                                  
                        const SizedBox(height: 28),
                                  
                        /// Sign In Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    final password = _passwordController.text
                                        .trim();
                                  
                                    if (password.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Password is required"),
                                        ),
                                      );
                                      return;
                                    }
                                  
                                    context.read<AuthCubit>().login(
                                      widget.enrollmentNo,
                                      password,
                                    );
                                  },
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Sign In to IPU One"),
                                      SizedBox(width: 8),
                                      Icon(Icons.login),
                                    ],
                                  ),
                          ),
                        ),
                                  
                        const SizedBox(height: 60),
                                  
                        buildFooter(context: context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PASSWORD",
          style: theme.textTheme.labelMedium?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: "Enter Password",
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () =>
                  setState(() => obscurePassword = !obscurePassword),
            ),
          ),
        ),
      ],
    );
  }
}
