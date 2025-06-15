import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialix_flutter_nodejs/features/user/domain/usecases/get_current_user_details.dart';
import 'package:socialix_flutter_nodejs/features/user/presentation/blocs/user_event.dart';
import 'package:socialix_flutter_nodejs/features/user/presentation/blocs/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserDetails getCurrentUserDetails;
  UserBloc({required this.getCurrentUserDetails}) : super(UserInitialState()) {
    on<GetUserDetailsEvent>(_onGetCurrentUserDetails);
  }

  void _onGetCurrentUserDetails(
    GetUserDetailsEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    final res = await getCurrentUserDetails(event.userId);
    res.fold(
      (l) => emit(UserErrorState(l.message)),
      (r) => emit(UserSuccessState(r)),
    );
  }
}
