import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';
import 'package:zlock_smart_finance/app/constants/app_colors.dart';
import 'package:zlock_smart_finance/app/utils/common_bottom_button.dart';
import 'package:zlock_smart_finance/modules/retailer/Add_new_key/new_key_controller.dart';
import 'package:zlock_smart_finance/modules/retailer/dashboard/dashboard_retailer.dart';
import 'edit_key_controller.dart';

class EditKeyScreen extends StatelessWidget {
  final String title;
  final NewKeyEntry entry;
  final String keyId;
  final String deviceId;

  EditKeyScreen({
    super.key,
    required this.title,
    required this.entry,
    required this.keyId,
    required this.deviceId,
  });

  String get _tag => "edit_${entry.name}_$keyId";
  EditKeyController get c => Get.find<EditKeyController>(tag: _tag);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<EditKeyController>(tag: _tag)) {
      Get.put(
        EditKeyController(entry: entry, keyId: keyId, deviceId: deviceId),
        tag: _tag,
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        final ok = await c.confirmExitAndClear();
        if (ok) {
          Get.delete<EditKeyController>(tag: _tag, force: true);
          Get.back();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Obx(() {
          if (c.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            controller: _scrollController,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(
              16,
              50,
              16,
              MediaQuery.of(context).viewInsets.bottom + 350,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context),
                const SizedBox(height: 16),

                _basicDetails(context),
                const SizedBox(height: 16),

                _buildSignatureBlock(),
                const SizedBox(height: 16),

                // ✅ always visible + clickable
                _collapseHeader(),

                Obx(() => c.showMore.value ? _expandedSection(context) : const SizedBox()),
              ],
            ),
          );
        }),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Obx(() {
          final loading = c.isUpdating.value;
          return CommonBottomButtonUpdate(
            title: loading ? "Updating..." : "Update",
            showAgreement: false,
            onTap: () => c.updateCustomer(),
          );
        }),
      ),
    );
  }

  Widget _scrollOnFocus({required Widget child}) {
    return Builder(
      builder: (context) {
        return Focus(
          onFocusChange: (hasFocus) {
            if (hasFocus) {
              Future.delayed(const Duration(milliseconds: 300), () {
                Scrollable.ensureVisible(
                  context,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: 0.2,
                );
              });
            }
          },
          child: child,
        );
      },
    );
  }

  Widget _header(BuildContext context) => Row(
    children: [
      _circleBtn(Icons.arrow_back, () async {
        final ok = await c.confirmExitAndClear();
        if (ok && context.mounted) {
          Get.delete<EditKeyController>(tag: _tag, force: true);
          Navigator.of(context).pop();
        }
      }),
      const Spacer(),
      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      const Spacer(flex: 2),
    ],
  );

  Widget _basicDetails(BuildContext context) => _card(
    Column(
      children: [
        Obx(() {
          final localPath = c.customerProductImagePath.value;
          final hasLocal = localPath.isNotEmpty;
          final url = c.existingProductImageUrl.value;

          return InkWell(
            onTap: () => c.showImagePickOptions(context),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: hasLocal
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  File(localPath),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              )
                  : (url.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  url,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              )
                  : const CircleAvatar(
                backgroundColor: Color(0xffEFF2FF),
                child: Icon(Icons.camera_alt_outlined, color: Color(0xff4F6BED)),
              )),
              title: const Text("Customer + Product Image", style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(
                hasLocal ? "New image selected" : (url.isNotEmpty ? "Existing image" : "Upload photos"),
                style: const TextStyle(color: Color(0xff4F6BED)),
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        }),

        _scrollOnFocus(child: _inputName("Customer Name", c.customerName)),
        _scrollOnFocus(child: _input("Mobile Number", c.mobile)),


        _scrollOnFocus(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextField(
              controller: c.imei,
              readOnly: true, // ❌ NOT EDITABLE
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "IMEI 1",
                filled: true,
                fillColor: Colors.grey.shade100,

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: TextField(
            controller: c.imei2,
            readOnly: true, // ❌ NOT EDITABLE
            decoration: InputDecoration(
              hintText: "IMEI 2",
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),


            ),
          ),
        ),


        _loanProviderDropdown(),
        // _scrollOnFocus(child: _inputName("Brand/Model", c.brandModel)),

        // ✅ show existing signature url info (optional)
        Obx(() {
          final sig = c.existingSignatureUrl.value;
          if (sig.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: const [
                Icon(Icons.verified, size: 16, color: Colors.green),
                SizedBox(width: 6),
                Text("Existing signature available", style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // Widget _buildSignatureBlock() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Row(
  //         children: [
  //           const Expanded(
  //             child: Text(
  //               "Customer Signature (optional)",
  //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //             ),
  //           ),
  //           GestureDetector(
  //             onTap: () => c.resetSignature(),
  //             child: const Text("Reset", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 10),
  //       Container(
  //         height: 150,
  //         padding: const EdgeInsets.all(12),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(14),
  //           border: Border.all(color: Colors.grey.shade200),
  //         ),
  //         child: Signature(controller: c.signatureController, backgroundColor: Colors.white),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSignatureBlock() {
    return Obx(() {
      final isEditing = c.isSignatureEditing.value;
      final existingUrl = c.existingSignatureUrl.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Customer Signature",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              /// 🔥 EDIT BUTTON
              if (!isEditing)
                GestureDetector(
                  onTap: () {
                    c.startEditingSignature();
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

              /// 🔥 RESET BUTTON (only when editing)
              if (isEditing)
                GestureDetector(
                  onTap: () => c.resetSignature(),
                  child: const Text(
                    "Reset",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 10),

          /// ✅ SHOW EXISTING SIGNATURE
          if (!isEditing && existingUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                existingUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            )

          /// ✅ SHOW EMPTY MESSAGE
          else if (!isEditing && existingUrl.isEmpty)
            Container(
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text("No signature available"),
            )

          /// ✅ SHOW SIGNATURE PAD
          else
            Container(
              height: 150,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Signature(
                controller: c.signatureController,
                backgroundColor: Colors.white,
              ),
            ),
        ],
      );
    });
  }
  Widget _collapseHeader() => GestureDetector(
    onTap: () => c.showMore.toggle(),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xffCBD3EE)),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Click to edit more details",
                    style: TextStyle(color: Color(0xff243A8F), fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text("EMI, ECS & E-Mandate....", style: TextStyle(color: Color(0xff4F6BED))),
              ],
            ),
          ),
          Obx(() => Icon(c.showMore.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down))
        ],
      ),
    ),
  );

  Widget _expandedSection(BuildContext context) => Obx(() {
    final hideAll = c.paymentType.value == PaymentType.withoutEmi;

    return Column(
      children: [
        const SizedBox(height: 16),
        paymentTypeCard(),
        if (!hideAll) ...[
          const SizedBox(height: 16),
          _emiSection(),
          const SizedBox(height: 16),
          _loanDate(context),
        ],
      ],
    );
  });

  Widget paymentTypeCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.kCardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Payment Type (optional)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),

        Row(
          children: [
            _radioItem("EMI", PaymentType.emi),
            const SizedBox(width: 16),
            _radioItem("Without EMI", PaymentType.withoutEmi),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _radioItem("ECS", PaymentType.ecs),
            const SizedBox(width: 16),
            _radioItem("E-Mandate", PaymentType.eMandate),
          ],
        ),
        const SizedBox(height: 16),

        Obx(() {
          final hideAll = c.paymentType.value == PaymentType.withoutEmi;
          if (hideAll) return const SizedBox.shrink();

          return Row(
            children: [
              Expanded(child: _scrollOnFocus(child: _amountField("Product Price", c.productPrice))),
              const SizedBox(width: 10),
              Expanded(child: _scrollOnFocus(child: _amountField("Down Payment", c.downPayment))),
              const SizedBox(width: 10),
              Expanded(child: _scrollOnFocus(child: _amountField("Balance Payment", c.balancePayment))),
            ],
          );
        }),
      ]),
    );
  }

  Widget _radioItem(String text, PaymentType type) {
    return GestureDetector(
      onTap: () => c.paymentType.value = type,
      child: Obx(() {
        final selected = c.paymentType.value == type;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.kPrimaryBlue : AppColors.kBorder,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.kPrimaryBlue),
                ),
              )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(text, style: const TextStyle(fontSize: 14, color: AppColors.kPrimaryBlue, fontWeight: FontWeight.w500)),
          ],
        );
      }),
    );
  }

  Widget _amountField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 10, color: AppColors.kHint),
        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.kBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.kPrimaryBlue),
        ),
      ),
    );
  }

  Widget _emiSection() => _card(
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("EMI Details", style: TextStyle(fontWeight: FontWeight.w600)),
      const SizedBox(height: 12),

      _emiTabs(),
      const SizedBox(height: 12),

      Row(
        children: [
          Expanded(child: _scrollOnFocus(child: _miniInput("Tenure (Months)", c.months))),
          const SizedBox(width: 8),
          Expanded(child: _scrollOnFocus(child: _miniInput("Interest Rate (%)", c.interest))),
        ],
      ),

      const SizedBox(height: 12),
      _input("Monthly EMI Amount", c.monthlyEmi),
    ]),
  );

  Widget _emiTabs() => Obx(() => Row(
    children: EmiCycle.values.map((e) {
      final active = c.emiCycle.value == e;
      final label = e == EmiCycle.monthly
          ? "Monthly"
          : e == EmiCycle.weekly
          ? "Weekly"
          : "Daily";

      return Expanded(
        child: GestureDetector(
          onTap: () => c.emiCycle.value = e,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: active ? const Color(0xff4F6BED) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffCBD3EE)),
            ),
            child: Center(
              child: Text(label, style: TextStyle(color: active ? Colors.white : Colors.black)),
            ),
          ),
        ),
      );
    }).toList(),
  ));

  Widget _loanDate(BuildContext context) => _card(
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("Loan Start Date", style: TextStyle(fontWeight: FontWeight.w600)),
      const SizedBox(height: 12),
      Obx(() => TextField(
        readOnly: true,
        onTap: () => c.pickDate(context),
        decoration: InputDecoration(
          hintText: c.loanStartDate.value.isEmpty ? "DD/MM/YYYY" : c.loanStartDate.value,
          suffixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ))
    ]),
  );

  Widget _miniInput(String hint, TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _inputName(String hint, TextEditingController ctrl) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: ctrl,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );

  Widget _input(String hint, TextEditingController ctrl) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );

  Widget _loanProviderDropdown() => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Obx(() {
      return DropdownButtonFormField<String>(
        value: c.selectedLoanProvider.value,
        items: c.loanProviders
            .map((e) => DropdownMenuItem<String>(
          value: e,
          child: Text(e, overflow: TextOverflow.ellipsis),
        ))
            .toList(),
        onChanged: c.setLoanProvider,
        isExpanded: true,
        decoration: InputDecoration(
          hintText: "Loan Provider",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        ),
      );
    }),
  );

  Widget _card(Widget child) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [BoxShadow(color: Color(0x11000000), blurRadius: 10, offset: Offset(0, 4))],
    ),
    child: child,
  );

  Widget _circleBtn(IconData i, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Color(0xffF2F4FA), shape: BoxShape.circle),
      child: Icon(i, size: 18),
    ),
  );
}
