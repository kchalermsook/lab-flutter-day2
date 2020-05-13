import 'package:flutter/material.dart';


class TabsScreen extends StatefulWidget {
  static const routeName = '/tab-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    var args  = ModalRoute.of(context).settings.arguments;
    print("args");
    print(args);
    return DefaultTabController(
      length: 2,
      // initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tab Bar'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(
                  Icons.category,
                ),
                text: 'Test1',
              ),
              Tab(
                icon: Icon(
                  Icons.star,
                ),
                text: 'Test2',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
             Text('Test1'),
             Text('Test2'),
          ],
        ),
      ),
    );
  }
}
