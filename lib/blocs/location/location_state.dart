part of 'location_bloc.dart';

class LocationState extends Equatable {
  const LocationState({this.deviceProfiles = const [], this.currentProfile});

  final List<DeviceProfile> deviceProfiles;
  final DeviceProfile? currentProfile;

  @override
  List<Object?> get props => [
        deviceProfiles,
        currentProfile,
      ];

  factory LocationState.initial() => LocationState(
        deviceProfiles: const [],
        currentProfile: DeviceProfile()..name = '',
      );

  LocationState copyWith({
    List<DeviceProfile>? deviceProfiles,
    DeviceProfile? currentProfile,
  }) {
    return LocationState(
        deviceProfiles: deviceProfiles ?? this.deviceProfiles,
        currentProfile: currentProfile ?? this.currentProfile);
  }
}
