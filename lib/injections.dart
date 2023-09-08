import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injections {
  final getIt = GetIt.instance;

  void setupDependencyInjection()  {
    getIt.registerSingletonAsync<SharedPreferences>(() async {

      return await SharedPreferences.getInstance();
    });

  }

}