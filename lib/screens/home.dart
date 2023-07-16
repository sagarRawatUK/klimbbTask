import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimbbtask/blocs/location/location_bloc.dart';
import 'package:klimbbtask/screens/location_input_screen.dart';
import 'package:klimbbtask/services/service_locator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final locationBloc = serviceLocator.get<LocationBloc>();

  @override
  void initState() {
    serviceLocator.get<LocationBloc>().add(InitIsar());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: state.currentProfile!.name!.isEmpty
                ? Colors.blue
                : Color(state.currentProfile!.themeColor!),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LocationInputScreen()),
              );
            },
            child: const Icon(Icons.location_on),
          ),
          appBar: AppBar(
            backgroundColor: state.currentProfile!.name!.isEmpty
                ? Colors.blue
                : Color(state.currentProfile!.themeColor!),
            title: const Text('Device Profiles'),
            elevation: 0,
          ),
          drawer: Drawer(
            backgroundColor: state.currentProfile!.name!.isEmpty
                ? Colors.white
                : Color(state.currentProfile!.themeColor!),
            child: DrawerHeader(
              child: state.currentProfile!.name!.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text('Current Device Settings',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        Text(
                            'Profile Name : ${state.currentProfile?.name ?? ''}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(
                            'Text Size : ${state.currentProfile?.textSize ?? ''}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(
                            'Latitude : ${state.currentProfile?.latitude ?? ''}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(
                            'Longitude : ${state.currentProfile?.longitude ?? ''}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.white)),
                      ],
                    )
                  : const Text('No Profile selected',
                      style: TextStyle(
                        fontSize: 18,
                      )),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state.deviceProfiles.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                            'No locations yet.\n Tap on the location icon to add coordinates.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            )),
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        itemCount: state.deviceProfiles.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          final profile = state.deviceProfiles[index];
                          return InkWell(
                            onTap: () {
                              locationBloc
                                  .add(ActivateProfile(deviceProfile: profile));
                            },
                            child: Dismissible(
                              key: Key('${state.deviceProfiles[index].id}'),
                              onDismissed: (direction) {
                                locationBloc
                                    .add(DeleteProfile(deviceProfile: profile));
                              },
                              background: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent,
                                ),
                                alignment: Alignment.centerLeft,
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Icon(Icons.delete_outline,
                                      color: Colors.red),
                                ),
                              ),
                              secondaryBackground: Container(
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.transparent),
                                child: const Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Icon(Icons.delete_outline,
                                      color: Colors.red),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(profile.themeColor ?? 000000),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile.name ?? '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Latitude : ${profile.latitude ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                    Text(
                                      "Longitude : ${profile.longitude ?? ''}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
