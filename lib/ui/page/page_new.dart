import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/api/api_gank.dart';
import 'package:gank_flutter/common/model/gank_item.dart';
import 'package:gank_flutter/common/model/gank_post.dart';
import 'package:gank_flutter/ui/page/page_gallery.dart';
import 'package:gank_flutter/ui/widget/widget_list_item.dart';
import 'package:gank_flutter/ui/widget/widget_list_title.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../widget/widget_loading.dart';
import '../widget/indicator_factory.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController;
  bool _isLoading = true;

  String _date;
  List<GankItem> _gankItems;
  String _girlImage;

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
    getNewData(date: _date);
  }

  Future _onRefresh(bool up) async {
    if (up) {
      await getNewData(date: _date, isRefresh: true);
      _refreshController.sendBack(true, RefreshStatus.completed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///content view
        Offstage(
          offstage: _isLoading ,
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            onOffsetChange: null,
            headerBuilder: buildDefaultHeader,
            controller: _refreshController,
            child: _buildListView(),
          ),
        ),
        ///loading view
        Offstage(
          offstage: !_isLoading ,
          child: Center(child: LoadingDialog()),
        )
      ],
    );
  }

  ListView _buildListView() {
    return ListView.builder(
        itemCount: _gankItems == null ? 0 : _gankItems.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) {
            return _buildImageBanner(context);
          } else {
            GankItem gankItem = _gankItems[i - 1];
            return gankItem.isTitle
                ? GankItemTitle(gankItem.category)
                : GankListItem(gankItem);
          }
        });
  }

  GestureDetector _buildImageBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return GalleryPage([_girlImage], '');
          }));
      },
      child: CachedNetworkImage(
        height: 200,
        imageUrl: _girlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Future getNewData({String date, bool isRefresh = false}) async {
    _date = date;
    if (!isRefresh) {
      setState(() {
        _isLoading = true;
      });
    }
    var todayJson;
    if (date == null) {
      ///获取最新
      todayJson = await GankApi.getTodayData();
    } else {
      ///获取历史某一天
      todayJson = await GankApi.getSpecialDayData(_date);
    }
    var todayItem = GankPost.fromJson(todayJson);
    setState(() {
      _gankItems = todayItem.gankItems;
      _girlImage = todayItem.girlImage;
      _isLoading = false;
    });
  }

  @override
  bool get wantKeepAlive => true;
}
