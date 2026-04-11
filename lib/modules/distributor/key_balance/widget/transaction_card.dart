

import 'package:flutter/material.dart';
import 'package:zlock_smart_finance/modules/distributor/key_balance/model/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final bool isCredit = transaction.isCredit;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isCredit
              ? const [Color(0xFFF1F7FF), Color(0xFFFFFFFF)]
              : const [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: isCredit ? const Color(0xFF4CAF50) : const Color(0xFFC62828),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCredit ? Icons.arrow_downward : Icons.arrow_upward,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCredit ? "Received By:" : "Sent To:",
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.partyName,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    _badge(isCredit ? "Credit" : "Debit", isCredit),
                    const SizedBox(width: 8),
                    Text(
                      "${transaction.date}  •  ${transaction.time}",
                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Text(
                //   transaction.byText,
                //   style: const TextStyle(fontSize: 12, color: Colors.black54),
                // ),
              ],
            ),
          ),

          /// AMOUNT
          Text(
            transaction.amount,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isCredit ? const Color(0xFF1B5E20) : const Color(0xFFB71C1C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, bool isCredit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isCredit ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isCredit ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
        ),
      ),
    );
  }
}
