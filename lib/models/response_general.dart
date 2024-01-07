class ResponseGeneral {
  Detail? _detail;

  Detail? get detail => _detail;

  ResponseGeneral({Detail? detail}) {
    _detail = detail;
  }

  ResponseGeneral.fromJson(
    dynamic json,
    int statusCode,
  ) {
    _detail = Detail.fromJson(json, statusCode);
  }
}

class Detail {
  bool? _success;
  int? _statusCode;
  String? _message;
  String? _error;
  dynamic _data;

  int? get statusCode => _statusCode;
  String? get message => _message;
  String? get error => _error;

  dynamic get data => _data;
  bool? get success => _success;

  Detail({String? message, dynamic data}) {
    _message = message;
    _data = data;
  }

  Detail.fromJson(dynamic json, statusCode) {
    _statusCode = statusCode;
    _success = json["success"];
    _message = json["message"];
    _error = json["error"];
    _data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _statusCode;
    map["success"] = _success;
    map["message"] = _message;
    map["error"] = _error;
    map["data"] = _data;
    return map;
  }
}
