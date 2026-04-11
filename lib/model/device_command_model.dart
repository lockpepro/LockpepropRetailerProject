// class ApiMessageResponse {
//   final int status;
//   final String message;
//
//   ApiMessageResponse({required this.status, required this.message});
//
//   factory ApiMessageResponse.fromJson(Map<String, dynamic> json) {
//     return ApiMessageResponse(
//       status: (json["status"] ?? 0) as int,
//       message: (json["message"] ?? "").toString(),
//     );
//   }
//
//   bool get success => status == 200 || status == 201;
// }
//
// class DeviceCommandRequest {
//   final String deviceId;
//   final String commandType; // ex: LOCATION_ON
//   final Map<String, dynamic>? payload;
//
//   DeviceCommandRequest({
//     required this.deviceId,
//     required this.commandType,
//     this.payload,
//   });
//
//   Map<String, dynamic> toJson() {
//     final m = <String, dynamic>{
//       "deviceId": deviceId,
//       "commandType": commandType,
//     };
//     if (payload != null && payload!.isNotEmpty) {
//       m["payload"] = payload;
//     }
//     return m;
//   }
// }

class DeviceCommandRequest {
  final String deviceId;
  final String commandType;
  final Map<String, dynamic>? payload;

  DeviceCommandRequest({
    required this.deviceId,
    required this.commandType,
    this.payload,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      "device_id": deviceId,
      "command_type": commandType,
    };

    if (payload != null && payload!.isNotEmpty) {
      map.addAll(payload!);
    }

    return map;
  }
}

class DeviceCommandResponse {
  final bool success;
  final String message;
  final bool alreadyExists;
  final DeviceCommandData? command;
  final DeviceCommandFcm? fcm;

  DeviceCommandResponse({
    required this.success,
    required this.message,
    required this.alreadyExists,
    required this.command,
    required this.fcm,
  });

  factory DeviceCommandResponse.fromJson(Map<String, dynamic> json) {
    return DeviceCommandResponse(
      success: json["success"] == true,
      message: (json["message"] ?? "").toString(),
      alreadyExists: json["already_exists"] == true,
      command: json["command"] is Map<String, dynamic>
          ? DeviceCommandData.fromJson(
        Map<String, dynamic>.from(json["command"]),
      )
          : null,
      fcm: json["fcm"] is Map<String, dynamic>
          ? DeviceCommandFcm.fromJson(
        Map<String, dynamic>.from(json["fcm"]),
      )
          : null,
    );
  }
}

class DeviceCommandData {
  final String id;
  final String deviceId;
  final String commandType;
  final String status;
  final int priority;
  final dynamic result;
  final dynamic error;
  final int retryCount;
  final int maxRetries;
  final String? executedAt;
  final String? createdBy;
  final String? policyId;
  final String? commandId;
  final String? createdAt;
  final String? updatedAt;

  DeviceCommandData({
    required this.id,
    required this.deviceId,
    required this.commandType,
    required this.status,
    required this.priority,
    required this.result,
    required this.error,
    required this.retryCount,
    required this.maxRetries,
    required this.executedAt,
    required this.createdBy,
    required this.policyId,
    required this.commandId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeviceCommandData.fromJson(Map<String, dynamic> json) {
    return DeviceCommandData(
      id: (json["_id"] ?? "").toString(),
      deviceId: (json["device_id"] ?? "").toString(),
      commandType: (json["command_type"] ?? "").toString(),
      status: (json["status"] ?? "").toString(),
      priority: _toInt(json["priority"]),
      result: json["result"],
      error: json["error"],
      retryCount: _toInt(json["retry_count"]),
      maxRetries: _toInt(json["max_retries"]),
      executedAt: json["executed_at"]?.toString(),
      createdBy: json["created_by"]?.toString(),
      policyId: json["policy_id"]?.toString(),
      commandId: json["command_id"]?.toString(),
      createdAt: json["createdAt"]?.toString(),
      updatedAt: json["updatedAt"]?.toString(),
    );
  }
}

class DeviceCommandFcm {
  final bool success;
  final String? error;
  final String? errorCode;

  DeviceCommandFcm({
    required this.success,
    required this.error,
    required this.errorCode,
  });

  factory DeviceCommandFcm.fromJson(Map<String, dynamic> json) {
    return DeviceCommandFcm(
      success: json["success"] == true,
      error: json["error"]?.toString(),
      errorCode: json["error_code"]?.toString(),
    );
  }
}

int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  return int.tryParse(v.toString()) ?? 0;
}