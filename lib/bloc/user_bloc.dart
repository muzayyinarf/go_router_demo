import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router_demo/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserSignedOut()) {
    on<SignIn>((event, emit) async {
      if (state is UserSignedOut) {
        String? token =
            Services.getToken(email: event.email, password: event.password);

        if (token != null) {
          User? user =
              Services.getUser(email: event.email, token: event.password);
          if (user != null) {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString('email', event.email);
            pref.setString('token', token);

            emit(UserSignedIn(user));
          }
        }
      }
    });
    on<SignOut>((event, emit) async {
      if (state is UserSignedIn) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.remove('email');
        pref.remove('token');
      }
      emit(UserSignedOut());
    });
    on<CheckSignInStatus>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = pref.getString('email');
      String? token = pref.getString('token');

      if (email != null && token != null) {
        bool tokenIsValid = Services.isTokenValid(token);

        if (tokenIsValid) {
          User? user = Services.getUser(email: email, token: token);

          if (user != null) {
            emit(UserSignedIn(user));
          }
        }
      }
    });
  }
}
