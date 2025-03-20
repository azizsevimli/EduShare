import 'package:uuid/uuid.dart';

class GenerateUuid {
  static String generateProductId() {
    String uuid = Uuid().v4().substring(0, 10);
    return uuid;
  }
}