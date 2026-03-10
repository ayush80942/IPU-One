import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';

class DocumentsCard extends StatelessWidget {
  final ProfileModel profile;

  const DocumentsCard(this.profile, {super.key});

  @override
  Widget build(BuildContext context) {

    Widget box(String label, String? url) {
      return Expanded(
        child: Column(
          children: [

            Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                    fontWeight: FontWeight.w600)),

            const SizedBox(height: 8),

            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: url != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(url, fit: BoxFit.cover),
                    )
                  : const Center(child: Text("Empty")),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Row(
                children: const [
                  Icon(Icons.description_outlined, color: Color(0xFF7A0C0C)),
                  SizedBox(width: 8),
                  Text(
                    "KYC Documents",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  box("Photograph", profile.photographUrl),
                  const SizedBox(width: 12),
                  box("Signature", profile.signatureUrl),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}