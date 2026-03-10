import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class GuardianInfoCard extends StatelessWidget {
  final ProfileModel profile;

  const GuardianInfoCard(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {

    final bool incomplete = profile.parentPhone == null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Row(
                children: [
                  const Icon(Icons.groups_outlined, color: Color(0xFF7A0C0C)),
                  const SizedBox(width: 8),
                  const Text(
                    "Guardian Information",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),

                  if (incomplete)
                    const Text(
                      "ACTION REQUIRED",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(profile.parentName ?? "Not Provided"),
                  Text(profile.parentProfession ?? "—"),
                ],
              ),

              const SizedBox(height: 8),

              Text(profile.parentPhone ?? "Not Provided"),
            ],
          ),
        ),
      ),
    );
  }
}