import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_iphone_key_controller.dart';

class AddIphoneKeyScreen extends StatelessWidget {
  AddIphoneKeyScreen({super.key});

  final c = Get.put(AddIphoneKeyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffEAF0FF), Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _header(),
              _search(),
              const SizedBox(height: 8),
              Expanded(child: _list()),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        _circleIcon(Icons.arrow_back, () => Get.back()),
        const SizedBox(width: 12),
        const Text(
          "List",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: _openAddDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff253A8F),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          ),
          icon: const Icon(Icons.add, size: 18,color: Colors.white,),
          label: const Text("Add New Loan Zone",style: TextStyle(color: Colors.white),),
        )
      ],
    ),
  );

  // ================= SEARCH =================
  Widget _search() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: TextField(
      controller: c.searchCtrl,
      onChanged: c.onSearch,
      decoration: InputDecoration(
        hintText: "Search name, Key ID,mobile",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );

  // ================= LIST =================
  Widget _list() => Obx(
        () => ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: c.filteredList.length,
      itemBuilder: (_, i) {
        final item = c.filteredList[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 10,
                  offset: Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Key ID: ${item.keyId}",
                  style: const TextStyle(fontWeight: FontWeight.w500)),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _info("Name:", item.name),
                  _info("Mobile No.:", item.mobile, alignEnd: true),
                ],
              )
            ],
          ),
        );
      },
    ),
  );

  // ================= ADD DIALOG =================
  void _openAddDialog() {
    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: Get.width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Loan Zone",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    GestureDetector(
                        onTap: Get.back, child: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(height: 10),

                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 20),
                _input("Customer Name", c.customerCtrl),
                const SizedBox(height: 14),
                _input("Mobile Number", c.mobileCtrl,
                    keyboard: TextInputType.phone),
                const SizedBox(height: 44),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: c.addLoanZone,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4F6BED),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text("Submit",
                        style: TextStyle(fontSize: 16,color: Colors.white)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= SMALL WIDGETS =================
  Widget _circleIcon(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xffF2F4FA),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 18),
    ),
  );

  Widget _info(String label, String value, {bool alignEnd = false}) => Column(
    crossAxisAlignment:
    alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Text(label,
          style:
          const TextStyle(fontSize: 12, color: Color(0xff7A7A7A))),
      const SizedBox(height: 4),
      Text(value,
          style:
          const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
    ],
  );

  Widget _input(String hint, TextEditingController ctrl,
      {TextInputType keyboard = TextInputType.text}) =>
      TextField(
        controller: ctrl,
        keyboardType: keyboard,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: Color(0xffE0E5F2)),
          ),
        ),
      );
}
