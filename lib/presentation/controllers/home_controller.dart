import 'package:get/get.dart';
import 'package:pmproject/domain/usecases/marbl_text_only_usecase.dart';

import '../../data/repositories/marbl_talk_repository_impl.dart';

class HomeController extends GetxController{
  MarblTextOnlyUseCase textOnlyUseCase = MarblTextOnlyUseCase(MarblTalkRepositoryImpl());

}