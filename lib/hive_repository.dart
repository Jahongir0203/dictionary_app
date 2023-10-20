import 'package:hive/hive.dart';

class HiveRepository {
  Box _box = Hive.box('dictionary');



  saveWordEng(List<String> wordEng) {
    _box.put('WordEng', wordEng);
  }

  List<String> getWordEng() {
    return _box.get('WordEng', defaultValue: ['']);
  }
  saveWordUz(List<String> wordUz) {
    _box.put('WordUz', wordUz);
  }


  List<String> getWordUz() {
    return _box.get('WordUz', defaultValue: ['']);
  }
}
