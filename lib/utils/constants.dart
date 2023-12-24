String rootApiUrl = "";

//auth
final registerEndpoint = "$rootApiUrl/auth/register";
final loginEndpoint = "$rootApiUrl/auth/login";

//user
final userEndpoint = "$rootApiUrl/user";

//post
final getPostsEndpoint = "$rootApiUrl/post";
final uploadPostEndpoint = "$rootApiUrl/post/upload";
final likePostEndpoint = "$rootApiUrl/post/like";

//comment
final getCommentsEndpoint = "$rootApiUrl/comment";
final uploadCommentEndpoint = "$rootApiUrl/comment/upload";
final likeCommentEndpoint = "$rootApiUrl/comment/like";

const LOCAL_STORAGE_KEY_TOKEN = "token";
