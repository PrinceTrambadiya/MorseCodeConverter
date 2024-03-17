import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:morse_code_converter/utils/consts.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void resetState() {
    emit(HomeInitial());
  }

  void convertToEnglish(String morseCode) {
    if (morseCode.isNotEmpty) {
      if (!isValidString(morseCode)) {
        List<String> words = morseCode.split(RegExp('\\s{3}'));
        String englishText = '';
        String tempText = '';

        for (String word in words) {
          List<String> letters = word.split(' ');
          for (String letter in letters) {
            tempText += Consts.morseToEnglishMap[letter] ?? '';
          }
          tempText = tempText[0].toUpperCase() + tempText.substring(1);
          englishText += '$tempText ';
          tempText = '';
        }
        emit(HomeConvertState(convertedString: englishText.trim()));
      } else {
        emit(HomeFailureState(message: 'Invalid input'));
      }
    } else {
      emit(HomeErrorState(errorString: 'Please Enter some value'));
    }
  }

  void convertToMorse(String englishText) {
    if (englishText.isNotEmpty) {
      if (isValidString(englishText)) {
        List<String> words = englishText.toLowerCase().split('');
        String morseCode = '';

        for (String word in words) {
          morseCode += '${Consts.englishToMorseMap[word]} ';
        }
        emit(HomeConvertState(convertedString: morseCode.trim()));
      } else {
        emit(HomeFailureState(message: 'Invalid input'));
      }
    } else {
      emit(HomeErrorState(errorString: 'Please Enter some value'));
    }
  }

  bool isValidString(String text) {
    RegExp morsePattern = RegExp(r'^[a-zA-Z0-9\s]*$');
    return morsePattern.hasMatch(text);
  }
}
