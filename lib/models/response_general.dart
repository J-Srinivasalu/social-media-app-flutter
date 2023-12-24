class ResponseGeneral {
  Detail? _detail;

  Detail? get detail => _detail;

  ResponseGeneral({Detail? detail}) {
    _detail = detail;
  }

  ResponseGeneral.fromJson(
    dynamic json,
  ) {
    _detail = Detail.fromJson(json);
  }
}

class Detail {
  bool? _success;
  String? _message;
  String? _error;
  dynamic _data;

  String? get message => _message;
  String? get error => _error;

  dynamic get data => _data;
  bool? get success => _success;

  Detail({String? message, dynamic data}) {
    _message = message;
    _data = data;
  }

  Detail.fromJson(dynamic json) {
    _success = json["success"];
    _message = json["message"];
    _error = json["error"];
    _data = json["data"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["success"] = _success;
    map["message"] = _message;
    map["error"] = _error;
    map["data"] = _data;
    return map;
  }
}
