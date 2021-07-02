import 'app_configuration.dart';

class LogoutUtils {
  Future<void> onLogout() async {
    await AppConfiguration().setUserIsLoggedOut();
  }
}
