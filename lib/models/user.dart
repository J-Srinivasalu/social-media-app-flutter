// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String? id;
  String email;
  String fullName;
  String username;
  User({
    this.id,
    required this.email,
    required this.fullName,
    required this.username,
  });
}
