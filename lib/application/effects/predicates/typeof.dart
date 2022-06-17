void Function(dynamic event) when<T>(void Function(T event) callback) {
  return (event) {
    if (event is T) {
      callback(event);
    }
  };
}
