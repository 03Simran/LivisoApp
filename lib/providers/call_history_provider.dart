import 'package:flutter/material.dart';
import 'package:liviso_flutter/models/call_history.dart';

class CallHistoryProvider extends ChangeNotifier {
  List<CallHistoryData>? _callHistoryData;

  List<CallHistoryData>? get callHistoryData => _callHistoryData;

  void updateCallHistory(List<CallHistoryData> newData) {
    _callHistoryData = newData;
    notifyListeners();
  }
}
