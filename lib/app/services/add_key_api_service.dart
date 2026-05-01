import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:zlock_smart_finance/app/services/dio_client.dart';
import 'package:zlock_smart_finance/app/services/retailer_api.dart';


import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' show MediaType; // if you use multipart elsewhere


import 'package:http_parser/http_parser...dart';

class NewKeyApiService {
  Future<CustomerAddResponse> customerAddMultipart({
    required NewKeyEntry entry,
    required String name,
    required String phone,
    required String email,
    required String imei1,
    String? imei2,
    String? loanBy,

    File? profileImage,   // ✅ KEY: profileImage
    File? aadhaarFront,   // ✅ KEY: aadhaarFront
    File? aadhaarBack,    // ✅ KEY: aadhaarBack
    required List<int> signaturePngBytes, // ✅ KEY: signature (File)

    // ✅ EMI flat fields (Postman style)
    Map<String, dynamic>? emiFlat,
  }) async {
    try {
      final map = _mapEntry(entry);

      final form = FormData();

      // ✅ TEXT FIELDS
      form.fields.add(MapEntry("name", name.trim()));
      form.fields.add(MapEntry("phone", phone.trim()));
      form.fields.add(MapEntry("email", email.trim()));
      form.fields.add(MapEntry("imei1", imei1.trim()));

      if (imei2 != null && imei2.trim().isNotEmpty) {
        form.fields.add(MapEntry("imei2", imei2.trim()));
      }
      if (loanBy != null && loanBy.trim().isNotEmpty) {
        form.fields.add(MapEntry("loanBy", loanBy.trim()));
      }


      // ✅ these exist in your backend earlier (keep, no impact)
      form.fields.add(MapEntry("deviceType", map["deviceType"]!)); // new/running/iPhone
      form.fields.add(MapEntry("key_type", map["key_type"]!));     // 1/2/3

      // ✅ EMI FLAT (only when provided)
      if (emiFlat != null && emiFlat.isNotEmpty) {
        for (final e in emiFlat.entries) {
          final v = e.value;
          if (v == null) continue;
          final s = v.toString().trim();
          if (s.isEmpty) continue;
          form.fields.add(MapEntry(e.key, s)); // send as TEXT like Postman
        }
      }

      // ✅ FILES
      if (profileImage != null && profileImage.existsSync()) {
        form.files.add(MapEntry(
          "profileImage",
          await MultipartFile.fromFile(
            profileImage.path,
            filename: profileImage.path.split('/').last,
          ),
        ));
      }

      if (aadhaarFront != null && aadhaarFront.existsSync()) {
        form.files.add(MapEntry(
          "aadhaarFront",
          await MultipartFile.fromFile(
            aadhaarFront.path,
            filename: aadhaarFront.path.split('/').last,
          ),
        ));
      }

      if (aadhaarBack != null && aadhaarBack.existsSync()) {
        form.files.add(MapEntry(
          "aadhaarBack",
          await MultipartFile.fromFile(
            aadhaarBack.path,
            filename: aadhaarBack.path.split('/').last,
          ),
        ));
      }

      // ✅ signature as FILE (not base64)
      form.files.add(MapEntry(
        "signature",
        MultipartFile.fromBytes(
          signaturePngBytes,
          filename: "signature.png",
          contentType: MediaType("image", "png"),
        ),
      ));

      // ✅ DEBUG
      debugPrint("✅ CUSTOMER ADD MULTIPART HIT: ${RetailerAPI.customerAdd}");
      for (final f in form.fields) debugPrint("FIELD => ${f.key}: ${f.value}");
      for (final f in form.files) debugPrint("FILE  => ${f.key}: ${f.value.filename}");

      final res = await ApiClient.dio.post(
        RetailerAPI.customerAdd,
        data: form,
        options: Options(
          contentType: "multipart/form-data",
          validateStatus: (_) => true, // read msg even on 400
        ),
      );

      debugPrint("✅ CUSTOMER ADD MULTIPART STATUS: ${res.statusCode}");
      debugPrint("✅ CUSTOMER ADD MULTIPART RESP: ${res.data}");

      if (res.data is Map) {
        return CustomerAddResponse.fromJson(Map<String, dynamic>.from(res.data));
      }
      return CustomerAddResponse(success: false, message: "Invalid server response");
    } catch (e) {
      debugPrint("❌ CUSTOMER ADD MULTIPART ERROR: $e");
      return CustomerAddResponse(success: false, message: "Something went wrong");
    }
  }

  Map<String, String> _mapEntry(NewKeyEntry entry) {
    switch (entry) {
      case NewKeyEntry.android:
        return {"deviceType": "new", "key_type": "1"};
      case NewKeyEntry.running:
        return {"deviceType": "running", "key_type": "2"};
      case NewKeyEntry.iphone:
        return {"deviceType": "iPhone", "key_type": "3"};
    }
  }
}
class CustomerAddResponse {
  final bool success;
  final String message;
  final dynamic data;

  CustomerAddResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory CustomerAddResponse.fromJson(Map<String, dynamic> json) {
    return CustomerAddResponse(
      success: json["success"] == true,
      message: (json["message"] ?? "").toString(),
      data: json["data"],
    );
  }
}