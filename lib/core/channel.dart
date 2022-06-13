import 'package:rxdart/subjects.dart';

final _channel = PublishSubject();

final listen = _channel.listen;

void dispatch(dynamic event) => _channel.sink.add(event);
