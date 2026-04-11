import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zlock_smart_finance/app/utils/date_formate.dart';
import 'package:zlock_smart_finance/model/user_model.dart';
import 'package:zlock_smart_finance/modules/retailer/Add_new_key/show_custom_qr.dart';
import 'package:zlock_smart_finance/modules/retailer/dashboard/dashboard_retailer.dart';
import 'package:zlock_smart_finance/modules/retailer/details%20/details_controller.dart';
// import 'package:zlock_smart_finance/modules/retailer/active_user/active_user_controller.dart';
// import 'package:zlock_smart_finance/modules/retailer/active_user/widget/card.dart';
// import 'package:zlock_smart_finance/modules/retailer/total_user/user_controller.dart';
// // import '../controllers/users_controller.dart';
// // import '../widgets/user_card.dart';
// // import '../models/user_model.dart';
//
// class ActiveUsersPage extends StatelessWidget {
//   ActiveUsersPage({super.key});
//   final ctrl = Get.put(UsersController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffEEF1FF),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//         title: const Text(
//           'Active Users',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           _searchBar(),
//           _platformTabs(),
//           _statusTabs(),
//           Expanded(
//             child: Obx(() => ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: ctrl.filteredUsers.length,
//               itemBuilder: (_, i) =>
//                   UserCard(user: ctrl.filteredUsers[i]),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // 🔍 Search
//   Widget _searchBar() => Padding(
//     padding: const EdgeInsets.all(16),
//     child: TextField(
//       decoration: InputDecoration(
//         hintText: 'Search name, Key ID,mobile',
//         prefixIcon: const Icon(Icons.search),
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     ),
//   );
//
//   // 🤖 Android / 🍎 iPhone
//   Widget _platformTabs() => Obx(() => Row(
//     children: [
//       _platformTab('Android Key', 120, 0),
//       _platformTab('iPhone Key', 0, 1),
//     ],
//   ));
//
//   Widget _platformTab(String title, int count, int index) {
//     final isActive = ctrl.selectedPlatform.value == index;
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => ctrl.selectedPlatform.value = index,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           decoration: BoxDecoration(
//             gradient: isActive
//                 ? const LinearGradient(
//                 colors: [Color(0xffDFF3E8), Color(0xffB7E4CD)])
//                 : null,
//             border: const Border(
//               bottom: BorderSide(color: Color(0xff4F6BED), width: 2),
//             ),
//           ),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   index == 0 ? Icons.android : Icons.apple,
//                   color: isActive ? Colors.green : Colors.grey,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(title,
//                     style: const TextStyle(fontWeight: FontWeight.w600)),
//                 if (count > 0)
//                   Container(
//                     margin: const EdgeInsets.only(left: 6),
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text('$count',
//                         style:
//                         const TextStyle(color: Colors.white, fontSize: 12)),
//                   )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🟢 Status Tabs
//   Widget _statusTabs() => Obx(() => Padding(
//     padding: const EdgeInsets.all(12),
//     child: Row(
//       children: UserStatus.values.map((e) {
//         final isSelected = ctrl.selectedStatus.value == e;
//         return Expanded(
//           child: GestureDetector(
//             onTap: () => ctrl.selectedStatus.value = e,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? const Color(0xff4E8E6A)
//                     : Colors.transparent,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Center(
//                 child: Text(
//                   e.name.capitalizeFirst!,
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     ),
//   ));
// }


import 'package:zlock_smart_finance/modules/retailer/details%20/details_page.dart';
import 'package:zlock_smart_finance/modules/retailer/edit_key/edit_key.dart';
import 'package:zlock_smart_finance/modules/retailer/total_user/user_controller.dart';

// class ActiveUsersListingPage extends StatelessWidget {
//   ActiveUsersListingPage({super.key});
//
//   final c = Get.put(UsersController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xffF6F8FC),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//         title: const Text('Active Users', style: TextStyle(color: Colors.black)),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           _searchBar(),
//           _platformTabs(),
//           _statusTabs(),
//
//           Expanded(
//             child: Obx(() => ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: c.filteredUsers.length,
//               itemBuilder: (_, i) => _userCard(c.filteredUsers[i],context),
//             )),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _searchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(16),
//       child: TextField(
//         onChanged: (v) => c.search.value = v,
//         decoration: InputDecoration(
//           hintText: 'Search name, Key ID, mobile',
//           prefixIcon: const Icon(Icons.search),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🤖 Android / 🍎 iPhone
//   Widget _platformTabs() => Obx(() => Row(
//     children: [
//       _platformTab('Android Key', 120, 0),
//       _platformTab('iPhone Key', 0, 1),
//     ],
//   ));
//
//   Widget _platformTab(String title, int count, int index) {
//     final isActive = c.selectedPlatform.value == index;
//     final isAndroid = index == 0;
//
//     final Color activeColor =
//     isAndroid ? const Color(0xff2E7D32) : const Color(0xffB3261E);
//
//     final LinearGradient activeGradient = isAndroid
//         ? const LinearGradient(
//       colors: [Color(0xffE6F6EE), Color(0xffBFE8D4)],
//     )
//         : const LinearGradient(
//       colors: [Color(0xffFCE8E8), Color(0xffF5BABA)],
//     );
//
//     return Expanded(
//       child: GestureDetector(
//         onTap: () => c.selectedPlatform.value = index,
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           decoration: BoxDecoration(
//             gradient: isActive ? activeGradient : null,
//             border: Border(
//               bottom: BorderSide(
//                 color: isActive ? activeColor : Colors.transparent,
//                 width: 3,
//               ),
//             ),
//           ),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   isAndroid ? Icons.android : Icons.apple,
//                   color: isActive ? activeColor : Colors.grey,
//                 ),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color: isActive ? activeColor : Colors.grey,
//                   ),
//                 ),
//                 if (count > 0)
//                   Container(
//                     margin: const EdgeInsets.only(left: 6),
//                     padding:
//                     const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: activeColor,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       '$count',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🟢 Status Tabs
//   Widget _statusTabs() => Obx(() => Padding(
//     padding: const EdgeInsets.all(12),
//     child: Row(
//       children: UserStatus.values.map((e) {
//         final isSelected = c.selectedStatus.value == e;
//         return Expanded(
//           child: GestureDetector(
//             onTap: () => c.selectedStatus.value = e,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? const Color(0xff4E8E6A)
//                     : Colors.transparent,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: Center(
//                 child: Text(
//                   e.name.capitalizeFirst!,
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     ),
//   ));
//
//   Widget _userCard(UserModel u,BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(color: Colors.black12, blurRadius: 6),
//         ],
//       ),
//       child: Column(
//         children: [
//           _cardHeader(u),
//           const Divider(height: 1),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _avatar(),
//                 const SizedBox(width: 12),
//                 Expanded(child: _details(u)),
//                 const VerticalDashedDivider(height: 135),
//
//                 _tags(u),
//               ],
//             ),
//           ),
//           const Divider(height: 1),
//           _actions(u,context),
//         ],
//       ),
//     );
//   }
//
//   Widget _cardHeader(UserModel u) {
//     Color color;
//     String label;
//
//     switch (u.status) {
//       case UserStatus.active:
//         color = Colors.green;
//         label = 'Active';
//         break;
//       case UserStatus.locked:
//         color = Colors.red;
//         label = 'Locked';
//         break;
//       default:
//         color = Colors.red;
//         label = 'Remove';
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Key ID: ${u.keyId}', style: const TextStyle(fontWeight: FontWeight.w600)),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(
//               color: color.withOpacity(.1),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: color),
//             ),
//             child: Text(label, style: TextStyle(color: color)),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _avatar() {
//     return Image.asset(
//       "assets/images/dummy_user.png",
//       width: 56,
//       height: 56,
//       fit: BoxFit.cover,
//     );
//   }
//
//   Widget _details(UserModel u) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Name: ${u.name}'),
//         Text('Mobile: ${u.mobile}'),
//         Text('IMEI: ${u.imei}'),
//         Text('Loan by: ${u.loanBy}', style: const TextStyle(fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//           decoration: BoxDecoration(
//             color: const Color(0xffEEF2FF),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Text('EMI Status: ${u.emi}', style: const TextStyle(color: Colors.blue)),
//         )
//       ],
//     );
//   }
//
//   Widget _tags(UserModel u) {
//     return Column(
//       children: [
//         _chip(u.brand, Colors.blue),
//         _chip(u.loanBy, Colors.orange),
//         _chip(u.time, Colors.green),
//       ],
//     );
//   }
//
//   Widget _chip(String text, Color c) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 6),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//       decoration: BoxDecoration(
//         color: c.withOpacity(.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(text, style: TextStyle(color: c, fontSize: 12)),
//     );
//   }
//
//   Widget _actions(UserModel u,context) {
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 // Get.to(DetailsScreen());
//                 Get.to(
//                       () => DetailsScreen(),
//                   arguments: {
//                     "keyId": u.keyId,
//                     "deviceId": u.deviceId,
//                   },
//                   binding: BindingsBuilder(() {
//                     Get.create<DetailsController>(() => DetailsController());
//                   }),
//                 );
//
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4F6BED),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//               ),
//               child: const Text('View Details',style: TextStyle(color: Colors.white),),
//             ),
//           ),
//           if (u.status != UserStatus.locked) ...[
//             const SizedBox(width: 8),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.grey.shade300,
//                 foregroundColor: Colors.black,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
//               ),
//               child: const Text('Locked'),
//             ),
//           ],
//           const SizedBox(width: 8),
//           InkWell(
//               onTap: () {
//                 _showMoreMenu(context,u);
//               },
//               child: const Icon(Icons.more_vert)),
//         ],
//       ),
//     );
//   }
// }
// class VerticalDashedDivider extends StatelessWidget {
//   final double height;
//   final Color color;
//
//   const VerticalDashedDivider({
//     super.key,
//     this.height = 80,
//     this.color = const Color(0xFFD6DEEB),
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(
//           12,
//               (index) => Container(
//             width: 1.2,
//             height: 6,
//             color: color,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void _showMoreMenu(BuildContext context,UserModel u) async {
//   final RenderBox overlay =
//   Overlay.of(context).context.findRenderObject() as RenderBox;
//
//   await showMenu(
//     context: context,
//     color: Colors.white,
//     elevation: 8,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(12),
//     ),
//     position: RelativeRect.fromRect(
//       const Rect.fromLTWH(100, 100, 40, 40), // auto-adjusted
//       Offset.zero & overlay.size,
//     ),
//     items: [
//       PopupMenuItem(
//         value: 'qr',
//         child: Row(
//           children: const [
//             Icon(Icons.qr_code_2, size: 20, color: Colors.black),
//             SizedBox(width: 10),
//             Text(
//               'Show QR',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//       PopupMenuItem(
//         value: 'edit',
//         child: Row(
//           children: const [
//             Icon(Icons.edit, size: 20, color: Colors.black),
//             SizedBox(width: 10),
//             Text(
//               'Edit',
//               style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   ).then((value) {
//     if (value == 'qr') {
//       // _openQrDialog(context);
//       showCustomerQrDialog(deviceMongoId: u.deviceId, keyId: u.keyId);
//     } else if (value == 'edit') {
//       // Navigate to edit page
//       // Get.to(EditPage());
//     }
//   });
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:zlock_smart_finance/model/user_model.dart';
// import 'package:zlock_smart_finance/modules/retailer/details%20/details_controller.dart';
// import 'package:zlock_smart_finance/modules/retailer/details%20/details_page.dart';
// import 'package:zlock_smart_finance/modules/retailer/Add_new_key/show_custom_qr.dart';
// import 'users_controller.dart';

class ActiveUsersListingPage extends StatefulWidget {
  const ActiveUsersListingPage({super.key});

  @override
  State<ActiveUsersListingPage> createState() => _ActiveUsersListingPageState();
}

class _ActiveUsersListingPageState extends State<ActiveUsersListingPage> {
  final UsersController c = Get.put(UsersController());
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels >= _scrollCtrl.position.maxScrollExtent - 200) {
        c.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Active Users', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _searchBar(),
          _platformTabs(),
          _statusTabs(),

          Expanded(
            child: Obx(() {
              if (c.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (c.filteredUsers.isEmpty) {
                return const Center(
                  child: Text(
                    "No key found",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                );
              }

              return ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.all(16),
                itemCount: c.filteredUsers.length + (c.isLoadingMore.value ? 1 : 0),
                itemBuilder: (_, i) {
                  if (i == c.filteredUsers.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return _userCard(c.filteredUsers[i], context);
                },
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (v) => c.search.value = v,
        decoration: InputDecoration(
          hintText: 'Search name, Key ID, mobile',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 🤖 Android / 🍎 iPhone
  Widget _platformTabs() => Obx(() => Row(
    children: [
      _platformTab('Android Key', 0, 0),
      _platformTab('iPhone Key', 0, 1),
    ],
  ));

  Widget _platformTab(String title, int count, int index) {
    final isActive = c.selectedPlatform.value == index;
    final isAndroid = index == 0;

    final Color activeColor = isAndroid ? const Color(0xff2E7D32) : const Color(0xff1F1F1F);

    final LinearGradient activeGradient = isAndroid
        ? const LinearGradient(colors: [Color(0xffE6F6EE), Color(0xffBFE8D4)])
        : const LinearGradient(colors: [Color(0xffF1F1F1), Color(0xffD9D9D9)]);

    return Expanded(
      child: GestureDetector(
        onTap: () => c.selectedPlatform.value = index,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: isActive ? activeGradient : null,
            border: Border(
              bottom: BorderSide(
                color: isActive ? activeColor : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isAndroid ? Icons.android : Icons.apple,
                    color: isActive ? activeColor : Colors.grey),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: isActive ? activeColor : Colors.grey,
                  ),
                ),
                if (count > 0)
                  Container(
                    margin: const EdgeInsets.only(left: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$count',
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🟢 Status Tabs (filters API)
  Widget _statusTabs() => Obx(() => Padding(
    padding: const EdgeInsets.all(12),
    child: Row(
      children: UserStatus.values.map((e) {
        final isSelected = c.selectedStatus.value == e;
        return Expanded(
          child: GestureDetector(
            onTap: () => c.selectedStatus.value = e,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xff4E8E6A) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Center(
                child: Text(
                  e.name.capitalizeFirst!,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  ));

  // ---------- Card UI ----------
  Widget _userCard(UserModel u, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          _cardHeader(u),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _avatar(u),
                const SizedBox(width: 12),
                Expanded(child: _details(u)),
                const VerticalDashedDivider(height: 135),
                const SizedBox(width: 5),

                _tags(u),
              ],
            ),
          ),
          const Divider(height: 1),
          _actions(u, context),
        ],
      ),
    );
  }

  Widget _cardHeader(UserModel u) {
    Color color;
    String label;

    switch (u.status) {
      case UserStatus.active:
        color = Colors.green;
        label = 'Active';
        break;
      case UserStatus.locked:
        color = Colors.red;
        label = 'Lock';
        break;
      case UserStatus.removed:
        color = Colors.orange;
        label = 'Remove';
        break;
      case UserStatus.pending:
        color = Colors.grey;
        label = 'Pending';
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Key ID: ${u.keyId}', style: const TextStyle(fontWeight: FontWeight.w600)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: color),
            ),
            child: Text(label, style: TextStyle(color: color)),
          )
        ],
      ),
    );
  }

  // Widget _avatar() {
  //   return Image.asset(
  //     "assets/images/dummy_user.png",
  //     width: 56,
  //     height: 56,
  //     fit: BoxFit.cover,
  //   );
  // }
  Widget _avatar(UserModel u) {
    final String? imageUrl =
    u.productImage.isNotEmpty ? u.productImage.first : null;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 56,
        height: 56,
        color: const Color(0xffEEF1FF),
        child: imageUrl == null
            ? const Icon(Icons.image_not_supported, size: 26, color: Colors.grey)
            : Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
          const Icon(Icons.broken_image, size: 26, color: Colors.grey),
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(
              child: SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _details(UserModel u) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Name: ${u.name}'),
        Text('Mobile: ${u.mobile}'),
        Text('IMEI: ${u.imei}'),
        Text('Loan by: ${u.loanBy}', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xffEEF2FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text('EMI Status: ${u.emi}', style: const TextStyle(color: Colors.blue)),
        )
      ],
    );
  }

  // Widget _tags(UserModel u) {
  //   return Column(
  //     children: [
  //       _chip(u.brand, Colors.blue),
  //       _chip(u.loanBy, Colors.orange),
  //       _chip(u.time, Colors.green),
  //     ],
  //   );
  // }
  //
  // Widget _chip(String text, Color c) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 6),
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //     decoration: BoxDecoration(
  //       color: c.withOpacity(.1),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Text(text, style: TextStyle(color: c, fontSize: 12)),
  //   );
  // }

  Widget _tags(UserModel u) {
    final date = formatApiDate(u.createdDate);
    final time = formatApiTime(u.createdDate);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _chip(u.brand, Colors.blue),
        _chip(u.loanBy, Colors.orange),
        _chip(date, Colors.green),
        _chip(time, Colors.purple),
      ],
    );
  }

  // Widget _chip(String text, Color c) {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 6),
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  //     decoration: BoxDecoration(
  //       color: c.withOpacity(.1),
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     child: Text(text, style: TextStyle(color: c, fontSize: 12)),
  //   );
  // }
  Widget _chip(String text, Color color) {
    return Container(
      // constraints: const BoxConstraints(maxWidth: 120), // ✅ prevent overflow
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

      decoration: BoxDecoration(
        color: color.withOpacity(0.12), // ✅ balanced background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.4), // ✅ subtle border for clarity
          width: 0.8,
        ),
      ),
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis, // ✅ long text safe
        style: TextStyle(
          color: color,          // ✅ darker text = better contrast
          fontSize: 12,
          fontWeight: FontWeight.w600,    // ✅ clearer titles
          height: 1.2,
        ),
      ),
    );
  }

  Widget _actions(UserModel u, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                      () => DetailsScreen(),
                  arguments: {"keyId": u.keyId, "deviceId": u.deviceId},
                  binding: BindingsBuilder(() {
                    Get.create<DetailsController>(() => DetailsController());
                  }),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4F6BED),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('View Details', style: TextStyle(color: Colors.white)),
            ),
          ),
          // if (u.status != UserStatus.locked) ...[
          //   const SizedBox(width: 8),
          //   ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Colors.grey.shade300,
          //       foregroundColor: Colors.black,
          //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          //     ),
          //     child: const Text('Locked'),
          //   ),
          // ],
          const SizedBox(width: 8),
          // InkWell(
          //   onTap: () => _showMoreMenu(context, u),
          //   child: const Icon(Icons.more_vert),
          // ),
          Builder(
            builder: (ctx) {
              final key = GlobalKey();

              return InkResponse(
                key: key,
                radius: 22,
                onTap: () => _showMoreMenuFromKey(ctx, key, u),
                child: const Padding(
                  padding: EdgeInsets.all(6),
                  child: Icon(Icons.more_vert, size: 22),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}

class VerticalDashedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const VerticalDashedDivider({
    super.key,
    this.height = 80,
    this.color = const Color(0xFFD6DEEB),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          12,
              (index) => Container(width: 1.2, height: 6, color: color),
        ),
      ),
    );
  }
}

// void _showMoreMenu(BuildContext context, UserModel u) async {
//   final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
//
//   await showMenu(
//     context: context,
//     color: Colors.white,
//     elevation: 8,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//     position: RelativeRect.fromRect(
//       const Rect.fromLTWH(100, 100, 40, 40),
//       Offset.zero & overlay.size,
//     ),
//     items: const [
//       PopupMenuItem(
//         value: 'qr',
//         child: Row(
//           children: [
//             Icon(Icons.qr_code_2, size: 20, color: Colors.black),
//             SizedBox(width: 10),
//             Text('Show QR', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//           ],
//         ),
//       ),
//       PopupMenuItem(
//         value: 'edit',
//         child: Row(
//           children: [
//             Icon(Icons.edit, size: 20, color: Colors.black),
//             SizedBox(width: 10),
//             Text('Edit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//           ],
//         ),
//       ),
//     ],
//   ).then((value) {
//     if (value == 'qr') {
//       showCustomerQrDialog(deviceMongoId: u.deviceId, keyId: u.keyId);
//     } else if (value == 'edit') {
//       // TODO: navigate edit
//     }
//   });
// }
void _showMoreMenuFromKey(BuildContext context, GlobalKey key, UserModel u) async {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
  final RenderBox button = key.currentContext!.findRenderObject() as RenderBox;

  final Offset topLeft = button.localToGlobal(Offset.zero, ancestor: overlay);
  final Offset bottomRight =
  button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay);

  final RelativeRect position = RelativeRect.fromRect(
    Rect.fromPoints(topLeft, bottomRight),
    Offset.zero & overlay.size,
  );

  final value = await showMenu<String>(
    context: context,
    color: Colors.white,
    elevation: 10,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    position: position,
    items: [
      PopupMenuItem(
        value: 'qr',
        child: Row(
          children: const [
            Icon(Icons.qr_code_2, size: 20, color: Colors.black),
            SizedBox(width: 10),
            Text('Show QR', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'edit',
        child: Row(
          children: const [
            Icon(Icons.edit, size: 20, color: Colors.black),
            SizedBox(width: 10),
            Text('Edit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    ],
  );

  if (value == 'qr') {
    // showCustomerQrDialog(deviceMongoId: u.deviceId, keyId: u.keyId);
  } else if (value == 'edit') {
    // TODO: Navigate to edit
    final entry = _entryFromUser(u); // ✅ decide android/iphone/running
    Get.to(
          () => EditKeyScreen(
        title: entry == NewKeyEntry.iphone
            ? "Edit iPhone Key"
            : entry == NewKeyEntry.running
            ? "Edit Running Key"
            : "Edit Android Key",
        entry: entry,
        keyId: u.keyId,
        deviceId: u.deviceId,
      ),
      arguments: {
        "entry": entry,
        "keyId": u.keyId,
        "deviceId": u.deviceId,
      },
    );

  }
}
NewKeyEntry _entryFromUser(dynamic u) {
  final t = (u.deviceType ?? u.keyType ?? "").toString().toUpperCase();

  if (t.contains("IPHONE") || t.contains("IOS")) return NewKeyEntry.iphone;
  if (t.contains("RUNNING")) return NewKeyEntry.running;
  return NewKeyEntry.android;
}
