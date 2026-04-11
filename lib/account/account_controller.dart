import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zlock_smart_finance/app/routes/app_routes.dart';
import 'package:zlock_smart_finance/app/services/profile_api_services.dart';
import 'package:zlock_smart_finance/model/dashboard_response.dart';

class AccountController extends GetxController {
  var userName = ''.obs;
  var email = ''.obs;
  final userImage = ''.obs;

  final _profileService = ProfileService();
  final box = GetStorage(); // ✅ same instance

  Future<void> checkForUpdateManual(DashAppUpdate? update) async {
    // if (update == null) {
    //   Get.snackbar("Update", "No update data available");
    //   return;
    // }

    try {
      final packageInfo = await PackageInfo.fromPlatform();

      final currentBuild = int.tryParse(packageInfo.buildNumber) ?? 0;
      final serverBuild = int.tryParse(update?.versionCode ?? "0") ?? 0;

      if (serverBuild > currentBuild) {
        // ✅ UPDATE AVAILABLE
        final url = update?.downloadUrl ?? "";

        if (url.isEmpty) {
          Get.snackbar("Error", "Invalid update URL");
          return;
        }

        final success = await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );

        if (!success) {
          Get.snackbar("Error", "Unable to open update link");
        }
      } else {
        // ❌ NO UPDATE
        Get.snackbar("Up To Date", "Your app is already latest 🚀",snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar("Error", "Update check failed");
    }
  }
  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    final resp = await _profileService.getProfile();

    if (resp?.status != 200 || resp?.data?.user == null) return;

    final user = resp!.data!.user!;

    userName.value = user.displayName;
    email.value = user.email ?? '';
    userImage.value = user.image ?? '';
    // userImage.value = user.image ?? '';
    update();
  }

  void onProfileClicked() {
    // Navigate to profile page
    Get.toNamed("/manageAccount");
    // onTap: () => controller.onMenuTap("/manageAccount"),

  }

  void onMenuTap(String routeName) {
    Get.toNamed(routeName);
  }

  // ✅ FIXED: async logout (token/role remove + erase + flush)
  Future<void> logout() async {
    try {
      // ✅ remove critical keys first
      await box.remove("token");
      await box.remove("role");

      // ✅ clear all local storage
      await box.erase();

      // await box.obs(); // ✅ ensure changes saved

      // ✅ clear controller state
      userName.value = '';
      email.value = '';
      userImage.value = '';

      // ✅ go to role screen
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      Get.offAllNamed(AppRoutes.LOGIN);
    }
  }

  void showLogoutSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFFFE5E5),
                ),
                child: SvgPicture.asset("assets/accounts/logout.svg"),
              ),
              const SizedBox(height: 20),

              const Text(
                "Are you sure you want to logout?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "You will be signed out of your account. Make sure to save any changes before proceeding.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 25),
              const Divider(height: 1),
              const SizedBox(height: 25),

              Row(
                children: [
                  // Cancel
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.black26, width: 1.2),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // ✅ Logout (REAL)
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        // close sheet first (optional but clean)
                        Navigator.pop(context);

                        // ✅ clear token + navigate
                        await logout();

                        debugPrint("User logged out");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF4F4F),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
