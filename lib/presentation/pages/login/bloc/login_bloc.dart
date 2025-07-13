// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../register/bloc/login_event.dart';
// import 'login_state.dart';
// import '../../register/repository/auth_repository.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthRepository authRepo;
//
//   LoginBloc({required this.authRepo}) : super(LoginState.initial()) {
//     on<EmailChanged>((event, emit) {
//       emit(state.copyWith(email: event.email));
//     });
//
//     on<PasswordChanged>((event, emit) {
//       emit(state.copyWith(password: event.password));
//     });
//
//     on<LoginSubmitted>((event, emit) async {
//       emit(state.copyWith(isSubmitting: true, error: null));
//       try {
//         final success = await authRepo.login(state.email, state.password);
//         if (success) {
//           emit(state.copyWith(isSubmitting: false, isSuccess: true));
//         } else {
//           emit(state.copyWith(isSubmitting: false, error: 'Login failed'));
//         }
//       } catch (e) {
//         emit(state.copyWith(isSubmitting: false, error: e.toString()));
//       }
//     });
//   }
// }
