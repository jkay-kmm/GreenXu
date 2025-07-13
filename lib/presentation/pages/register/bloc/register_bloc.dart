import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/repositories/register_repository.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository repository;

  RegisterBloc(this.repository) : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());
      try {
        final result = await repository.register(event.entity);
        if (result) {
          emit(RegisterSuccess());
        } else {
          emit(RegisterFailure('Đăng ký thất bại'));
        }
      } catch (e) {
        print('❌ Lỗi khi gọi API đăng ký: $e');
        emit(RegisterFailure(e.toString()));
      }
    });
  }
}
