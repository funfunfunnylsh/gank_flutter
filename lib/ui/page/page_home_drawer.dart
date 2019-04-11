import 'package:flutter/material.dart';

class GankDrawer extends StatefulWidget {
  @override
  _GankDrawerState createState() => _GankDrawerState();
}

class _GankDrawerState extends State<GankDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("funfunfunny"),
            accountEmail: Text("funfunfunny@163.com"),
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.tag_faces,
                  color: Colors.white,
                ),
//                    child: Image.network(
//                        "http://img5.duitang.com/uploads/item/201512/18/20151218165511_AQW4B.jpeg"),
              ),
            ),
            decoration: BoxDecoration(color: Colors.red),
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            title: new Text("Test"),
            enabled: true,
            leading: new Icon(
              Icons.home,
              color: Colors.red,
            ),
            trailing: new Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            title: new Text("TestOne"),
            enabled: true,
            leading:
            new Icon(Icons.supervised_user_circle, color: Colors.red),
            trailing: new Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            title: new Text("TestTwo"),
            enabled: true,
            leading: new Icon(Icons.reorder, color: Colors.red),
            trailing: new Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
            title: new Text("TestThree"),
            enabled: true,
            leading: new Icon(Icons.settings),
            trailing: new Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
