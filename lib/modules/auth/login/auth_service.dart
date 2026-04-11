
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:zlock_smart_finance/app/services/dio_client.dart';
import 'package:zlock_smart_finance/app/services/retailer_api.dart';
import 'package:zlock_smart_finance/app/services/snckbar.dart';
import 'package:zlock_smart_finance/model/login_response.dart';

class AuthService {
  Future<LoginResponse?> login({
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      final payload = {
        "email": email.trim(),
        "password": password.trim(),
        // "userType": userType.trim(),
      };

      debugPrint("✅ HIT: ${RetailerAPI.login}");
      debugPrint("✅ PAYLOAD: ${jsonEncode(payload)}");

      final res = await ApiClient.dio.post(RetailerAPI.login, data: payload);

      debugPrint("✅ STATUS: ${res.statusCode}");
      debugPrint("✅ RESPONSE: ${res.data}");

      if (res.data is Map<String, dynamic>) {
        return LoginResponse.fromJson(res.data as Map<String, dynamic>);
      }

      // non-json response
      AppSnack.error("Server returned non-JSON response");
      return null;
    } on DioException catch (e) {
      final code = e.response?.statusCode;

      debugPrint("❌ DIO STATUS: $code");
      debugPrint("❌ DIO URL: ${e.requestOptions.uri}");
      debugPrint("❌ DIO RESPONSE: ${e.response?.data}");

      final serverMsg = (e.response?.data is Map)
          ? (e.response?.data["message"] ??
          e.response?.data["msg"] ??
          "")
          .toString()
          : "";

      final msg = serverMsg.isNotEmpty
          ? serverMsg
          : (code == 404)
          ? "API endpoint not found (404)."
          : "Login failed. Please try again.";

      AppSnack.error(msg);
      return null;
    } catch (e) {
      debugPrint("❌ UNKNOWN ERROR: $e");
      AppSnack.error("Something went wrong");
      return null;
    }
  }
}
