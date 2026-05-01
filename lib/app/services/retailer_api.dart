

class RetailerAPI {

  static String baseUrl = "https://lockpepro.com";

  // static String login = "$baseUrl/api/v1/user/login";
  // ✅ NEW APIs
  static String login = "$baseUrl/api/v1/auth/login";
  static String registerVendor = "$baseUrl/api/v1/auth/vendor/create-form";

  static String getDashBoard = "$baseUrl/api/dashboard";
  static String customerAdd = "$baseUrl/api/customers/customerAdd";
  // static String customersListingV2 = "$baseUrl/api/customers/getAllCustomer";
  static String customersListingV2 =
      "$baseUrl/api/customers/getAllCustomerWithDevices";

  static String sendDeviceCommand = "$baseUrl/api/mdm/device/sendCommand";

  // ✅ NEW LOCATION API
  static String deviceLocation(String deviceId) =>
      "$baseUrl/api/mdm/devices/$deviceId/location";

  static String getProfile = "$baseUrl/api/v1/auth/profile";
  static String updateProfile =
      "$baseUrl/api/v1/auth/vendor/update";

  static String changePassword = "$baseUrl/api/v1/auth/change-password";

  static String changePasswordAdmin = "$baseUrl/api/v1/auth/change-password-admin";

  static String keyDetail = "$baseUrl/api/dashboard/key-summary";

  static String keyLedger = "$baseUrl/api/keys/ledger";

  static String updateFrpEmail =
      "$baseUrl/api/v1/auth/frp-email/update";

  static String addRetailer = "$baseUrl/api/v1/auth/register/vendor";
}
