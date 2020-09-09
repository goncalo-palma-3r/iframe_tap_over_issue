import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(alignment: Alignment.center, children: [
              WebViewYoutube(
                width: MediaQuery.of(context).size.width * 0.8,
                id: "42",
                youtubeUrl: "https://www.youtube.com/embed/j3JAx9wf9Hw",
              ),
              MaterialButton(
                color: Colors.red,
                child: Text(
                  "Press me",
                ),
                onPressed: () => print(
                  "This is a thing",
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}

class WebViewYoutube extends StatefulWidget {
  final String youtubeUrl;
  final double width;
  final String id;

  WebViewYoutube(
      {@required this.youtubeUrl, @required this.width, @required this.id});

  @override
  _WebViewYoutubeState createState() => _WebViewYoutubeState();
}

class _WebViewYoutubeState extends State<WebViewYoutube> {
  Widget iframeWidget;
  final IFrameElement iframeElement = new IFrameElement();

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _initializeState() {
    iframeElement.src = widget.youtubeUrl;
    iframeElement.width = '16';
    iframeElement.height = '9';
    iframeElement.style.border = 'none';
    iframeElement.allowFullscreen = true;

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      widget.id,
      (int viewId) => iframeElement,
    );

    iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: widget.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.width * 9 / 16,
        child: iframeWidget);
  }
}
