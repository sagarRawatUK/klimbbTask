import 'package:isar/isar.dart';

part 'device_profile.g.dart';

@collection
class DeviceProfile {
  Id id = Isar.autoIncrement;

  String? name;

  double? latitude;

  double? longitude;

  int? themeColor;

  double? textSize;
}
