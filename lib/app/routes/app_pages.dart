import 'package:get/get.dart';
import 'package:zlock_smart_finance/account/account_page.dart';
import 'package:zlock_smart_finance/account/manage_accounts/retail_manage_account.dart';
import 'package:zlock_smart_finance/account/widget/account_binding.dart';
import 'package:zlock_smart_finance/app/binding/auth_binding.dart';
import 'package:zlock_smart_finance/app/binding/manage_account_binding.dart';
import 'package:zlock_smart_finance/app/routes/app_routes.dart';
import 'package:zlock_smart_finance/enter_pin_page.dart';
import 'package:zlock_smart_finance/modules/distributor/dashboard/dashboard_distributor.dart';
import 'package:zlock_smart_finance/modules/retailer/dashboard/dashboard_retailer.dart';
import 'package:zlock_smart_finance/modules/splash/splash_binding.dart';
import 'package:zlock_smart_finance/modules/two_factor_auth/two_factor_auth_screen.dart';
import '../../modules/splash/splash_screen.dart';
import '../../modules/auth/role/role_screen.dart';
import '../../modules/auth/login/login_screen.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: AppRoutes.ROLE,
    //   page: () => RoleScreen(),
    // ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.DASH_RETAILER,
      page: () => RetailerDashboard(),
    ),
    GetPage(
      name: AppRoutes.DASH_DISTRIBUTOR,
      page: () => DistributorDashboard(),
    ),
    GetPage(
      name: AppRoutes.RETAIL_ACCOUNT_PAGE,
      page: () => RetailAccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: AppRoutes.DISTRIBUTOR_ACCOUNT_PAGE,
      page: () => DistributorAccountPage(),
    ),
    GetPage(
      name: AppRoutes.MANAGE_ACCOUNT,
      page: () => const ManageAccountScreen(),
      binding: ManageAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.TWO_FACTOR_AUTH,
      page: () =>  TwoFactorScreen(),
      // binding: ManageAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.ENTER_MPIN,
      page: () => EnterPinPage(),
    ),

    GetPage(
      name: AppRoutes.CREATE_MPIN,
      page: () => CreatePinPage(),
    ),
  ];
}
