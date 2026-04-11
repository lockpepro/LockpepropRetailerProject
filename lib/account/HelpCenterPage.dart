import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/account/HelpCenterController.dart';

class HelpCenterPage extends StatelessWidget {
  final HelpCenterController c = Get.put(HelpCenterController());

  HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),

                    // Title
                    const Text(
                      "Welcome to Our Help Center",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Your go-to resource for answers, guidance, and support.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff8A8A8A),
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // FAQ
                    _helpItem(
                      icon: "assets/accounts/info.svg",
                      title: "FAQs",
                      subtitle:
                      "Find quick answers to the most common questions.",
                      onTap: c.onFAQs,
                    ),

                    // Account Support
                    _helpItem(
                      icon: "assets/accounts/user_octagon.svg",
                      title: "Account Support",
                      subtitle:
                      "Help with login issues, password recovery, and account settings.",
                      onTap: c.onAccountSupport,
                    ),

                    // Contact Support
                    _helpItem(
                      icon: "assets/accounts/call.svg",
                      title: "Contact Support",
                      subtitle:
                      "Can’t find what you’re looking for? Reach out to our support team",
                      onTap: () => c.onContactSupport(context),

                    ),

                    const SizedBox(height: 20),

                    // Email Container
                    _contactItem(
                      icon: "assets/accounts/email.svg",
                      title: "Email",
                      subtitle: c.supportEmail,
                      onTap: c.onEmailTap,
                    ),

                    const SizedBox(height: 12),

                    // Phone Container
                    _contactItem(
                      icon: "assets/accounts/call.svg",
                      title: "Phone",
                      subtitle: "Call us at ${c.supportPhone}",
                      onTap: () => c.onPhoneTap(c.supportPhone),

                    ),
                    const SizedBox(height: 12),

                    _contactItem(
                      icon: "assets/accounts/call.svg",
                      title: "Phone",
                      subtitle: "Call us at ${c.supportPhone2}",
                      onTap: () => c.onPhoneTap(c.supportPhone2),

                    ),


                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Header ----------------
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffEAF0FF), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xffEEF3FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back, size: 18),
            ),
          ),
          const SizedBox(width: 15),
          const Text(
            "Help Center",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }

  // ---------------- Help Option Tile ----------------
  Widget _helpItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          // color: const Color(0xffF5F7FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xffEEF3FF),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff8A8A8A),
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18)
          ],
        ),
      ),
    );
  }

  // ---------------- Contact Item (Email + Phone) ----------------
  Widget _contactItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffF5F7FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xffEEF3FF),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff8A8A8A),
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
}
