import 'package:flutter/material.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            /// HEADER
            _buildHeader(context),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                children: [

                  /// CREATE REQUEST BUTTON
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add_circle),
                    label: const Text(
                      "Create New Request",
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {},
                  ),

                  const SizedBox(height: 32),

                  /// RECENT ACTIVITY TITLE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "RECENT ACTIVITY",
                        style: theme.textTheme.labelMedium
                            ?.copyWith(letterSpacing: 1.5),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list, size: 18),
                        label: const Text("Filter"),
                      )
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// REQUEST CARDS
                  _requestCard(
                    context,
                    title: "Bonafide Certificate",
                    id: "#REQ-1024",
                    date: "Oct 24, 2023",
                    status: RequestStatus.pending,
                  ),

                  const SizedBox(height: 16),

                  _requestCard(
                    context,
                    title: "Transcript Request",
                    id: "#REQ-1011",
                    date: "Oct 18, 2023",
                    status: RequestStatus.approved,
                  ),

                  const SizedBox(height: 16),

                  _requestCard(
                    context,
                    title: "Migration Certificate",
                    id: "#REQ-0988",
                    date: "Oct 12, 2023",
                    status: RequestStatus.rejected,
                  ),

                  const SizedBox(height: 40),

                  /// FOOTNOTE
                  Center(
                    child: Text(
                      "Only showing recent requests from the last 6 months.",
                      style: theme.textTheme.bodySmall
                          ?.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          Text(
            "Requests",
            style: theme.textTheme.headlineMedium,
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // ================= REQUEST CARD =================

  Widget _requestCard(
    BuildContext context, {
    required String title,
    required String id,
    required String date,
    required RequestStatus status,
  }) {
    final theme = Theme.of(context);
    final statusData = _statusStyle(status);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ID: $id",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusData.bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusData.label,
                  style: TextStyle(
                    color: statusData.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),

          /// BOTTOM ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    date,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: Icon(statusData.actionIcon, size: 18),
                label: Text(statusData.actionText),
              )
            ],
          ),
        ],
      ),
    );
  }

  // ================= STATUS STYLING =================

  _StatusData _statusStyle(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return _StatusData(
          label: "Pending",
          bgColor: Colors.amber.shade100,
          textColor: Colors.amber.shade800,
          actionText: "View Details",
          actionIcon: Icons.chevron_right,
        );

      case RequestStatus.approved:
        return _StatusData(
          label: "Approved",
          bgColor: Colors.green.shade100,
          textColor: Colors.green.shade800,
          actionText: "Download",
          actionIcon: Icons.download,
        );

      case RequestStatus.rejected:
        return _StatusData(
          label: "Rejected",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade800,
          actionText: "See Reason",
          actionIcon: Icons.info_outline,
        );
    }
  }
}

// ================= ENUM =================

enum RequestStatus { pending, approved, rejected }

class _StatusData {
  final String label;
  final Color bgColor;
  final Color textColor;
  final String actionText;
  final IconData actionIcon;

  _StatusData({
    required this.label,
    required this.bgColor,
    required this.textColor,
    required this.actionText,
    required this.actionIcon,
  });
}