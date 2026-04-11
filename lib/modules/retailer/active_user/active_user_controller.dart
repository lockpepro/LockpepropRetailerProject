// import 'package:get/get.dart';
// import 'package:zlock_smart_finance/model/user_model.dart';
//
// class UsersController extends GetxController {
//   final selectedPlatform = 0.obs; // 0 Android, 1 iPhone
//   final selectedStatus = UserStatus.active.obs;
//   //
//   final users = <UserModel>[
//     UserModel(
//       keyId: '158567',
//       name: 'John Doe',
//       mobile: '88420 54542',
//       imei: '352397458773904',
//       createdDate: '03/12/2025',
//       emi: '01/12',
//       status: UserStatus.active, loanBy: '', brand: '', time: '',
//
//     ),
//     UserModel(
//       keyId: '158568',
//       name: 'John Doe',
//       mobile: '88420 54542',
//       imei: '352397458773905',
//       createdDate: '03/12/2025',
//       emi: '01/12',
//       status: UserStatus.locked, loanBy: '', brand: '', time: '',
//     ),
//     UserModel(
//       keyId: '158569',
//       name: 'John Doe',
//       mobile: '88420 54542',
//       imei: '352397458773906',
//       createdDate: '03/12/2025',
//       emi: '01/12',
//       status: UserStatus.pending, loanBy: '', brand: '', time: '',
//     ),
//   ].obs;
//
//   List<UserModel> get filteredUsers =>
//       users.where((e) => e.status == selectedStatus.value).toList();
// }
