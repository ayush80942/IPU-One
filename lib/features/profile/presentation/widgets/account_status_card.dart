import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class AccountStatusCard extends StatelessWidget {
  final ProfileModel profile;

  const AccountStatusCard(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  const Text("Account Status"),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text("Active"),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Text("Last Database Sync"),
              const SizedBox(height: 4),
              const Text("22 Oct 2023, 10:45 AM"),

              const SizedBox(height: 10),

              const Text("Digital ID UID"),
              const SizedBox(height: 4),
              Text(profile.enrollmentNo),
            ],
          ),
        ),
      ),
    );
  }
}