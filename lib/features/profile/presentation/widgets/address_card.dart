import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String? address;

  const AddressCard({
    super.key,
    required this.title,
    this.address,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.location_on_outlined),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(address ?? "Not Provided"),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}