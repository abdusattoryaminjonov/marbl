import 'package:dartz/dartz.dart';

import '../repositories/marbl_talk_repository.dart';


class MarblTextOnlyUseCase {
  final MarblTalkRepository repository;

  MarblTextOnlyUseCase(this.repository);

  Future<Either<String, String>> call(String text) async {
    return await repository.onTextOnly(text);
  }


}