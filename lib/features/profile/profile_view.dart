import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [

              /// HEADER
              _buildHeader(context),

              /// PROFILE TOP SECTION
              _buildProfileHeader(context),

              const SizedBox(height: 16),

              /// ACADEMIC DETAILS
              _buildAcademicSection(context),

              const SizedBox(height: 24),

              /// CONTACT INFO
              _buildContactSection(context),

              const SizedBox(height: 24),

              /// ADDRESS
              _buildAddressSection(context),

              const SizedBox(height: 32),

              /// LOGOUT + VERSION
              _buildFooter(context),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          const Spacer(),
          Text(
            "Student Profile",
            style: theme.textTheme.headlineMedium,
          ),
          const Spacer(),
          const SizedBox(width: 48), // Balance spacing
        ],
      ),
    );
  }

  // ================= PROFILE TOP =================

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      color: Colors.white,
      child: Column(
        children: [

          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: colors.primary.withOpacity(0.1),
                child: const Icon(Icons.person, size: 60),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: colors.primary,
                  child: const Icon(Icons.edit,
                      size: 16, color: Colors.white),
                ),
              )
            ],
          ),

          const SizedBox(height: 16),

          Text(
            "Arjun Mehra",
            style: theme.textTheme.headlineLarge,
          ),

          const SizedBox(height: 4),

          Text(
            "Enrollment: 00116403221",
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: colors.primary),
          ),

          const SizedBox(height: 8),

          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Active Student",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  // ================= ACADEMIC =================

  Widget _buildAcademicSection(BuildContext context) {
    // final theme = Theme.of(context);
    // final colors = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _sectionTitle(context, Icons.school, "ACADEMIC DETAILS"),

          const SizedBox(height: 12),

          _infoCard(
            context,
            items: {
              "School": "USICT",
              "Degree": "B.Tech",
              "Branch": "Computer Science & Engineering",
              "Year / Semester": "3rd Year / 6th Semester",
            },
          ),
        ],
      ),
    );
  }

  // ================= CONTACT =================

  Widget _buildContactSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _sectionTitle(context, Icons.contact_mail, "CONTACT INFO"),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: Column(
              children: [
                _contactItem(
                  icon: Icons.mail,
                  label: "Email Address",
                  value: "arjun.mehra21@ipu.ac.in",
                ),
                const SizedBox(height: 16),
                _contactItem(
                  icon: Icons.call,
                  label: "Phone Number",
                  value: "+91 98765 43210",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= ADDRESS =================

  Widget _buildAddressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          _sectionTitle(context, Icons.location_on, "ADDRESS"),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: _cardDecoration(),
            child: const Text(
              "H-42, Second Floor, Sector 15,\n"
              "Dwarka, New Delhi - 110078,\n"
              "India",
            ),
          ),
        ],
      ),
    );
  }

  // ================= FOOTER =================

  Widget _buildFooter(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          width: 250,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.primary,
              side: BorderSide(color: colors.primary, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () {},
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "App Version v1.0.0",
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }

  // ================= HELPERS =================

  Widget _sectionTitle(BuildContext context, IconData icon, String text) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: [
        Icon(icon, color: colors.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: theme.textTheme.labelMedium
              ?.copyWith(letterSpacing: 1.2),
        ),
      ],
    );
  }

  Widget _infoCard(BuildContext context,
      {required Map<String, String> items}) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: items.entries.map((entry) {
          return Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key,
                      style: theme.textTheme.bodySmall),
                  Expanded(
                    child: Text(
                      entry.value,
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (entry.key != items.keys.last)
                const Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _contactItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.red.withOpacity(0.1),
          child: Icon(icon, color: Colors.red),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey)),
            Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.shade200),
    );
  }
}