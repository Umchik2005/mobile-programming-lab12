abstract class AuthService {
  /// Attempts sign-in; returns true on success, false on failure.
  Future<bool> signIn(String email, String password);
}

/// Simple in-memory implementation for demo and tests.
class InMemoryAuthService implements AuthService {
  @override
  Future<bool> signIn(String email, String password) async {
    // Fake network latency
    await Future.delayed(const Duration(milliseconds: 200));
    // Very simple rule: any password 'password' succeeds
    return password == 'password' && email.contains('@');
  }
}

/// Example of how auth logic could be wrapped in a repository.
class AuthRepository {
  final AuthService service;
  AuthRepository(this.service);

  Future<bool> signIn(String email, String password) async {
    final ok = await service.signIn(email, password);
    if (!ok) return false;
    // e.g., save token, do additional work
    return true;
  }
}

// 5) Debugging Exercise: Null-safety issue example.
// Deliberate problematic code (commented):
/*
String? maybeNull() => null;
void crashExample() {
  // This will throw a runtime error if you force a `!` on null.
  final s = maybeNull()!; // BAD: could be null
  print(s.length);
}
*/

// Fixed version:
String? maybeNull() => null;
void safeExample() {
  final s = maybeNull() ?? 'default'; // provide default
  print(s.length);
}
