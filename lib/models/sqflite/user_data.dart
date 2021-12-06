import 'package:model_annotations/model_annotations.dart';

part 'user_data.g.dart';

@SqflModel()
class UserData {
  final String userId;
  final String data;
  final String type;

  UserData({
    required this.userId,
    required this.data,
    required this.type,
  });
}
