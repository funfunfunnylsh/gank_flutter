import 'package:flutter/material.dart';
import 'package:gank_flutter/common/constant/strings.dart';
import 'package:gank_flutter/ui/page/page_category_list.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(
        length: AppStrings.GANK_ALL_CATEGORY_KEYS.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: AppStrings.GANK_ALL_CATEGORY_KEYS
                .map((String title) => Tab(text: title))
                .toList()),
        Divider(),
        Expanded(
          child: TabBarView(
              controller: _controller,
              children: AppStrings.GANK_ALL_CATEGORY_KEYS
                  .map((String title) => GankListCategory(title))
                  .toList()),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
