import 'package:flutter/material.dart';
import '../common/constant/colors.dart';
import '../common/constant/locale/locale_base.dart';
//import '../common/localization/gank_localizations.dart';
//import 'package:flutter_gank/common/manager/app_manager.dart';
//import 'package:flutter_gank/ui/widget/widget_expand_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonUtils {
//  static StringBase getLocale(BuildContext context) {
//    return GankLocalizations.of(context).currentLocalized;
//  }

  static List<Color> getThemeListColor() {
    return [
      AppColors.PRIMARY_DEFAULT_COLOR, //默认色
      AppColors.PRIMARY_HTH_COLOR, //海棠红
      AppColors.PRIMARY_YWL_COLOR, //鸢尾蓝
      AppColors.PRIMARY_KQL_COLOR, //孔雀绿
      AppColors.PRIMARY_NMH_COLOR, //柠檬黄
      AppColors.PRIMARY_TLZ_COLOR, //藤萝紫
      AppColors.PRIMARY_MYH_COLOR, //暮云灰
      AppColors.PRIMARY_XKQ_COLOR, //虾壳青
      AppColors.PRIMARY_MDF_COLOR, //牡丹粉
      AppColors.PRIMARY_XPZ_COLOR, //筍皮棕
    ];
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.black,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white);
  }
}
