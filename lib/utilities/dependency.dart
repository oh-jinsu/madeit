final Map<String, dynamic> _manifest = {};

void single<T>(T instance) {
  final key = T.toString();

  _manifest[key] = instance;
}

void factory<T>(T Function() constructor) {
  final key = T.toString();

  _manifest[key] = constructor;
}

T inject<T>() {
  final key = T.toString();

  final result = _manifest[key];

  assert(result != null, "$T is not found");

  if (result is Function) {
    return result() as T;
  }

  return result as T;
}
