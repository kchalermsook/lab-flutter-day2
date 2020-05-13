import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'screens/user_transaction.dart';
import 'screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => MyHomePage(title: 'Flutter Demo Home Page'),
        UserTransactionsScreen.routeName: (ctx) => UserTransactionsScreen(),
        TabsScreen.routeName: (ctx) => TabsScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with TickerProviderStateMixin{


  int _counter = 0;
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation =
        Tween(begin: 0.0, end: 180).animate(_arrowAnimationController);
  }  

  void _incrementCounter() {
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });
  }
  void navigateToInside(BuildContext context) {
    Navigator.of(context).pushNamed(
      UserTransactionsScreen.routeName,
      arguments: {
        'id': 'xx',
        'title': 'yy',
      },
    );
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', 123);
  }

  Future<int> getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int testval = prefs.getInt('intValue');
    print("test $testval");
    return testval;
    // return 1;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: SingleChildScrollView(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Image.network(
                'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
            FlatButton(
              child: Text("Test HTTP Post"),
              onPressed: () {
                const url =
                    'https://flutterlab-12292.firebaseio.com/movies.json';
                http.post(
                  url,
                  body: json.encode({
                    'title': 'test',
                    'description': 'desc',
                    'imageUrl': 'xx',
                    'price': '100',
                    'isFavorite': true,
                  }),
                );
              },
            ),
            FlatButton(
              child: Text("Test HTTP Get"),
              onPressed: () {
                http
                    .get('https://flutterlab-12292.firebaseio.com/movies.json')
                    .then((response) {
                  print(response.body);
                });
              },
            ),
            FlatButton(
              child: Text("Tab bar"),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  TabsScreen.routeName,
                  arguments: {
                    'id': 'xx',
                    'title': 'yy',
                  },
                );
              },
            ),
            FlatButton(
              child: Text("Save Share Pref"),
              onPressed: () {
                addIntToSF();
              },
            ),
            FlatButton(
              child: Text("Get Share Pref"),
              onPressed: () {
                getIntValuesSF().then((value) => print('return val $value'));
              },
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToInside(context);
        },
        tooltip: 'Increment',
        child: Text('Transaction'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
