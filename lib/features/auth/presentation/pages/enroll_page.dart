import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipu_one/features/auth/presentation/pages/sign_in_page.dart';
import 'package:ipu_one/features/auth/presentation/pages/sign_up_page.dart';
import 'package:ipu_one/features/auth/presentation/widgets/build_footer.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/build_header.dart';

class EnrollView extends StatefulWidget {
  const EnrollView({super.key});

  @override
  State<EnrollView> createState() => _EnrollViewState();
}

class _EnrollViewState extends State<EnrollView> {
  final TextEditingController _controller = TextEditingController();

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is EnrollmentChecking) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is EnrollmentChecked) {
          Navigator.pop(context);
          if (!state.response.exists) {
            _showError("Enrollment number not found");
          } else if (!state.response.isRegistered) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    SignUpPage(enrollmentNo: _controller.text.trim()),
              ),
            );
          } else {
            
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    SignInPage(enrollmentNo: _controller.text.trim()),
              ),
            );
          }
        }

        if (state is AuthError) {
          Navigator.pop(context);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildHeader(context: context, isBack: false),

                Image.asset("assets/GGSIPU-logo.png", height: 160),

                /// Main Heading
                Text(
                  "Student ⇄ University",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),

                const SizedBox(height: 40),

                /// Step Indicator
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: colors.primary,
                        child: Icon(Icons.fingerprint, color: Colors.white),
                      ),
                    ),

                    const Expanded(child: Divider(color: Colors.grey)),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade300,
                        child: Icon(Icons.verified_user, color: Colors.grey),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Text(
                      "STEP 1: VERIFY",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.primary,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "STEP 2: AUTH",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                /// Enrollment Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enrollment Number",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 12),

                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            hintText: "e.g. 00116403221",
                            prefixIcon: Icon(Icons.badge_outlined),
                            counterText: "",
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                "Found on your GGSIPU ID card or admit card.",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final enrollment = _controller.text.trim();

                              if (enrollment.isEmpty) {
                                _showError("Please enter enrollment number");
                                return;
                              }

                              if (enrollment.length != 11) {
                                _showError(
                                  "Enrollment number must be 12 digits",
                                );
                                return;
                              }

                              context.read<AuthCubit>().checkEnrollment(
                                enrollment,
                              );
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Continue"),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// Support
                buildFooter(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
