class StringManipulator {
  static String firstStringCharacterFromEachWord(String sentence) {
    List<String> words = sentence.split(" ");
    String result = "";

    for (int i = 0; i < words.length; i++) {
      //Get first word
      if (RegExp(r'[a-zA-Z]').hasMatch(words[i][0])) {
        result += words[i][0];
        result += "";
      }

      //Give Space
      // if (i != words.length - 1) {
      //   result += " ";
      // }
    }

    return result;
  }
}
