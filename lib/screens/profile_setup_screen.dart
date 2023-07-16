import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimbbtask/blocs/location/location_bloc.dart';
import 'package:klimbbtask/services/service_locator.dart';
import '../models/device_profile.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key, required this.profile});

  final DeviceProfile profile;

  @override
  ProfileSetupScreenState createState() => ProfileSetupScreenState();
}

class ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final locationBloc = serviceLocator.get<LocationBloc>();

  final TextEditingController nameController = TextEditingController();

  Color selectedColor = Colors.purple.shade400;
  double selectedTextSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile Setup'),
            backgroundColor: state.currentProfile!.name!.isEmpty
                ? Colors.blue
                : Color(state.currentProfile!.themeColor!),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Profile Name'),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Theme Color:'),
                    DropdownButton<Color>(
                      value: selectedColor,
                      onChanged: (value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                      items: [
                        DropdownMenuItem(
                          value: Colors.purple.shade400,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Purple'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: Colors.red.shade400,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Red'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: Colors.green.shade400,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Green'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: Colors.orange.shade400,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Orange'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: Colors.pink.shade400,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.pink,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Pink'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: Colors.brown.shade400,
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text('Brown'),
                            ],
                          ),
                        ),
                        // Add more theme colors as needed
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Text Size:'),
                    DropdownButton<double>(
                      value: selectedTextSize,
                      onChanged: (value) {
                        setState(() {
                          selectedTextSize = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 14.0,
                          child: Text('Small'),
                        ),
                        DropdownMenuItem(
                          value: 16.0,
                          child: Text('Medium'),
                        ),
                        DropdownMenuItem(
                          value: 18.0,
                          child: Text('Large'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: state.currentProfile!.name!.isEmpty
                          ? Colors.blue
                          : Color(state.currentProfile!.themeColor!)),
                  onPressed: () {
                    if (nameController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Invalid Input'),
                            content: const Text('Please enter valid values.'),
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
                      return;
                    }
                    widget.profile
                      ..name = nameController.text
                      ..themeColor = selectedColor.value
                      ..textSize = selectedTextSize;

                    locationBloc.add(
                        CreateDeviceProfile(deviceProfile: widget.profile));
                    Navigator.pop(context);
                  },
                  child: const Text('Save Profile'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
