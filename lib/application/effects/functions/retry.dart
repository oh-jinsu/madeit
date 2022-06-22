Future<T> Function() retry<T>(Future<T> Function() fn) {
  return () async {
    try {
      final result = await fn();

      return result;
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 1000));

      return retry(fn)();
    }
  };
}
