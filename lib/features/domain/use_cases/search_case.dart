import 'package:rj/features/data/models/products_model.dart';
import 'package:rj/features/data/repository/search_repository.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../utils/dependencyLocation.dart';
import '../../../utils/text_controllers.dart';
import '../../data/repository/explore_repo.dart';

class SearchCase{
  static bool speechEnabled = false;

  static SpeechToText speechToText =  SpeechToText();
  static Future<List<ProductsModel>> getFilteredList(String letter) async {
    final productList = await locator<ExploreRepo>().getAllProducts();
    return productList.where((model)=>model.itemName.toLowerCase().contains(letter)).toList();
  }

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
  }
  void startListening() async {
    final result = await speechToText.listen(onResult: onSpeechResult);
    print("result $result");
  }

  void stopListening() async {
    await speechToText.stop();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
      searchAppBarController.text = result.recognizedWords;
  }

}