import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gank_flutter/api/api_gank.dart';
import 'package:gank_flutter/common/model/gank_item.dart';
import 'package:gank_flutter/ui/widget/widget_list_item.dart';

class SearchPage extends StatefulWidget {
  static const String ROUTER_NAME = 'search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List _searchResults;
  String _search;
  bool _searching = false;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Directionality(
            textDirection: Directionality.of(context),
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
              decoration: InputDecoration(
                hintText: '输入搜索内容...',
                hintStyle: TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
              autofocus: false,
              onSubmitted: (String search) async {
                _search = search;
                _searchData();
              },
            )),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                _searchData();
              })
        ]);
  }

  @override
  void initState() {
    super.initState();
  }

  void _searchData() async {
    if (_search == null || _search.isEmpty) {
      Fluttertoast.showToast(
          msg: '搜索中...',
          backgroundColor: Colors.black,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
      return;
    }
    setState(() {
      _searching = true;
    });
    var result = await GankApi.searchData(_search);
    result = result.map<GankItem>((json) => GankItem.fromJson(json)).toList();
    setState(() {
      _searchResults = result;
      if (_searchResults.length <= 0) {
        Fluttertoast.showToast(
            msg: '未搜索到内容...',
            backgroundColor: Colors.black,
            gravity: ToastGravity.CENTER,
            textColor: Colors.white);
      }
      _searching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: _searching,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GankListItem(_searchResults[index]);
              },
              itemCount: _searchResults == null ? 0 : _searchResults.length,
            ),
          ),
          Offstage(
            offstage: !_searching,
            child: Center(child: CupertinoActivityIndicator()),
          )
        ],
      ),
    );
  }
}
