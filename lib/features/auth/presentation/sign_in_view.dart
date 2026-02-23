import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool obscurePassword = true;
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            /// Top Header
            _buildHeader(context),

            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [

                    /// Icon Circle
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: colors.primary.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.account_balance,
                        size: 40,
                        color: colors.primary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "Welcome Back",
                      style: theme.textTheme.headlineLarge,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Please sign in to access your student dashboard",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.grey[600]),
                    ),

                    const SizedBox(height: 32),

                    /// Sign In / Sign Up Toggle
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isSignIn = true),
                            child: Column(
                              children: [
                                Text(
                                  "Sign In",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isSignIn
                                        ? colors.primary
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 2,
                                  color: isSignIn
                                      ? colors.primary
                                      : Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isSignIn = false),
                            child: Column(
                              children: [
                                Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: !isSignIn
                                        ? colors.primary
                                        : Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 2,
                                  color: !isSignIn
                                      ? colors.primary
                                      : Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    /// Enrollment
                    _buildLockedField(
                      context,
                      label: "ENROLLMENT NUMBER",
                      value: "04215003121",
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
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign In to IPU One"),
                            SizedBox(width: 8),
                            Icon(Icons.login),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),

                    /// Support Section
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("SUPPORT"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Need help with your account?",
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.grey[600]),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Contact University IT Support",
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              const Spacer(),
              Column(
                children: [
                  Text(
                    "IPU One",
                    style: theme.textTheme.headlineMedium
                        ?.copyWith(color: colors.primary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "STUDENT PORTAL",
                    style: theme.textTheme.labelMedium
                        ?.copyWith(letterSpacing: 2),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(width: 24),
            ],
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }

  Widget _buildLockedField(BuildContext context,
      {required String label, required String value}) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium
              ?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        TextField(
          enabled: false,
          controller: TextEditingController(text: value),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.badge_outlined),
            suffixIcon: Icon(Icons.lock),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "This ID is verified and locked to your device.",
          style: theme.textTheme.bodyMedium
              ?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "PASSWORD",
          style: theme.textTheme.labelMedium
              ?.copyWith(letterSpacing: 1.2),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: obscurePassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () =>
                  setState(() => obscurePassword = !obscurePassword),
            ),
          ),
        ),
      ],
    );
  }
}