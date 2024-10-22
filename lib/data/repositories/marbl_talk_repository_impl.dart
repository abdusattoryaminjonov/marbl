import 'package:dartz/dartz.dart';
import 'package:pmproject/domain/repositories/marbl_talk_repository.dart';

import '../datasources/remote/http_service.dart';

class MarblTalkRepositoryImpl extends MarblTalkRepository {
  @override
  Future<Either<String, String>> onTextOnly(String text) async {
    try {
      var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextOnly(text));
      var geminiTalk = Network.parseMarblTalk(response!);
      var result = geminiTalk.candidates[0].content.parts[0].text;
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> onTextAndImage(
      String text, String base64) async {
    try {
      var response = await Network.POST(Network.API_GEMINI_TALK, Network.paramsTextAndImage(text, base64));
      var geminiTalk = Network.parseMarblTalk(response!);
      var result = geminiTalk.candidates[0].content.parts[0].text;
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
}