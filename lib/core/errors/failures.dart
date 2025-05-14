abstract class Failure {}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({this.message = 'Server Failure'});
}
class CacheFailure extends Failure {
  final String message;
  CacheFailure({this.message = 'Cache Failure'});
}