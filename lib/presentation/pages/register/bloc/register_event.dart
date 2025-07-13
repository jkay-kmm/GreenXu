import '../../../../domain/entities/register/register_entity.dart';

abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final RegisterEntity entity;
  RegisterSubmitted(this.entity);
}
