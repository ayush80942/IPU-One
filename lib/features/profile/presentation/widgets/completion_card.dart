import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class CompletionCard extends StatelessWidget {
  final ProfileModel profile;

  const CompletionCard(this.profile, {super.key});

  int _calculateCompletion(ProfileModel p) {
    final fields = [
      p.name,
      p.school,
      p.degree,
      p.specialization,
      p.gender,
      p.category,
      p.subCategory,
      p.phone,
      p.email,
      p.parentPhone,
      p.parentEmail,
      p.parentName,
      p.parentProfession,
      p.correspondenceAddress,
      p.permanentAddress,
      p.photographUrl,
      p.signatureUrl,
    ];

    final total = fields.length;
    final filled =
        fields.where((f) => f != null && f.toString().trim().isNotEmpty).length;

    return ((filled / total) * 100).round();
  }

  int _remaining(ProfileModel p) {
    final fields = [
      p.name,
      p.school,
      p.degree,
      p.specialization,
      p.gender,
      p.category,
      p.subCategory,
      p.phone,
      p.email,
      p.parentPhone,
      p.parentEmail,
      p.parentName,
      p.parentProfession,
      p.correspondenceAddress,
      p.permanentAddress,
      p.photographUrl,
      p.signatureUrl,
    ];

    final total = fields.length;
    final filled =
        fields.where((f) => f != null && f.toString().trim().isNotEmpty).length;

    return total - filled;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final completion = _calculateCompletion(profile);
    final remaining = _remaining(profile);

    if (completion == 100) {
      return const SizedBox();
    }

    final progress = completion / 100;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      size: 20,
                      color: colors.primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      "Profile Completion",
                      style: theme.textTheme.headlineMedium,
                    ),
                  ),

                  Text(
                    "$completion%",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation(colors.primary),
                ),
              ),

              const SizedBox(height: 10),

              Text(
                remaining == 1
                    ? "Complete 1 more field to finish your profile."
                    : "Complete $remaining more fields to finish your profile.",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}