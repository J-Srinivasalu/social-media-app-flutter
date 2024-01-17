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
    debugPrint("Request body: $body");
    final response = await http.post(
      Uri.parse(endpoint),
      headers: _getHeadersJson(),
      body: json.encode(body),
    );

    return _checkServerResponse(
        response: response, retryApiCall: () => _postRequest(endpoint, body));
  }

  Future<ServerResponse> _getRequest(String endpoint,
      {Map<String, dynamic>? params}) async {
    final Uri uri = Uri.parse(endpoint).replace(queryParameters: params);
    final response = await http.get(
      uri,
      headers: _getHeadersJson(),
    );

    return _checkServerResponse(
        response: response,
        retryApiCall: () => _getRequest(endpoint, params: params));
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

  Future<ServerResponse> logout() async {
    return await _postRequest(logoutEndpoint, {});
  }

  Future<ServerResponse> refreshAccessToken() async {
    final refreshToken = _sharedPreferenceService.getRefreshToken();
    final body = {
      "refreshToken": refreshToken,
    };
    return await _postRequest(refreshAccessTokenEndpoint, body);
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

    return _checkServerResponse(
        response: response,
        retryApiCall: () => uploadPost(mediaPaths, content));
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

    return _checkServerResponse(
        response: response,
        retryApiCall: () => updateUser(fullName, profilePicPath));
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

  Future<ServerResponse> createOrGetChat(String receiverId) async {
    final body = {
      "receiverId": receiverId,
    };
    return await _postRequest(chatEndpoint, body);
  }

  Future<ServerResponse> sendMessage(
      String conversationId, String message) async {
    final body = {
      "chatId": conversationId,
      "content": message,
    };
    return await _postRequest(messageEndpoint, body);
  }

  Future<ServerResponse> updateStatus(String messageId, String status) async {
    final body = {
      "messageId": messageId,
      "status": status,
    };
    return await _postRequest(messageEndpoint, body);
  }

  Future<ServerResponse> getChats({int offset = 0, int limit = 10}) async {
    final params = {
      "offset": offset.toString(),
      "limit": limit.toString(),
    };
    return await _getRequest(chatEndpoint, params: params);
  }

  Future<ServerResponse> getMessages(String chatId,
      {int offset = 0, int limit = 10}) async {
    final params = {
      "chatId": chatId,
      "offset": offset.toString(),
      "limit": limit.toString(),
    };
    return await _getRequest(messageEndpoint, params: params);
  }

  Future<ServerResponse> getMessage(
    String messageId,
  ) async {
    return await _getRequest("$messageEndpoint/$messageId");
  }

  Future<ServerResponse> sendVideoCallRequest(
      String chatId, String offer) async {
    final body = {
      "chatId": chatId,
      "offer": offer,
    };
    return await _postRequest(videoCallRequestEndpoint, body);
  }

  Future<ServerResponse> rejectVideoCallRequest(
      String receiverId, String messageId) async {
    final body = {
      "receiverId": receiverId,
      "messageId": messageId,
    };
    return await _postRequest(videoCallRejectedEndpoint, body);
  }

  Future<ServerResponse> _checkServerResponse(
      {required http.Response response,
      required Future<ServerResponse> Function() retryApiCall}) async {
    debugPrint("Response: ${response.body} ${response.statusCode}");

    final data = ResponseGeneral.fromJson(
        json.decode(response.body), response.statusCode);
    if (data.detail?.success != true) {
      if (response.statusCode == 401 &&
          data.detail?.message != "Refresh token expired or already used") {
        debugPrint("Access token expire");
        final refreshResponse = await refreshAccessToken();
        debugPrint(
            "refresh access token message: ${refreshResponse.responseGeneral.detail?.message}");
        if (refreshResponse.isSuccessful()) {
          final token = refreshResponse.responseGeneral.detail?.data["token"];
          final refreshToken =
              refreshResponse.responseGeneral.detail?.data["refreshToken"];
          _sharedPreferenceService.setToken(token);
          _sharedPreferenceService.setRefreshToken(refreshToken);
          return await retryApiCall();
        }
        _sharedPreferenceService.setToken("");
        _navigationService.clearStackAndShowView(LoginView());
      } else {
        _toastService.callToast(data.detail?.message);
      }
    }
    return ServerResponse(response: response);
  }
}
