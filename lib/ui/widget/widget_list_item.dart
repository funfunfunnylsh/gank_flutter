import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gank_flutter/common/model/gank_item.dart';
import 'package:gank_flutter/ui/page/page_web_view.dart';
import 'package:gank_flutter/utils/time_utils.dart';

class GankListItem extends StatefulWidget {
  final GankItem gankItem;

  GankListItem(this.gankItem);

  @override
  _GankListItemState createState() => _GankListItemState();
}

class _GankListItemState extends State<GankListItem> {
  @override
  Widget build(BuildContext context) {
    return  _buildGankListItem(context);
  }

  ///build gank list item.
  Widget _buildGankListItem(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebViewPage(widget.gankItem);
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 16, left: 16, right: 16),
            child: Text(
              widget.gankItem.desc,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, bottom: 5,right: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                    size: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0,right: 32),
                    child: SizedBox(
                        width: 75,
                        child: Text(
                          widget.gankItem.who,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Icon(
                    Icons.access_time,
                    color: Theme.of(context).primaryColor,
                    size: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      formatDateStr(widget.gankItem.publishedAt),
                    ),
                  )
                ]),
          ),
          Divider(),
        ],
      ),
    );
  }
}
