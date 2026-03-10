import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class AcademicInfoCard extends StatelessWidget {
  final ProfileModel profile;

  const AcademicInfoCard(this.profile, {super.key});

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF64748B))),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
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
                  Icon(Icons.school_outlined, color: Color(0xFF7A0C0C)),
                  SizedBox(width: 8),
                  Text(
                    "Academic Details",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              _row("School of Study", profile.school),
              _row("Degree & Course", profile.degree),
              _row("Specialization", profile.specialization ?? "—"),
              _row("Admission Year", profile.admissionYear.toString()),
            ],
          ),
        ),
      ),
    );
  }
}