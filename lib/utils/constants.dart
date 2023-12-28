String rootApiUrl = "";

//auth
final registerEndpoint = "$rootApiUrl/auth/register";
final loginEndpoint = "$rootApiUrl/auth/login";

//user
final userEndpoint = "$rootApiUrl/user";
final setFcmTokenEndpoint = "$rootApiUrl/user/fcm";
final friendEnpoint = "$rootApiUrl/user/friend";

//post
final getPostsEndpoint = "$rootApiUrl/post";
final uploadPostEndpoint = "$rootApiUrl/post/upload";
final likePostEndpoint = "$rootApiUrl/post/like";

//comment
final getCommentsEndpoint = "$rootApiUrl/comment";
final uploadCommentEndpoint = "$rootApiUrl/comment/upload";
final likeCommentEndpoint = "$rootApiUrl/comment/like";

//friend
final friendRequestEndpoint = "$rootApiUrl/friend/request";
final unfriendRequestEndpoint = "$rootApiUrl/friend/unfriend";
final acceptFriendRequestEndpoint = "$rootApiUrl/friend/accept";
final rejectFriendRequestEndpoint = "$rootApiUrl/friend/reject";
final deleteFriendRequestEndpoint = "$rootApiUrl/friend/request/seen";

const LOCAL_STORAGE_KEY_TOKEN = "token";
