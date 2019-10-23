import 'package:flutter/cupertino.dart';

class BoxProvider extends ChangeNotifier {
  int _index = 0;

  void setIndex(int index) {
    if (_index != index) {
      _index = index;
      debugPrint('通知刷新');
      notifyListeners();
    }
  }

  int index () {
    return _index;
  }

  void changeIndex() {
    debugPrint('改变');
    setIndex(_index+1);
  }
}