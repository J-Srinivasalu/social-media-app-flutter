import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'response_general.dart';

class ServerResponse {
  final ResponseGeneral responseGeneral;

  ServerResponse({@required Response? response})
      : responseGeneral = ResponseGeneral.fromJson(
          json.decode(
            response?.body ?? "",
          ),
          response?.statusCode ?? 200,
        );

  bool isSuccessful() => (responseGeneral.detail?.success == true);
}
