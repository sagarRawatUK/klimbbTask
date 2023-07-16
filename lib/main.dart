import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimbbtask/blocs/location/location_bloc.dart';
import 'package:klimbbtask/screens/home.dart';
import 'package:klimbbtask/services/service_locator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator().then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (BuildContext context) => serviceLocator.get<LocationBloc>(),
        ),
      ],
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'KlimbbTask',
            theme: ThemeData(
              fontFamily: 'PlusJakartaSans',
              primaryColor: Colors.blue.shade200,
              textTheme: TextTheme(
                titleSmall: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: state.currentProfile?.textSize ?? 12),
                titleMedium: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: (state.currentProfile?.textSize ?? 14) + 2),
              ),
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
