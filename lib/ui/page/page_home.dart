import 'package:flutter/material.dart';
import 'package:gank_flutter/common/event/event_change_column.dart';
import 'package:gank_flutter/common/manager/app_manager.dart';
import 'package:gank_flutter/ui/page/page_history.dart';
import 'package:gank_flutter/ui/page/page_search.dart';
import 'page_home_drawer.dart';
import 'page_new.dart';
import 'page_category.dart';
import 'page_welfare.dart';
import 'page_favorite.dart';

class HomePage extends StatefulWidget {
  static const String ROUTER_NAME = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;
  PageController _pageController;
  String _currentDate = '最新干货';

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: GankDrawer(),
        appBar: AppBar(
          elevation: 1,
          centerTitle: true,
          title: Offstage(
            ///offstage:通过一个参数，来控制child是否显示
            offstage: _currentPageIndex != 0,
            ///标题栏显示当前日期
            child: Text(_currentDate ?? ''),
          ),
          actions: <Widget>[_buildActions()],
        ),
        body: Stack(
          children: <Widget>[
            PageView(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: _pageChange,
              controller: _pageController,
              children: <Widget>[
                NewPage(),
                CategoryPage(),
                WelfarePage(),
                FavoritePage()
              ],
            ),
//            HistoryDate(_historyData),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: 32,
            currentIndex: _currentPageIndex,
            onTap: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
              _pageController.jumpToPage(index);
            },
            items: <BottomNavigationBarItem>[
          ///最新
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 24),
            title: Text("最新"),
          ),

          ///分类
          BottomNavigationBarItem(
            icon: Icon(Icons.apps,size: 24),
            title:
            Text("分类"),
          ),

          ///妹纸
          BottomNavigationBarItem(
            icon: Icon(Icons.photo,size: 24),
            title: Text("福利"),
          ),

          ///收藏
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,size: 24),
            title:
            Text("收藏"),
          ),
        ]),
    );
  }

  ///创建标题栏右侧按钮
  IconButton _buildActions() {
    return IconButton(
      icon: Icon(getActionsIcon(), size: 22, color: Colors.white),
      onPressed: () async {
        if (_currentPageIndex == 0) {
          ///去历史干货
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HistoryPage()));
        } else if (_currentPageIndex == 1) {
          ///去搜索页
          Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => SearchPage()));
//          showSearch(context: context, delegate: SearchBarDelegate());

        } else if (_currentPageIndex == 2) {
          ///切换妹纸图列数按钮
          AppManager.eventBus.fire(ChangeWelfareColumnEvent());
        } else {
        }
      },
    );
  }

  ///获取标题栏右侧图标.
  IconData getActionsIcon() {
    if (_currentPageIndex == 0) {
      return Icons.calendar_today;
    } else if (_currentPageIndex == 1) {
      return Icons.search;
    } else if (_currentPageIndex == 2) {
      return Icons.compare_arrows;
    } else {
      return Icons.settings_backup_restore;
    }
  }

  ///页面切换回调
  void _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }
}


