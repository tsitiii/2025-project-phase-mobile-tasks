
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/user_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCurrentUser getCurrentUser;

  UserBloc({
    required this.getCurrentUser,
  }) : super(const UserInitial()) {
    on<GetCurrentUserEvent>(_onGetCurrentUser);
  }

  void _onGetCurrentUser(GetCurrentUserEvent event, Emitter<UserState> emit) async {
    print('UserBloc: GetCurrentUserEvent received');
    emit(const UserLoading());

    final result = await getCurrentUser();

    result.fold(
      (failure) {
        print('UserBloc: Failure - ${failure.message}');
        emit(UserError(message: failure.message));
      },
      (user) {
        print('UserBloc: Success - ${user.name}, ${user.email}');
        emit(UserLoaded(user: user));
      },
    );
  }
}