part of 'location_bloc.dart';

class LocationEvent {}

class InitIsar extends LocationEvent {}

class CreateDeviceProfile extends LocationEvent {
  final DeviceProfile deviceProfile;
  CreateDeviceProfile({required this.deviceProfile});
}

class GetAllDeviceProfiles extends LocationEvent {}

class HomePageOnStart extends LocationEvent {}

class ActivateProfile extends LocationEvent {
  final DeviceProfile deviceProfile;
  ActivateProfile({required this.deviceProfile});
}

class DeleteProfile extends LocationEvent {
  final DeviceProfile deviceProfile;
  DeleteProfile({required this.deviceProfile});
}

class MapLocationToProfile extends LocationEvent {
  final DeviceProfile deviceProfile;
  MapLocationToProfile({required this.deviceProfile});
}
