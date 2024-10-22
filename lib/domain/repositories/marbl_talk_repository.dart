import 'package:dartz/dartz.dart';

abstract class MarblTalkRepository {
  Future<Either<String, String>> onTextOnly(String text);

  Future<Either<String, String>> onTextAndImage(String text, String base64);
}