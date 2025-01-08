class User {
  final String id;
  final String username;
  final List<String> following;
  final String avatar;

  User({
    required this.id,
    required this.username,
    required this.following,
    required this.avatar,
  });
}
