import 'package:model_builder/model_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'user.g.dart';

@CfsModel()
class User {
  @DocumentKey()
  final String userId;
  final String name;
  final String? profilePic;
  final List<String> emailIds;
  final List<String> phoneNos;
  final List<String> addresses;
  final List<String> shopIds;
  final List<String> orderIds;

  User({
    required this.userId,
    required this.name,
    required this.profilePic,
    required this.emailIds,
    required this.phoneNos,
    required this.addresses,
    required this.shopIds,
    required this.orderIds,
  });
}
