// login exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {
  @override
  String toString() {
    // TODO: implement toString
    return "Wrong password! - muhab";
  }
}

// register exception

class WeakPasswordAuthException implements Exception {}

class EmailalreadyUsedAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// generic exceptions

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}
