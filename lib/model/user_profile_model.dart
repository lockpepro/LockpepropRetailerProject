// class UserProfileResponse {
//   int? status;
//   UserProfileData? data;
//
//   UserProfileResponse({this.status, this.data});
//
//   UserProfileResponse.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     data = json['data'] != null
//         ? UserProfileData.fromJson(json['data'])
//         : null;
//   }
// }
//
// class UserProfileData {
//   User? user;
//   String? memberSince;
//
//   UserProfileData({this.user, this.memberSince});
//
//   UserProfileData.fromJson(Map<String, dynamic> json) {
//     user = json['user'] != null ? User.fromJson(json['user']) : null;
//     memberSince = json['memberSince'];
//   }
// }
//
// class User {
//   final String? id;
//   final String? firstName;
//   final String? lastName;
//   final String? fullName;
//   final String? email;
//   final String? phone;
//   final String? image;
//   final String? companyName;
//   final String? dob;
//   final String? city;
//   final String? aadhaarNumber;
//   final String? sign;
//   final AddressDetails? addressDetails;
//
//   User({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.fullName,
//     this.email,
//     this.phone,
//     this.image,
//     this.companyName,
//     this.dob,
//     this.city,
//     this.aadhaarNumber,
//     this.sign,
//     this.addressDetails,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json["_id"]?.toString(),
//       firstName: json["firstName"]?.toString(),
//       lastName: json["lastName"]?.toString(),
//       fullName: json["fullName"]?.toString(),
//       email: json["email"]?.toString(),
//       phone: json["phone"]?.toString(),
//       image: json["image"]?.toString(),
//       companyName: json["companyName"]?.toString(),
//       dob: json["dob"]?.toString(),
//       city: json["city"]?.toString(),
//       aadhaarNumber: json["aadhaarNumber"]?.toString(),
//       sign: json["sign"]?.toString(),
//       addressDetails: json["addressDetails"] != null
//           ? AddressDetails.fromJson(json["addressDetails"])
//           : null,
//     );
//   }
//
//
//   /// ✅ Always safe name to show in UI
//   String get displayName {
//     final fn = (firstName ?? "").trim();
//     final ln = (lastName ?? "").trim();
//     // final full = (fullName ?? "").trim();
//     // if (full.isNotEmpty) return full;
//     final combo = "$fn $ln".trim();
//     return combo.isNotEmpty ? combo : "User";
//   }
//
// }
//
// class AddressDetails {
//   final String? streetAddress;
//   final String? city;
//   final String? state;
//   final String? zipCode;
//
//   AddressDetails({this.streetAddress, this.city, this.state, this.zipCode});
//
//   factory AddressDetails.fromJson(Map<String, dynamic> json) {
//     return AddressDetails(
//       streetAddress: json["streetAddress"]?.toString(),
//       city: json["city"]?.toString(),
//       state: json["state"]?.toString(),
//       zipCode: json["zipCode"]?.toString(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     "streetAddress": streetAddress ?? "",
//     "city": city ?? "",
//     "state": state ?? "",
//     "zipCode": zipCode ?? "",
//   };
// }

class UserProfileResponse {
  int? status;
  UserProfileData? data;

  UserProfileResponse({this.status, this.data});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      status: json["success"] == true ? 200 : 500,
      data: json["user"] != null
          ? UserProfileData(user: User.fromJson(json["user"]))
          : null,
    );
  }
}

class UserProfileData {
  User? user;

  UserProfileData({this.user});
}

// class User {
//   final String? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? companyName;
//   final String? city;
//   final String? state;
//   final String? address;
//   final String? gst;
//   final String? type;
//   final String? status;
//
//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.companyName,
//     this.city,
//     this.state,
//     this.address,
//     this.gst,
//     this.type,
//     this.status,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json["_id"]?.toString(),
//       name: json["name"]?.toString(),
//       email: json["email"]?.toString(),
//       phone: json["phone"]?.toString(),
//       companyName: json["company"]?.toString(),
//       city: json["city"]?.toString(),
//       state: json["state"]?.toString(),
//       address: json["address"]?.toString(),
//       gst: json["gst"]?.toString(),
//       type: json["type"]?.toString(),
//       status: json["status"]?.toString(),
//     );
//   }
//
//   /// Used in UI
//   String get displayName {
//     final nm = (name ?? "").trim();
//     return nm.isNotEmpty ? nm : "User";
//   }
// }

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? companyName;
  final String? city;
  final String? state;
  final String? address;
  final String? gst;
  final String? type;
  final String? status;

  /// ✅ CORRECT MAPPING
  final String? image;
  final String? signature;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.companyName,
    this.city,
    this.state,
    this.address,
    this.gst,
    this.type,
    this.status,
    this.image,
    this.signature,
  });

  /// 🔥 JSON PARSE
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"]?.toString(),
      name: json["name"]?.toString(),
      email: json["email"]?.toString(),
      phone: json["phone"]?.toString(),
      companyName: json["company"]?.toString(),
      city: json["city"]?.toString(),
      state: json["state"]?.toString(),
      address: json["address"]?.toString(),
      gst: json["gst"]?.toString(),
      type: json["type"]?.toString(),
      status: json["status"]?.toString(),

      /// 🔥 IMPORTANT FIX
      image: json["profileImage"]?["url"]?.toString(),
      signature: json["signature"]?["url"]?.toString(),
    );
  }

  /// ✅ COPY WITH (INSIDE CLASS)
  User copyWith({
    String? image,
    String? signature,
  }) {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      companyName: companyName,
      city: city,
      state: state,
      address: address,
      gst: gst,
      type: type,
      status: status,
      image: image ?? this.image,
      signature: signature ?? this.signature,
    );
  }

  /// UI helper
  String get displayName {
    final nm = (name ?? "").trim();
    return nm.isNotEmpty ? nm : "User";
  }
}
class AddressDetails {
  final String? streetAddress;
  final String? city;
  final String? state;
  final String? zipCode;

  AddressDetails({
    this.streetAddress,
    this.city,
    this.state,
    this.zipCode,
  });

  factory AddressDetails.fromJson(Map<String, dynamic> json) {
    return AddressDetails(
      streetAddress: json["streetAddress"],
      city: json["city"],
      state: json["state"],
      zipCode: json["zipCode"],
    );
  }
}
