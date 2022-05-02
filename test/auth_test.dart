import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import "package:test/test.dart";

void main() {
  // grouping relevant tests together
  group("Mock Authentication", () {
    final provider = MockAuthProvider();
    // test #1
    test("Should not be init at beginning", () {
      expect(provider.isIntialized, false);
    });
    // test #2: exception handling case
    test("cannot log out if not init", () {
      expect(provider.logOut(),
          throwsA(const TypeMatcher<NotIntializedException>()));
    });

    test("Should be able to init", () async {
      await provider.intialize();
      expect(provider.isIntialized, true);
    });

    test("user = null", () {
      expect(provider.currentUser, null);
    });
    // testing performance by taken time
    test("init < 2 secs", () async {
      await provider.intialize();
      expect(provider.isIntialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test("Create user should delegeate to logIn function", () async {
      final badEmailUser =
          provider.createUser(email: "foo@bar.com", password: "anypassword");
      expect(badEmailUser,
          throwsA(const TypeMatcher<UserNotFoundAuthException>()));

      final badPasswordUser =
          provider.createUser(email: "foot@bar.com", password: "foobar");
      expect(badPasswordUser,
          throwsA(const TypeMatcher<WrongPasswordAuthException>()));

      final user = await provider.createUser(email: "foo", password: "bar");

      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
    test("logged user can verfiy himself", () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test("logged in can log out", () async {
      await provider.intialize();
      await provider.login(email: "email", password: "password");
      await provider.logOut();
      await provider.login(email: "email", password: "password");

      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotIntializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isIntialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isIntialized) throw NotIntializedException();
    await Future.delayed(const Duration(seconds: 1));
    return login(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> intialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<void> logOut() async {
    if (!isIntialized) throw NotIntializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!isIntialized) throw NotIntializedException();
    if (email == "foo@bar.com") throw UserNotFoundAuthException();
    if (password == "foobar") throw WrongPasswordAuthException();
    const user =
        AuthUser(isEmailVerified: false, email: "foo@bar", id: "chick");
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isIntialized) throw NotIntializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser =
        AuthUser(isEmailVerified: true, email: "foo@bar.com", id: "meow");
    _user = newUser;
  }

  @override
  Future<void> sendPasswordReset({required String toEmail}) {
    throw UnimplementedError();
  }
}
