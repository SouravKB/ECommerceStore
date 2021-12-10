class User {
  final String userId;
  final String name;
  final String? profilePicUrl;
  final List<String> phoneNos;
  final List<String> emailIds;
  final List<String> addresses;

  User({
    required this.userId,
    required this.name,
    required this.profilePicUrl,
    required this.phoneNos,
    required this.emailIds,
    required this.addresses,
  });
}
