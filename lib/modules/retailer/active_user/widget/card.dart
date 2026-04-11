import 'package:flutter/material.dart';
import 'package:zlock_smart_finance/model/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Key ID: ${user.keyId}',
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const Spacer(),
              _statusChip(),
            ],
          ),
          const Divider(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/user.png',
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(child: _details()),
              const VerticalDivider(),
              _tags(),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff4F6BED),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.qr_code)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          )
        ],
      ),
    );
  }

  Widget _details() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Name: ${user.name}'),
      Text('Mobile: ${user.mobile}'),
      Text('IMEI: ${user.imei}'),
      Text('Created by: ${user.createdDate}'),
      const SizedBox(height: 4),
      Chip(label: Text(user.emi)),
    ],
  );

  Widget _tags() => Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: const [
      Chip(label: Text('OPPO')),
      Chip(label: Text('BANK OF BARODA')),
      Chip(label: Text('Today, 10:28 AM')),
    ],
  );

  Widget _statusChip() => Chip(
    backgroundColor: Colors.green.shade50,
    label: const Text('Active',
        style: TextStyle(color: Colors.green)),
  );
}
