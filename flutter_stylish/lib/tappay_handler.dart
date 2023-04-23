import 'dart:convert';
import 'package:flutter/services.dart';

class Tappay {

  static const _tappayChannel = MethodChannel('stylish.com/tappay'); // 需與平台Channel名一致

  static Future getPrime({
    required String cardNumber,
    required String dueMonth,
    required String dueYear,
    required String ccv,
    required Function onSuccess,
    required Function onFail,
  }) async {
    String response = await _tappayChannel.invokeMethod(
      'getPrime',
      {
        'cardNumber': cardNumber,
        'dueMonth': dueMonth,
        'dueYear': dueYear,
        'ccv': ccv,
      },
    );
    TappayRsp rsp = TappayRsp.fromJson(json.decode(response));
    
    if (rsp.prime!.isNotEmpty) {
      onSuccess("Success: ${rsp.prime!}");
    } else {
      onFail("Error: ${rsp.message!}");
    }
  }
}

class TappayRsp {
  String? status;
  String? message;
  String? prime;

  @override
    String toString() {
    return 'TappayRsp: {status: $status, message: $message, prime: $prime}';
  }

  TappayRsp({this.status, this.message, this.prime});

  TappayRsp.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    prime = json['prime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    data['prime'] = prime;
    return data;
  }
}