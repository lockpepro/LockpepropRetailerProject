// class LoginResponse {
//   final bool success;
//   final String message;
//   final String? token;
//   final dynamic data;
//
//   LoginResponse({
//     required this.success,
//     required this.message,
//     this.token,
//     this.data,
//   });
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     final msg = (json["message"] ?? json["msg"] ?? "Login response").toString();
//
//     // token possible keys
//     final t =
//         json["token"] ??
//             json["accessToken"] ??
//             json["data"]?["token"] ??
//             json["data"]?["accessToken"];
//
//     // success possible keys
//     final s = (json["success"] ??
//         json["status"] == 200 ||
//             json["status"] == true)
//         ? true
//         : false;
//
//     return LoginResponse(
//       success: s,
//       message: msg,
//       token: t?.toString(),
//       data: json["data"],
//     );
//   }
// }

// class LoginResponse {
//   int? status;
//   String? message;
//   LoginData? data;
//
//   LoginResponse({this.status, this.message, this.data});
//
//   LoginResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null
//         ? LoginData.fromJson(json['data'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.toJson(),
//     };
//   }
// }
//
// class LoginData {
//   String? token;
//   String? id;
//   String? otp;
//   String? phone;
//   String? securityPin;
//   bool? isPinSet;
//   TwoFactorAuth? twoFactorAuth;
//
//   LoginData({
//     this.token,
//     this.id,
//     this.otp,
//     this.phone,
//     this.securityPin,
//     this.isPinSet,
//     this.twoFactorAuth,
//   });
//
//   LoginData.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     id = json['id'];
//     otp = json['otp'];
//     phone = json['phone'];
//     securityPin = json['securityPin'];
//     isPinSet = json['isPinSet'];
//     twoFactorAuth = json['twoFactorAuth'] != null
//         ? TwoFactorAuth.fromJson(json['twoFactorAuth'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'token': token,
//       'id': id,
//       'otp': otp,
//       'phone': phone,
//       'securityPin': securityPin,
//       'isPinSet': isPinSet,
//       'twoFactorAuth': twoFactorAuth?.toJson(),
//     };
//   }
// }
//
// class TwoFactorAuth {
//   SmsAuth? sms;
//   EmailAuth? email;
//   PasskeyAuth? passkey;
//   PasskeyAuth? faceId;
//   bool? enabled;
//
//   TwoFactorAuth({
//     this.sms,
//     this.email,
//     this.passkey,
//     this.faceId,
//     this.enabled,
//   });
//
//   TwoFactorAuth.fromJson(Map<String, dynamic> json) {
//     sms = json['sms'] != null ? SmsAuth.fromJson(json['sms']) : null;
//     email = json['email'] != null ? EmailAuth.fromJson(json['email']) : null;
//     passkey =
//     json['passkey'] != null ? PasskeyAuth.fromJson(json['passkey']) : null;
//     faceId =
//     json['faceId'] != null ? PasskeyAuth.fromJson(json['faceId']) : null;
//     enabled = json['enabled'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'sms': sms?.toJson(),
//       'email': email?.toJson(),
//       'passkey': passkey?.toJson(),
//       'faceId': faceId?.toJson(),
//       'enabled': enabled,
//     };
//   }
// }
//
// class SmsAuth {
//   bool? enabled;
//   bool? verified;
//   String? phone;
//
//   SmsAuth({this.enabled, this.verified, this.phone});
//
//   SmsAuth.fromJson(Map<String, dynamic> json) {
//     enabled = json['enabled'];
//     verified = json['verified'];
//     phone = json['phone'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'enabled': enabled,
//       'verified': verified,
//       'phone': phone,
//     };
//   }
// }
//
// class EmailAuth {
//   bool? enabled;
//   bool? verified;
//   String? email;
//
//   EmailAuth({this.enabled, this.verified, this.email});
//
//   EmailAuth.fromJson(Map<String, dynamic> json) {
//     enabled = json['enabled'];
//     verified = json['verified'];
//     email = json['email'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'enabled': enabled,
//       'verified': verified,
//       'email': email,
//     };
//   }
// }
//
// class PasskeyAuth {
//   bool? enabled;
//
//   PasskeyAuth({this.enabled});
//
//   PasskeyAuth.fromJson(Map<String, dynamic> json) {
//     enabled = json['enabled'];
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'enabled': enabled,
//     };
//   }
// }

