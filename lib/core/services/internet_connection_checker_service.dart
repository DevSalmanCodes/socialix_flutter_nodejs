import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionCheckerService {
  final InternetConnectionChecker connectionChecker;
  static bool isConnected = true;
  InternetConnectionCheckerService(this.connectionChecker) {
    init();
  }
  void init() {
    connectionChecker.onStatusChange.listen((InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        isConnected = true;
      } else if (status == InternetConnectionStatus.disconnected) {
        isConnected = false;
      }
    });
  }
}
