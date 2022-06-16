import 'dart:io';

class UserCreationRequested {
  final File? avatar;
  final String name;

  const UserCreationRequested({
    required this.avatar,
    required this.name,
  });
}
