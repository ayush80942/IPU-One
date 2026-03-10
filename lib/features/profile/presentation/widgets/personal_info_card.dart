import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class PersonalInfoCard extends StatelessWidget {
  final ProfileModel profile;

  const PersonalInfoCard(this.profile, {super.key});

  Widget _item(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Row(
                children: const [
                  Icon(Icons.person_outline, color: Color(0xFF7A0C0C)),
                  SizedBox(width: 8),
                  Text(
                    "Personal Information",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  )
                ],
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _item("Gender", profile.gender),
                  _item("DOB", "—"),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _item("Category", profile.category),
                  _item("Phone", profile.phone ?? "Not Provided"),
                ],
              ),

              const SizedBox(height: 14),

              _item("Email Address", profile.email ?? "Not Provided"),
            ],
          ),
        ),
      ),
    );
  }
}