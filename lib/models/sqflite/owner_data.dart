import 'package:model_annotations/model_annotations.dart';

part 'owner_data.g.dart';

@SqflModel()
class OwnerData {
  final String ownerId;
  final String data;
  final String type;

  OwnerData({
    required this.ownerId,
    required this.data,
    required this.type,
  });
}
