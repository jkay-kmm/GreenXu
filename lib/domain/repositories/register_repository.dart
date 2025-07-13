

import '../entities/register/register_entity.dart';

abstract class RegisterRepository {
  Future<bool> register(RegisterEntity entity);
}
