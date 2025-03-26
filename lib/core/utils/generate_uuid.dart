import 'package:uuid/uuid.dart';

String generateMaterialId() {
  String uuid = const Uuid().v4().substring(0, 10);
  return uuid;
}
