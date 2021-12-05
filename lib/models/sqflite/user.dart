import 'package:model_annotations/model_annotations.dart';

part 'user.g.dart';

@SqflModel()
class User {
  final String userId;
  final String name;
  final String? profilePic;

  User({
    required this.userId,
    required this.name,
    required this.profilePic,
  });
}
