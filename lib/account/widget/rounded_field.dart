import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RoundedField extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback? onTap;
  final double verticalPadding;
  final Widget? trailing;

  const RoundedField({
    super.key,
    required this.iconPath,
    required this.text,
    this.onTap,
    this.verticalPadding = 18,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final radius = 18.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.02),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 20,
              height: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
