import 'package:get_it/get_it.dart';

import 'package:klimbbtask/blocs/location/location_bloc.dart';

/// Packet injection dependency manager
/// If you need to access anything, anywhere in this project,
/// please create a singleton out of it.
/// to understand more about singletons please refer:
/// https://github.com/fluttercommunity/get_it

final GetIt serviceLocator = GetIt.instance;

/// this method is used to inject dependency
/// and create singletons that can be used throughout the app
///
Future<void> setupServiceLocator() async {
  /// for registering the blocs used in the app
  ///
  serviceLocator.registerLazySingleton(() => LocationBloc());
}
