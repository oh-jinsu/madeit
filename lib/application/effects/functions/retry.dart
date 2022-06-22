import 'package:madeit/implementation/providers/http_client/response.dart';

Future<T> Function() retry<T>(Future<T> Function() fn) {
  return () async {
    try {
      final result = await fn();

      if (result is FailureResponse) {
        if (result.code == 103) {
          await Future.delayed(const Duration(milliseconds: 1000));

          return retry(fn)();
        }
      }

      return result;
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 1000));

      return retry(fn)();
    }
  };
}
