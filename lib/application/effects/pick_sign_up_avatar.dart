import 'dart:io';

import 'package:antenna/antenna.dart';
import 'package:image_picker/image_picker.dart';
import 'package:madeit/application/effects/predicates/typeof.dart';
import 'package:madeit/application/events/sign_up_avatar_found.dart';
import 'package:madeit/application/events/sign_up_avatar_requested.dart';

final pickSignUpAvatarEffect = when<SignUpAvatarRequested>((event) async {
  final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (image == null) {
    return;
  }

  final file = File(image.path);

  dispatch(SignUpAvatarFound(file));
});
