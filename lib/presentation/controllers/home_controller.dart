import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:pmproject/core/services/log_service.dart';
import 'package:pmproject/data/datasources/local/nosql_service.dart';
import 'package:pmproject/data/models/message_model.dart';
import 'package:pmproject/domain/usecases/marbl_text_and_image_usecase.dart';
import 'package:pmproject/domain/usecases/marbl_text_only_usecase.dart';
import 'package:pmproject/presentation/widgets/generic_dialog.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../core/services/utils_service.dart';
import '../../data/repositories/marbl_talk_repository_impl.dart';
import '../pages/intranet_page.dart';
import '../pages/starter_page.dart';

class HomeController extends GetxController{
  MarblTextOnlyUseCase textOnlyUseCase =
  MarblTextOnlyUseCase(MarblTalkRepositoryImpl());
  MarblTextAndImageUseCase textAndImageUseCase =
  MarblTextAndImageUseCase(MarblTalkRepositoryImpl());

  TextEditingController textController = TextEditingController();
  final FocusNode textFieldFocusNode = FocusNode();

  String? pickedImage;

  List<MessageModel> messages = [];
  SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  FlutterTts flutterTts = FlutterTts();

  bool isLoading = false;
  bool isSpeaking = false;

  void toggleSpeakingState() {
    isSpeaking = !isSpeaking;
    update();
  }

  logOutDialog(BuildContext context) async{
    bool result = await showGenericDialog(
      context: context,
      title: 'Sign Out',
      content: "Do you want to sign out?",
      optionsBuilder: () =>{
        'Cancel':false,
        'Confirm':true,
      }
    );
    LogService.i("Log Out Auth");

    // if(result){
    //   await AuthService.signOutFromGoogle();
    //   callStarterPage(context);
    // }
  }
  callStarterPage(BuildContext context) {
    Get.offNamed(StarterPage.id);
    // Navigator.pushReplacementNamed(context, StarterPage.id);
  }


  uploadData(){
    var data = NoSqlService.fetchNoSqlCard();
    messages = data;
    update();
  }

  apiTextOnly(String text) async{
    var either = await textOnlyUseCase.call(text);
    either.fold((l) {
      LogService.d(l);
      updateMessages(MessageModel(isMine: false,message: l),false);
    }, (r) async{
      LogService.d(r);
      updateMessages(MessageModel(isMine: false,message: r),false);
    });
  }

  apiTextAndImage(String text, String base64) async {
    var either = await textAndImageUseCase.call(text, base64);
    either.fold((l) {
      LogService.d(l);
      updateMessages(MessageModel(isMine: false, message: l),false);
    }, (r) async {
      LogService.d(r);
      updateMessages(MessageModel(isMine: false, message: r),false);
    });
  }

  updateMessages(MessageModel messageModel,bool isLoading) {
    this.isLoading = isLoading;
    messages.add(messageModel);
    update();

    NoSqlService.saveNoSqlDB(messageModel);
  }

  onSendPressed(String text) async {
    if (pickedImage == null) {
      apiTextOnly(text);
      updateMessages(MessageModel(isMine: true, message: text),true);
    } else {
      apiTextAndImage(text, pickedImage!);
      updateMessages(
          MessageModel(isMine: true, message: text, base64: pickedImage),true);
    }
    textController.clear();
    onRemovedImage();
  }

  Future gotoIntranetPage(String url ,BuildContext context) async{
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return  IntranetPage(url: url,);
        },
      ),
    );
  }

  onSelectedImage() async {
    var base64 = await Utils.pickAndConvertImage();
    if (base64.trim().isNotEmpty) {
      pickedImage = base64;
      LogService.i(base64);
      update();
    }
  }

  onRemovedImage() {
    pickedImage = null;
    update();
  }


  /// Speech to Text
  void initSTT() async {
    await flutterTts.setLanguage("en-US");
    speechEnabled = await speechToText.initialize();
    update();
  }

  void startSTT() async {
    await speechToText.listen(onResult: onSTTResult);
    update();
  }

  void stopSTT() async {
    await speechToText.stop();
    update();
  }

  void onSTTResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      var words = result.recognizedWords;
      onSendPressed(words);
      LogService.i(words);
    }
  }

  Future speakTTS(String text) async{
    var result = await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future<void> pauseTTS() async {
    await flutterTts.pause();
    isSpeaking = false;
  }

  Future stopTTS() async{
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }
}