import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:model_annotations/model_annotations.dart';

part 'user.g.dart';

@CfsModel()
class User {
  @DocumentKey()
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
