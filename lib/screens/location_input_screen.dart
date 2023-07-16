import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimbbtask/blocs/location/location_bloc.dart';
import 'package:klimbbtask/services/service_locator.dart';
import '../models/device_profile.dart';

class LocationInputScreen extends StatefulWidget {
  const LocationInputScreen({super.key});

  @override
  LocationInputScreenState createState() => LocationInputScreenState();
}

class LocationInputScreenState extends State<LocationInputScreen> {
  final locationBloc = serviceLocator.get<LocationBloc>();

  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  bool _isValidCoordinates(double latitude, double longitude) {
    return latitude >= -90 &&
        latitude <= 90 &&
        longitude >= -180 &&
        longitude <= 180;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Location Setup'),
            backgroundColor: state.currentProfile!.name!.isEmpty
                ? Colors.blue
                : Color(state.currentProfile!.themeColor!),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: latitudeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Latitude'),
                ),
                TextField(
                  controller: longitudeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Longitude'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: state.currentProfile!.name!.isEmpty
                        ? Colors.blue
                        : Color(state.currentProfile!.themeColor!),
                  ),
                  onPressed: () {
                    final latitude = double.tryParse(latitudeController.text);
                    final longitude = double.tryParse(longitudeController.text);

                    if (latitude != null && longitude != null) {
                      if (_isValidCoordinates(latitude, longitude)) {
                        final profile = DeviceProfile()
                          ..latitude = double.parse(latitudeController.text)
                          ..longitude = double.parse(latitudeController.text);

                        locationBloc
                            .add(MapLocationToProfile(deviceProfile: profile));
                        Navigator.pop(context);
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Invalid Coordinates'),
                              content: const Text(
                                  'Please enter valid latitude (-90 to 90) and longitude (-180 to 180) values.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Invalid Input'),
                            content: const Text(
                                'Please enter valid latitude and longitude values.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Save Manual Location'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
