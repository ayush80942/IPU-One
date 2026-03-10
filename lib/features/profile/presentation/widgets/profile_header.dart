import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;

  const ProfileHeader(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final bool isVerified = profile.verificationStatus == "VERIFIED";

    return Column(
      children: [

        const SizedBox(height: 20),

        Stack(
          alignment: Alignment.bottomRight,
          children: [

            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 3,
                ),
              ),
              child: CircleAvatar(
                radius: 42,
                backgroundImage: profile.photographUrl != null
                    ? NetworkImage(profile.photographUrl!)
                    : null,
                child: profile.photographUrl == null
                    ? const Icon(Icons.person, size: 32)
                    : null,
              ),
            ),

            if (isVerified)
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(
                  Icons.check,
                  size: 14,
                  color: Colors.white,
                ),
              )
          ],
        ),

        const SizedBox(height: 12),

        Text(
          profile.name,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "${profile.school} | ${profile.degree}${profile.specialization != null ? " ${profile.specialization}" : ""}",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: colors.primary,
          ),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                profile.enrollmentNo,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 18),
      ],
    );
  }
}