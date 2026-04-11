
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/utils/common_bottom_button.dart';
import 'package:zlock_smart_finance/app/utils/date_formate.dart';
import 'package:zlock_smart_finance/modules/retailer/details%20/details_controller.dart';

// ================= MAIN SCREEN =================
class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  // final ctrl = Get.put(DetailsController());
  final DetailsController ctrl = Get.find<DetailsController>(); // ✅ HERE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        title: Text("Details"),
        centerTitle: true,
      ),

      body: Column(
        children: [
          _tabs(),
          const SizedBox(height: 12),
          Expanded(
            child: Obx(() {
              switch (ctrl.selectedTab.value) {
                case 1:
                  return _commandsTab();
                case 2:
                  return _emiTab(context);
                default:
                  return customerTab();
              }
            }),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        if (ctrl.selectedTab.value != 0) return const SizedBox.shrink();

        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          decoration: const BoxDecoration(
            color: Color(0xffF6F7FB),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _unlockButton(),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _lockButton(),
              ),
            ],
          ),
        );
      }),

    );
  }

  // ================= TABS =================
  Widget _tabs() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ['Customer Details', 'Commands', 'EMI']
          .asMap()
          .entries
          .map((e) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ChoiceChip(
          label: Text(e.value),
          selected: ctrl.selectedTab.value == e.key,
          selectedColor: const Color(0xff4F6BED),
          onSelected: (_) => ctrl.selectedTab.value = e.key,
          labelStyle: TextStyle(
            color: ctrl.selectedTab.value == e.key
                ? Colors.white
                : Colors.black,
          ),
        ),
      ))
          .toList(),
    ));
  }

  // Widget customerTab() {
  //   return SingleChildScrollView(
  //     padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         _profileSection(),
  //         const SizedBox(height: 16),
  //         _deviceStatus(),
  //         const SizedBox(height: 16),
  //         _numberSection(),
  //         const SizedBox(height: 16),
  //         _documentsSection(),
  //       ],
  //     ),
  //   );
  // }
  Widget customerTab() {
    return Obx(() {
      if (ctrl.isDetailsLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // if API fail
      if (ctrl.details.value == null) {
        return Center(
          child: TextButton(
            onPressed: ctrl.fetchKeyDetails,
            child: const Text("Retry"),
          ),
        );
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _profileSection(),
            const SizedBox(height: 16),
            _deviceStatus(),
            const SizedBox(height: 16),
            _numberSection(),
            const SizedBox(height: 16),
            _documentsSection(), // abhi same rakh rahe (next step me dynamic)
          ],
        ),
      );
    });
  }

  // Widget _profileSection() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: _cardDecoration(),
  //     child: Column(
  //       children: [
  //         Align(
  //           alignment: Alignment.topRight,
  //           child: Text(
  //             "Edit Details",
  //             style: TextStyle(color: Color(0xff4F6BED)),
  //           ),
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Align(
  //               alignment: Alignment.center,
  //                 child: const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/images/user.png'))),
  //
  //           ],
  //         ),
  //         const SizedBox(height: 16),
  //         _inputField(
  //           icon: Icons.person_outline,
  //           text: "Jonathan Frixy Alexander",
  //         ),
  //         const SizedBox(height: 12),
  //
  //         _inputField(
  //           svgPath: "assets/accounts/phone.svg",
  //           text: "+1  9982 8863 0022",
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // Widget _profileAvatar() {
  //   final imageUrl = ctrl.productImage;
  //
  //   return CircleAvatar(
  //     radius: 50,
  //     backgroundColor: const Color(0xffEEF1FF),
  //     backgroundImage:
  //     (imageUrl != null && imageUrl.isNotEmpty)
  //         ? NetworkImage(imageUrl)
  //         : null,
  //     child: (imageUrl == null || imageUrl.isEmpty)
  //         ? const Icon(
  //       Icons.person,
  //       size: 36,
  //       color: Colors.grey,
  //     )
  //         : null,
  //     onBackgroundImageError: (_, __) {
  //       // broken image case → fallback icon
  //     },
  //   );
  // }
  Widget _profileAvatar() {
    final String imageUrl = (ctrl.productImage ?? '').trim();
    final hasImage = imageUrl.isNotEmpty;

    return CircleAvatar(
      radius: 50,
      backgroundColor: const Color(0xffEEF1FF),
      backgroundImage: hasImage ? NetworkImage(imageUrl) : null,
      onBackgroundImageError: hasImage
          ? (_, __) {
        // agar aap fallback flag set karna chahte ho:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // ctrl.productImage = '';  // (only if productImage is RxString)
          // ya ctrl.avatarBroken.value = true;
        });
      }
          : null,
      child: hasImage
          ? null
          : const Icon(Icons.person, size: 36, color: Colors.grey),
    );
  }

  Widget _profileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Text(
          //     "Edit Details",
          //     style: TextStyle(color: Color(0xff4F6BED)),
          //   ),
          // ),
          _profileAvatar(),
          const SizedBox(height: 16),

          _inputField(
            icon: Icons.person_outline,
            text: ctrl.customerName, // ✅
          ),
          const SizedBox(height: 12),

          _inputField(
            svgPath: "assets/accounts/call.svg",
            text: ctrl.customerPhone, // ✅
          ),
        ],
      ),
    );
  }

  Widget _deviceStatus() {
    final isActive = ctrl.isActiveDevice;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Device Status",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.green.shade50 : Colors.red.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isActive ? Colors.green : Colors.red),
            ),
            child: Text(
              isActive ? "● Phone is Active" : "● Phone is Inactive",
              style: TextStyle(
                color: isActive ? Colors.green : Colors.red,
                fontSize: 12,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _numberSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Number",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),

          _numberTile(Icons.sim_card, "SIM 1", ctrl.customerPhone),
          // _divider(),
          // _numberTile(Icons.sim_card, "SIM 2", "-"),
          _divider(),
          _numberTile(Icons.qr_code, "IMEI 1", ctrl.imei1), // ✅
          _divider(),
          _numberTile(Icons.qr_code, "Brand/Model", ctrl.brandModel), // ✅ (same section me)
        ],
      ),
    );
  }

  Widget _inputField({
    IconData? icon,
    String? svgPath,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, color: Colors.grey, size: 20),

          if (svgPath != null)
            SvgPicture.asset(
              svgPath,
              width: 20,
              height: 20,
            ),

          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _numberTile(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xffEEF2FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xff4F6BED)),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12)),
            Text(value,
                style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        )
      ],
    );
  }

  Widget _divider() =>
      Padding(padding: const EdgeInsets.symmetric(vertical: 12), child: Divider());

  BoxDecoration _cardDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      )
    ],
  );

  Widget _commandsTab() {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: ctrl.commands.length,
      itemBuilder: (_, index) {
        final entry = ctrl.commands.entries.elementAt(index);

        final title = entry.key;
        // final isNoToggle = title == 'Location' || title == 'Mobile No';
        final isNoToggle = ctrl.noToggleCommands.contains(title);

        return Obx(() {
          final loading = ctrl.isCommandLoading(entry.key);

          return _commandCard(
            title: entry.key,
            iconPath: ctrl.iconFor(entry.key),
            value: entry.value.value,
            // onChanged: loading ? null : (v) => ctrl.onCommandToggle(entry.key, v),
            isLoading: loading,

            // ✅ switch only when not special commands
            showSwitch: !isNoToggle,
            onChanged: (loading || isNoToggle) ? null : (v) => ctrl.onCommandToggle(title, v),

            // ✅ tap action for Location / Mobile No
            onTap: isNoToggle
                ? () => onSpecialCommandTap(title)
                : null,
          );
        });
      },
    );
  }

  Widget _commandCard({
    required String title,
    required String iconPath,
    required bool value,
    required ValueChanged<bool>? onChanged,
    required bool isLoading,
    required bool showSwitch,
    VoidCallback? onTap,
  }) {
    final card = Container(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xff4F6BED), width: 1.4),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                iconPath,
                width: 22,
                height: 22,
                colorFilter: const ColorFilter.mode(Color(0xff2E3A8C), BlendMode.srcIn),
                placeholderBuilder: (_) => const SizedBox(
                  width: 22,
                  height: 22,
                  child: Icon(Icons.image_not_supported, size: 18),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1E2A5A),
                  ),
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: isLoading
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : (showSwitch
                ? FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomRight,
              child: Switch(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: value,
                onChanged: onChanged,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xff4F6BED),
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey.shade300,
              ),
            )
                : const SizedBox.shrink() // ✅ no toggle
            ),
          ),
        ],
      ),
    );

    // ✅ tap only for special commands
    if (onTap == null) return card;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: card,
    );
  }

  Future<void> onSpecialCommandTap(String title) async {
    if (title == 'Location') {
      showLocationPopup();
      return;
    }

    if (title == 'Mobile No') {
      showMobileNumberPopup(
        registeredNumber: "8595800196", // TODO: API/Stored value
        currentNumber: "",              // TODO: API/Stored value
      );
      return;
    }

    if (title == 'Remove Key') {
      // ctrl.confirmAndRemoveKey(); // ✅ NEW
      // await ctrl.sendRemoveKeyCommand();
      return;
    }
  }

  void showMobileNumberPopup({
    required String registeredNumber,
    required String currentNumber,
  }) {
    Get.dialog(
      Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _infoRowForSim("Registered\nNumber", registeredNumber),
              const SizedBox(height: 12),
              _infoRowForSim("Current\nNumber", currentNumber.isEmpty ? "-" : currentNumber),
              const SizedBox(height: 14),
              InkWell(
                  onTap: () => Get.back(),
                child: Container(

                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Color(0xFF3153D8),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Dismiss",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _infoRowForSim(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xff2E3A8C), width: 1.2),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$label  :",
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xff6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void showLocationPopup() {
    Get.dialog(
      AlertDialog(
        title: const Text("Location"),
        content: const Text("Fetching location..."), // ✅ yahan API result show karo
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Dismiss")),
        ],
      ),
    );
  }

// ================= EMI TAB =================
  Widget _emiTab(BuildContext context) {
    if (ctrl.isDetailsLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    // if API fail
    if (ctrl.details.value == null) {
      return Center(
        child: TextButton(
          onPressed: ctrl.fetchKeyDetails,
          child: const Text("Retry"),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _importantInfoCard(),
          const SizedBox(height: 16),
          _loanProgress(),
          const SizedBox(height: 16),
          _emiSettings(),
          const SizedBox(height: 16),
          _emiTable(context),
        ],
      ),
    );
  }

  Widget _importantInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Important Info.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text(
              //     "Edit Details",
              //     style: TextStyle(color: Color(0xff4F6BED)),
              //   ),
              // )
            ],
          ),
          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _infoColumnLeft(),
              const SizedBox(width: 12),
              Container(width: 1, height: 150, color: Colors.grey.shade300), // VERTICAL DIVIDER
              const SizedBox(width: 12),
              _infoColumnRight(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoColumnLeft() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow("Loan ID", ctrl.loanId),
          _infoRow("Product Price", fmtMoney(ctrl.productPrice)),
          _infoRow("Down Payment Date", fmtDate(ctrl.downPaymentDate)),
          _infoRow("Down Payment", fmtMoney(ctrl.downPayment)),
          _infoRow("Loan Amount", fmtMoney(ctrl.loanAmount)),
          // _infoRow("Loan By", ctrl.loanBy),
        ],
      ),
    );
  }

  Widget _infoColumnRight() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _infoRow("Tenure", fmtTenureMonths(ctrl.tenure)),
          _infoRow("Processing Fee", fmtMoney(ctrl.processingFee)),
          _infoRow("EMI Amount", fmtMoney(ctrl.emiAmount)),
          _infoRow("First EMI Date", fmtDate(ctrl.firstEmiDate)),
          _infoRow("Loan By", ctrl.loanBy),

          // _infoRow("Guarantor Name", ctrl.guarantorName),
          // _infoRow("Guarantor Number", ctrl.details.value?.device?.mobileNumber ?? "-"),
        ],
      ),
    );
  }


  String fmtPercent(double p) {
    final val = (p <= 1) ? (p * 100) : p;
    return "${val.round()}%";
  }

  Widget _loanProgress() {
    return Obx(() {
      final percentage = ctrl.progressPercentage;
      final progressValue = ctrl.progress;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Loan Progress",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text("${fmtPercent(percentage)} Paid"),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xff4F6BED),
              minHeight: 6,
            ),
            const SizedBox(height: 8),
            Text(
              "Paid EMI: ${ctrl.paidEmi}/${ctrl.totalEmi}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _emiSettings() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _switchTile(
            "Auto Lock",
            "Pay EMI in 3 days to avoid phone lock.",
            ctrl.autoLock,
          ),
          const Divider(),
          _switchTile(
            "Add Overdue Amount",
            "Late charges will be added to your EMI.",
            ctrl.addOverdueAmount,
          ),
        ],
      ),
    );
  }

  Widget _switchTile(String title, String subtitle, RxBool rxValue) {
    return Obx(() => Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
        Switch(
          value: rxValue.value,
          onChanged: (v) => rxValue.value = v, // ✅ working
          activeColor: Colors.white,
          activeTrackColor: const Color(0xff4F6BED),
        )
      ],
    ));
  }

  Widget _emiTable(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(() => Column(
        children: [
          _tableHeader(),
          const Divider(),
          ...List.generate(ctrl.emis.length, (i) {
            final e = ctrl.emis[i];
            final color = e.status == EmiStatus.paid ? Colors.green : Colors.red;

            return _emiRow(
              context,
              i,
              e.date,
              e.amount,
              e.status.label,
              color,
            );
          }),
        ],
      )),
    );
  }

  Widget _tableHeader() {
    return Row(
      children: const [
        Expanded(child: Text("Date", style: TextStyle(fontWeight: FontWeight.w600))),
        Expanded(child: Text("Amount", style: TextStyle(fontWeight: FontWeight.w600))),
        Expanded(child: Text("Status", style: TextStyle(fontWeight: FontWeight.w600))),
        Expanded(child: Text("Action", style: TextStyle(fontWeight: FontWeight.w600))),
      ],
    );
  }

  Widget _emiRow(
      BuildContext context,
      int index,
      String date,
      String amount,
      String status,
      Color color,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: Text(date)),
          Expanded(child: Text(amount)),
          Expanded(child: Text(status, style: TextStyle(color: color))),
          Expanded(
            child: ElevatedButton(
              onPressed: () => ctrl.openChangeStatusSheet(context, index),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4F6BED),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text(
                "Action",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _documentsSection() {
    // final ctrl = Get.find<DetailsController>();
    if (ctrl.isDetailsLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Documents",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Obx(() {
          //       final url = ctrl.agreementUrl;
          //       final loading = ctrl.isDocLoading("agreement");
          //
          //       return _DocumentItem(
          //         icon: "assets/icons/agreement.svg",
          //         title: "Agreement\n  ",
          //         isLoading: loading,
          //         onView: () => ctrl.viewDoc(url),
          //         onDownload: () => ctrl.downloadAndOpenDoc(
          //           url: url,
          //           fileName: "Purchase_Agreement", // name you want
          //           loadingKey: "agreement",
          //         ),
          //       );
          //     }),
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                final url = ctrl.agreementUrl;
                final loading = ctrl.isDocLoading("agreement");

                return _DocumentItem(
                  icon: "assets/icons/agreement.svg",
                  title: "Agreement\n  ",
                  isLoading: loading,
                  onView: () => ctrl.viewDoc(url),            // 👁 VIEW
                  onDownload: () => ctrl.downloadAndOpenDoc(  // ⬇ DOWNLOAD
                    url: url,
                    fileName: "Purchase_Agreement",
                    loadingKey: "agreement",
                  ),
                );
              }),
            ],
          ),


          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _unlockButton() {
    return Obx(() => OutlinedButton.icon(
      onPressed: ctrl.isUnlocking.value ? null : ctrl.unlockNow,
      icon: ctrl.isUnlocking.value
          ? const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(strokeWidth: 2),
      )
          : const Icon(Icons.lock_open, color: Color(0xff2E7D32), size: 20),
      label: Text(
        ctrl.isUnlocking.value ? "Unlocking..." : "Unlock Phone",
        style: const TextStyle(
          color: Color(0xff2E7D32),
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: const Color(0xffF3FBF6),
        side: const BorderSide(color: Color(0xff2E7D32), width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ));
  }

  Widget _lockButton() {
    return Obx(() => ElevatedButton.icon(
      onPressed: ctrl.isLocking.value ? null : ctrl.lockNow,
      icon: ctrl.isLocking.value
          ? const SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2,
        ),
      )
          : const Icon(Icons.lock, color: Colors.white, size: 20),
      label: Text(
        ctrl.isLocking.value ? "Locking..." : "Lock Phone",
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffD95763),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
    ));
  }
}

class _infoRow extends StatelessWidget {
  final String label, value;
  const _infoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}


class _DocumentItem extends StatelessWidget {
  final String icon;
  final String title;

  // ✅ NEW (optional)
  final VoidCallback? onView;
  final VoidCallback? onDownload;
  final bool isLoading;

  const _DocumentItem({
    required this.icon,
    required this.title,
    this.onView,
    this.onDownload,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onView,                 // ✅ tap = view
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xffF3F6FF),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  icon,
                  width: 26,
                  height: 26,
                  color: const Color(0xff4F6BED),
                ),

                // ✅ loader overlay (only when downloading)
                if (isLoading)
                  const Positioned.fill(
                    child: Center(
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xff4F6BED),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xff4F6BED),
                fontWeight: FontWeight.w500,
              ),
            ),

            // ✅ optional Download text (UI same when not used)
            if (onDownload != null) ...[
              const SizedBox(height: 6),
              GestureDetector(
                onTap: isLoading ? null : onDownload,
                child: const Text(
                  "Download",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff4F6BED),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
