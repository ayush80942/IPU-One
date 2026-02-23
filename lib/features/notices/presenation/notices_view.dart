import 'package:flutter/material.dart';

class NoticesView extends StatefulWidget {
  const NoticesView({super.key});

  @override
  State<NoticesView> createState() => _NoticesViewState();
}

class _NoticesViewState extends State<NoticesView> {
  int selectedFilter = 0;

  final filters = [
    "All",
    "Exam",
    "Scholarship",
    "Internship",
    "Circular",
    "Placement"
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            /// HEADER + SEARCH + FILTERS
            _buildHeader(context),

            /// NOTICE LIST
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _noticeCard(
                    context,
                    category: "Exam",
                    badge: "Urgent",
                    badgeColor: colors.primary,
                    title:
                        "End Term Examination Schedule - Dec 2025",
                    description:
                        "The University has released the tentative datesheet for all UG/PG programs...",
                    date: "20 Oct 2025",
                    isPdf: true,
                    actionText: "exam_schedule_2025.pdf",
                  ),
                  const SizedBox(height: 16),
                  _noticeCard(
                    context,
                    category: "Placement",
                    badge: "New",
                    badgeColor: Colors.blue,
                    title:
                        "Campus Recruitment Drive: TechCorp Ltd",
                    description:
                        "TechCorp is visiting for the 2026 graduating batch for Software Engineering roles...",
                    date: "18 Oct 2025",
                    isPdf: false,
                    actionText: "Register on Portal",
                  ),
                  const SizedBox(height: 16),
                  _noticeCard(
                    context,
                    category: "Circular",
                    badge: null,
                    badgeColor: null,
                    title:
                        "Winter Break Announcement 2025",
                    description:
                        "The University will remain closed for winter vacations from 25th December 2025...",
                    date: "15 Oct 2025",
                    isPdf: true,
                    actionText: "winter_break_notice.pdf",
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Title + Bell
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notices",
                style: theme.textTheme.headlineLarge
                    ?.copyWith(color: colors.primary),
              ),
              CircleAvatar(
                backgroundColor:
                    colors.primary.withOpacity(0.1),
                child: Icon(Icons.notifications,
                    color: colors.primary),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Search
          TextField(
            decoration: InputDecoration(
              hintText: "Search notices, circulars...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Filter Chips
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected =
                    selectedFilter == index;

                return ChoiceChip(
                  label: Text(filters[index]),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() =>
                        selectedFilter = index);
                  },
                  selectedColor: colors.primary,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= NOTICE CARD =================

  Widget _noticeCard(
    BuildContext context, {
    required String category,
    required String title,
    required String description,
    required String date,
    required bool isPdf,
    required String actionText,
    String? badge,
    Color? badgeColor,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
            color: badge == "Urgent"
                ? colors.primary.withOpacity(0.4)
                : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          /// Top Row
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    category.toUpperCase(),
                    style: theme.textTheme.labelMedium,
                  ),
                  if (badge != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4),
                      decoration: BoxDecoration(
                        color: badgeColor,
                        borderRadius:
                            BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
              Text(
                date,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: theme.textTheme.bodyLarge
                ?.copyWith(
                    fontWeight:
                        FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(
            description,
            style: theme.textTheme.bodyMedium
                ?.copyWith(
                    color: Colors.grey),
          ),

          const SizedBox(height: 16),

          const Divider(),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isPdf
                        ? Icons.picture_as_pdf
                        : Icons.link,
                    color: colors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    actionText,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  isPdf
                      ? Icons.download
                      : Icons.chevron_right,
                  color: colors.primary,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}