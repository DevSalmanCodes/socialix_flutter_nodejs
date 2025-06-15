abstract class UserEvent {}

class GetUserDetailsEvent extends UserEvent {
  final String userId;

  GetUserDetailsEvent(this.userId);
  
}
