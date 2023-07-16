import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:klimbbtask/main.dart';
import 'package:klimbbtask/models/device_profile.dart';
import 'package:klimbbtask/screens/profile_setup_screen.dart';
import 'package:klimbbtask/utility/utility.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late Isar isar;
  LocationBloc() : super(LocationState.initial()) {
    on<InitIsar>((event, emit) async {
      final dir = await path_provider.getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [DeviceProfileSchema],
        directory: dir.path,
        inspector: true,
      );

      add(HomePageOnStart());
    });

    on<CreateDeviceProfile>((event, emit) async {
      final profiles = await isar.deviceProfiles
          .filter()
          .latitudeEqualTo(event.deviceProfile.latitude)
          .and()
          .longitudeEqualTo(event.deviceProfile.longitude)
          .findAll();

      log('Profiles found $profiles');

      if (profiles.isEmpty) {
        await isar.writeTxn(() async {
          await isar.deviceProfiles.put(event.deviceProfile);
        });
      } else {
        if (navigatorKey.currentContext != null) {
          Utility.showDuplicateDialog(navigatorKey.currentContext!);
        }
      }

      add(GetAllDeviceProfiles());
    });

    on<MapLocationToProfile>((event, emit) async {
      final profiles = await isar.deviceProfiles
          .filter()
          .latitudeEqualTo(event.deviceProfile.latitude)
          .and()
          .longitudeEqualTo(event.deviceProfile.longitude)
          .findAll();

      log('Profiles found $profiles');

      if (profiles.isEmpty) {
        if (navigatorKey.currentContext != null) {
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return AlertDialog(
                title: const Text('New Profile'),
                content: const Text('Create new profile for this location.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);

                      Navigator.push(
                        navigatorKey.currentContext!,
                        MaterialPageRoute(
                            builder: (context) => ProfileSetupScreen(
                                profile: event.deviceProfile)),
                      );
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        add(ActivateProfile(deviceProfile: profiles.first));
      }
    });

    on<DeleteProfile>((event, emit) async {
      await isar.writeTxn(() async {
        await isar.deviceProfiles.delete(event.deviceProfile.id);
      });
      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text('${event.deviceProfile.name} profile deleted'),
        ));
      }
      add(GetAllDeviceProfiles());
    });

    on<GetAllDeviceProfiles>((event, emit) async {
      final profiles = await isar.deviceProfiles.where().findAll();

      emit(state.copyWith(deviceProfiles: profiles));
    });

    on<HomePageOnStart>((event, emit) async {
      add(GetAllDeviceProfiles());
    });

    on<ActivateProfile>((event, emit) async {
      emit(state.copyWith(currentProfile: event.deviceProfile));
      if (navigatorKey.currentContext != null) {
        ScaffoldMessenger.of(navigatorKey.currentContext!)
            .showSnackBar(SnackBar(
          content: Text(
              '${event.deviceProfile.name} profile activated with coordinates Lat : ${event.deviceProfile.latitude} Long : ${event.deviceProfile.longitude}'),
        ));
      }
    });
  }
}
