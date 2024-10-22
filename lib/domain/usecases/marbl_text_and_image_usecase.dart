import 'package:dartz/dartz.dart';

import '../repositories/marbl_talk_repository.dart';

class MarblTextAndImageUseCase {
  final MarblTalkRepository repository;

  MarblTextAndImageUseCase(this.repository);

  Future<Either<String, String>> call(String text, String base64) async {
    return await repository.onTextAndImage(text, base64);
  }
}