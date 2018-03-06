import 'package:flutter/material.dart';

void main() => runApp(new PageApp());

class PageApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = new PageController();
  double _currentPage = 0.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Page Demo'),
      ),
      body: new LayoutBuilder(builder: (context, container) =>
      new NotificationListener(
        child: new PageView.custom(
          childrenDelegate: new SliverChildBuilderDelegate((context,
              index) =>
          new _SimplePage(
            '$index',
            parallaxOffset: container.maxWidth / 2.0 * (index - _currentPage),
          ),
            childCount: 5,
          ),
          controller: _pageController,
        ),
        onNotification: (ScrollNotification notify) {
          setState(() {
            _currentPage = _pageController.page;
          });
        },
      )),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _SimplePage extends StatelessWidget {
  _SimplePage(this.data, {
    Key key,
    this.parallaxOffset = 0.0
  }) :super(key: key);

  final String data;
  final double parallaxOffset;

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            data,
            style: new TextStyle(fontSize: 60.0),
          ),
          new SizedBox(height: 40.0),
          new Transform(
            transform: new Matrix4.translationValues(
                parallaxOffset, 0.0, 0.0
            ),
            child: new Text('Yet another line of text'),
          ),
        ],
      ),
    );
  }
}
