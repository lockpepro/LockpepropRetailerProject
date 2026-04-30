import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'contact_support_controller.dart';

class ContactSupportScreen extends StatelessWidget {
  ContactSupportScreen({super.key});

  final ContactSupportController c = Get.put(ContactSupportController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.bgTopGradient,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4FA),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, size: 18),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Contact Support",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Can’t find what you’re looking for? Reach out to\nour support team",
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 30),

                // EMAIL
                _supportTile(
                  icon: Icons.mail_outline,
                  title: "Email",
                  subtitle: c.supportEmail,
                  onTap: c.openEmail,
                ),

                const SizedBox(height: 20),

                // PHONE
                // _supportTile(
                //   icon: Icons.phone_outlined,
                //   title: "Phone",
                //   subtitle: "Call us at ${c.supportPhone}",
                //   onTap: c.openPhone,
                // ),
                // _supportTile(
                //   icon: Icons.phone_outlined,
                //   title: "Phone",
                //   subtitle: "Call us at ${c.supportPhone}",
                //   onTap: () => c.openPhone(c.supportPhone),
                // ),
                //
                // const SizedBox(height: 20),
                //
                // _supportTile(
                //   icon: Icons.phone_outlined,
                //   title: "Phone",
                //   subtitle: "Call us at ${c.supportPhone2}",
                //   onTap: () => c.openPhone(c.supportPhone2),
                // ),

                // const SizedBox(height: 20),

                // WHATSAPP
                // _supportTile(
                //   icon: Icons.message,
                //   title: "WhatsApp",
                //   subtitle: "Message on ${c.supportPhone}",
                //   onTap: c.openWhatsApp,
                // ),
                // _supportTile(
                //   icon: Icons.message,
                //   title: "WhatsApp",
                //   subtitle: "Message on ${c.supportPhone}",
                //   onTap: () => c.openWhatsApp(c.supportPhone),
                // ),
                //
                // const SizedBox(height: 20),
                //
                // _supportTile(
                //   icon: Icons.message,
                //   title: "WhatsApp",
                //   subtitle: "Message on ${c.supportPhone2}",
                //   onTap: () => c.openWhatsApp(c.supportPhone2),
                // ),
                // PHONE LIST
                ...c.supportPhones.map((phone) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _supportTile(
                    icon: Icons.phone_outlined,
                    title: "Phone",
                    subtitle: "Call us at $phone",
                    onTap: () => c.openPhone(phone),
                  ),
                )).toList(),

// WHATSAPP LIST
                ...c.supportPhones.map((phone) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _supportTile(
                    icon: Icons.message,
                    title: "WhatsApp",
                    subtitle: "Message on $phone",
                    onTap: () => c.openWhatsApp(phone),
                  ),
                )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F8FA),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 22, color: Colors.black),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
