class UserRepository {
  Future<String> authenticate({
    required String phoneNumber,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'token';
  }

  Future<void> deleteToken() async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    await Future.delayed(const Duration(seconds: 1));
    return false;
  }
}
