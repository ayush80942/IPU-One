import 'package:flutter/material.dart';
import 'package:ipu_one/features/auth/presentation/sign_in_view.dart';

class EnrollView extends StatelessWidget {
  const EnrollView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              /// Logo + Title
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.school, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "IPU One",
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: colors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// Main Heading
              Text(
                "Official Student Services",
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineLarge,
              ),

              const SizedBox(height: 10),

              Text(
                "Access your academic records securely",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 40),

              /// Step Indicator
              Row(
                children: [
                  _stepItem(context, true, Icons.fingerprint, "STEP 1: VERIFY"),
                  const Expanded(child: Divider()),
                  _stepItem(
                    context,
                    false,
                    Icons.verified_user,
                    "STEP 2: AUTH",
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

                      const TextField(
                        decoration: InputDecoration(
                          hintText: "e.g. 00116403221",
                          prefixIcon: Icon(Icons.badge_outlined),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInView(),
                              ),
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

              const SizedBox(height: 30),

              /// Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(context, true),
                  _dot(context, false),
                  _dot(context, false),
                ],
              ),

              const SizedBox(height: 40),

              /// Support
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                  children: [
                    const TextSpan(text: "Having trouble? "),
                    TextSpan(
                      text: "Contact University Support",
                      style: TextStyle(
                        color: colors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// Security Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      "SECURE 256-BIT ENCRYPTION",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stepItem(
    BuildContext context,
    bool active,
    IconData icon,
    String label,
  ) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: active ? colors.primary : Colors.grey.shade300,
          child: Icon(icon, color: active ? Colors.white : Colors.grey),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: active ? colors.primary : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _dot(BuildContext context, bool active) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: active ? colors.primary : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
