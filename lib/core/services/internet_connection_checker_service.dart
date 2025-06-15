import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionCheckerService {
  final InternetConnectionChecker connectionChecker;
  bool _isConnected = true;
  bool get isConnected => _isConnected;
  InternetConnectionCheckerService(this.connectionChecker) {
    init();
  }
  void init() {
    connectionChecker.onStatusChange.listen((InternetConnectionStatus status) {
      if (status == InternetConnectionStatus.connected) {
        _isConnected = true;
      } else if (status == InternetConnectionStatus.disconnected) {
        _isConnected = false;
      }
    });
  }
}
