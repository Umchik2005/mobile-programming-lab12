import 'package:flutter_test/flutter_test.dart';
import 'package:testing_debugging_flutter_lab/src/auth_service.dart';

class SuccessAuth implements AuthService {
  @override
  Future<bool> signIn(String email, String password) async => true;
}

class FailAuth implements AuthService {
  @override
  Future<bool> signIn(String email, String password) async => false;
}

void main() {
  test('AuthRepository handles success', () async {
    final repo = AuthRepository(SuccessAuth());
    final ok = await repo.signIn('a@b.com', 'password');
    expect(ok, isTrue);
  });

  test('AuthRepository handles failure', () async {
    final repo = AuthRepository(FailAuth());
    final ok = await repo.signIn('a@b.com', 'bad');
    expect(ok, isFalse);
  });
}
