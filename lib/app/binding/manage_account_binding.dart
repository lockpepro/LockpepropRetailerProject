import 'package:get/get.dart';
import 'package:zlock_smart_finance/account/manage_accounts/manage_account_controlller.dart';

class ManageAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageAccountController>(() => ManageAccountController());
  }
}