class LoginResponse {
  int? status;        // old style
  String? message;
  LoginData? data;

  // new style (optional)
  bool? success;
  String? token;
  LoginUser? user;

  LoginResponse({
    this.status,
    this.message,
    this.data,
    this.success,
    this.token,
    this.user,
  });

  LoginResponse.fromJson(Map<String, dynamic> json) {
    // ✅ NEW API: { success, message, token, user:{} }
    if (json.containsKey('success')) {
      success = json['success'] == true;
      message = (json['message'] ?? '').toString();
      token = (json['token'] ?? '').toString();

      user = json['user'] is Map<String, dynamic>
          ? LoginUser.fromJson(json['user'] as Map<String, dynamic>)
          : null;

      // ✅ Map NEW -> OLD (so existing controller remains unchanged)
      status = (success == true) ? 200 : 400;

      data = LoginData(
        token: token,
        id: user?.id,
        isPinSet: false, // new response me nahi aa raha
      );
      return;
    }

    // ✅ OLD API: { status, message, data:{} }
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
      'success': success,
      'token': token,
      'user': user?.toJson(),
    };
  }
}

class LoginUser {
  String? id;
  String? email;
  String? name;
  String? userType;
  String? role;

  LoginUser({this.id, this.email, this.name, this.userType, this.role});

  LoginUser.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    email = json['email']?.toString();
    name = json['name']?.toString();
    userType = json['userType']?.toString();
    role = json['role']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'userType': userType,
      'role': role,
    };
  }
}

class LoginData {
  String? token;
  String? id;
  String? otp;
  String? phone;
  String? securityPin;
  bool? isPinSet;
  TwoFactorAuth? twoFactorAuth;

  LoginData({
    this.token,
    this.id,
    this.otp,
    this.phone,
    this.securityPin,
    this.isPinSet,
    this.twoFactorAuth,
  });

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    otp = json['otp'];
    phone = json['phone'];
    securityPin = json['securityPin'];
    isPinSet = json['isPinSet'];
    twoFactorAuth =
    json['twoFactorAuth'] != null ? TwoFactorAuth.fromJson(json['twoFactorAuth']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'otp': otp,
      'phone': phone,
      'securityPin': securityPin,
      'isPinSet': isPinSet,
      'twoFactorAuth': twoFactorAuth?.toJson(),
    };
  }
}

// ✅ keep your existing classes same
class TwoFactorAuth {
  SmsAuth? sms;
  EmailAuth? email;
  PasskeyAuth? passkey;
  PasskeyAuth? faceId;
  bool? enabled;

  TwoFactorAuth({this.sms, this.email, this.passkey, this.faceId, this.enabled});

  TwoFactorAuth.fromJson(Map<String, dynamic> json) {
    sms = json['sms'] != null ? SmsAuth.fromJson(json['sms']) : null;
    email = json['email'] != null ? EmailAuth.fromJson(json['email']) : null;
    passkey = json['passkey'] != null ? PasskeyAuth.fromJson(json['passkey']) : null;
    faceId = json['faceId'] != null ? PasskeyAuth.fromJson(json['faceId']) : null;
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    return {
      'sms': sms?.toJson(),
      'email': email?.toJson(),
      'passkey': passkey?.toJson(),
      'faceId': faceId?.toJson(),
      'enabled': enabled,
    };
  }
}

class SmsAuth {
  bool? enabled;
  bool? verified;
  String? phone;

  SmsAuth({this.enabled, this.verified, this.phone});

  SmsAuth.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    verified = json['verified'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {'enabled': enabled, 'verified': verified, 'phone': phone};
  }
}

class EmailAuth {
  bool? enabled;
  bool? verified;
  String? email;

  EmailAuth({this.enabled, this.verified, this.email});

  EmailAuth.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    verified = json['verified'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    return {'enabled': enabled, 'verified': verified, 'email': email};
  }
}

class PasskeyAuth {
  bool? enabled;

  PasskeyAuth({this.enabled});

  PasskeyAuth.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    return {'enabled': enabled};
  }
}