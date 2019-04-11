import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gank_flutter/redux/app_state.dart';

class AppManager {
  static EventBus eventBus = EventBus();

  static initApp(BuildContext context) async {

  }

  static notifyShowHistoryDateEvent() {

  }

  static ThemeData getThemeData(context) {
    return StoreProvider.of<AppState>(context).state.themeData;
  }

}
