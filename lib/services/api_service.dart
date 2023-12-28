import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/server_response.dart';
import 'package:social_media_app/models/response_general.dart';
import 'package:social_media_app/services/shared_preference_service.dart';
import 'package:social_media_app/services/toast_service.dart';
import 'package:social_media_app/utils/constants.dart';
import 'package:social_media_app/views/login/login_view.dart';
import 'package:stacked_services/stacked_services.dart';

class ApiService {
  final _toastService = locator<ToastService>();
  final _sharedPreferenceService = locator<SharedPreferenceService>();
  final _navigationService = locator<NavigationService>();

  Future<ServerResponse> _postRequest(String endpoint, dynamic body) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: _getHeadersJson(),
      body: json.encode(body),
    );
    _checkServerResponse(response: response);
    return ServerResponse(response: response);
  }

  Future<ServerResponse> _getRequest(String endpoint,
      {Map<String, dynamic>? params}) async {
    final Uri uri = Uri.parse(endpoint).replace(queryParameters: params);
    final response = await http.get(
      uri,
      headers: _getHeadersJson(),
    );
    _checkServerResponse(response: response);
    return ServerResponse(response: response);
  }

  Map<String, String> _getHeadersJson() {
    debugPrint("Token: ${_sharedPreferenceService.getToken()}");
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${_sharedPreferenceService.getToken()}"
    };
  }

  Future<ServerResponse> registerUser(
      String fullName, String username, String email, String password) async {
    final body = {
      "fullName": fullName,
      "username": username,
      "email": email,
      "password": password,
    };
    return await _postRequest(registerEndpoint, body);
  }

  Future<ServerResponse> loginUser(String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };
    return await _postRequest(loginEndpoint, body);
  }

  Future<ServerResponse> uploadPost(
      List<String> mediaPaths, String content) async {
    var request = http.MultipartRequest('POST', Uri.parse(uploadPostEndpoint));
    request.headers['Authorization'] =
        "Bearer ${_sharedPreferenceService.getToken()}";

    // for (var path in mediaPaths) {
    //   request.files.add(await http.MultipartFile.fromPath('medias', path));
    // }

    for (var path in mediaPaths) {
      File imageFile = File(path);
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var fileType = lookupMimeType(imageFile.path);
      debugPrint("File type: $fileType");

      var multipartFile = http.MultipartFile('medias', stream, length,
          filename: imageFile.path.split('/').last, // Extracting the file name
          contentType: MediaType.parse(fileType ?? 'image/jpeg'));

      request.files.add(multipartFile);
    }

    request.fields['content'] = content;

    final response = await http.Response.fromStream(await request.send());
    _checkServerResponse(response: response);
    return ServerResponse(response: response);
  }

  Future<ServerResponse> likePost(String postId) async {
    final body = {"postId": postId};
    return await _postRequest(likePostEndpoint, body);
  }

  Future<ServerResponse> getPosts({int offset = 0, int limit = 20}) async {
    final params = {"offset": offset.toString(), "limit": limit.toString()};
    return await _getRequest(getPostsEndpoint, params: params);
  }

  Future<ServerResponse> getPostsByUser(String userId,
      {int offset = 0, int limit = 20}) async {
    final params = {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "userId": userId,
    };
    return await _getRequest(getPostsEndpoint, params: params);
  }

  Future<ServerResponse> likeComment(String commentId) async {
    final body = {"commentId": commentId};
    return await _postRequest(likeCommentEndpoint, body);
  }

  Future<ServerResponse> getComments(String postId,
      {int offset = 0, int limit = 20}) async {
    final params = {
      "offset": offset.toString(),
      "limit": limit.toString(),
      "postId": postId,
    };
    return await _getRequest(getCommentsEndpoint, params: params);
  }

  Future<ServerResponse> uploadCommentByPost(
      String postId, String content) async {
    final body = {"postId": postId, "content": content};
    return await _postRequest(uploadCommentEndpoint, body);
  }

  Future<ServerResponse> getPublicProfile(String userId) async {
    return await _getRequest("$userEndpoint/$userId");
  }

  Future<ServerResponse> updateUser(
      String fullName, String profilePicPath) async {
    final Map<String, String> headers = _getHeadersJson();
    headers['Content-Type'] = 'multipart/form-data';

    var request = http.MultipartRequest('POST', Uri.parse(userEndpoint));
    request.headers.addAll(headers);
    request.fields['fullName'] = fullName;
    var fileType = lookupMimeType(profilePicPath);
    debugPrint("File type: $fileType");

    if (profilePicPath.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath(
          'profilePic', profilePicPath,
          contentType: MediaType.parse(fileType ?? 'image/jpeg')));
    }

    final response = await http.Response.fromStream(await request.send());
    _checkServerResponse(response: response);
    return ServerResponse(response: response);
  }

  Future<ServerResponse> getUser() async {
    return await _getRequest(userEndpoint);
  }

  Future<ServerResponse> updateFcmToken(String fcmToken) async {
    final body = {"fcmToken": fcmToken};
    return await _postRequest(setFcmTokenEndpoint, body);
  }

  Future<ServerResponse> sendFriendRequest(String receiverId) async {
    final body = {"receiverId": receiverId};
    return await _postRequest(friendRequestEndpoint, body);
  }

  Future<ServerResponse> sendUnfriendRequest(String receiverId) async {
    final body = {"receiverId": receiverId};
    return await _postRequest(unfriendRequestEndpoint, body);
  }

  Future<ServerResponse> acceptFriendRequest(String senderId) async {
    final body = {"senderId": senderId};
    return await _postRequest(acceptFriendRequestEndpoint, body);
  }

  Future<ServerResponse> rejectFriendRequest(String senderId) async {
    final body = {"senderId": senderId};
    return await _postRequest(rejectFriendRequestEndpoint, body);
  }

  Future<ServerResponse> deleteRespondedFriendRequests() async {
    return await _postRequest(deleteFriendRequestEndpoint, {});
  }

  void _checkServerResponse({required http.Response response}) {
    debugPrint("${response.body} ${response.statusCode}");

    final data = ResponseGeneral.fromJson(json.decode(response.body));

    if (data.detail?.success != true) {
      _toastService.callToast(data.detail?.message);
      if (response.statusCode == 401) {
        _sharedPreferenceService.setToken("");
        _navigationService.clearStackAndShowView(LoginView());
      }
    }
  }
}
