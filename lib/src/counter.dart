import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:js/js.dart' as js;
import 'package:js/js_util.dart' as js_util;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

@js.JSExport()
class _MyHomePageState extends State<MyHomePage> {
  final _streamController = StreamController<void>.broadcast();
  @override
  void initState() {
    super.initState();
    final export = js_util.createDartExport(this);
    js_util.setProperty(js_util.globalThis, '_appState', export);
    js_util.callMethod<void>(js_util.globalThis, '_stateSet', []);
  }

  int _counter = 0;
  String _value = "google.com";
  bool _isShowNavigation = true;

  @js.JSExport()
  int get deger => _counter;

  @js.JSExport()
  bool get isShowNavigation => _isShowNavigation;

  @js.JSExport()
  String get navigationText =>
      isShowNavigation ? 'Hide navigation' : 'Show navigation';

  @js.JSExport()
  void addHandler(void Function() handler) {
    _streamController.stream.listen((_) => handler());
  }

  @js.JSExport()
  void increment() {
    _counter++;
    _streamController.add(null);
    setState(() {});
  }

  @js.JSExport()
  void decrement() {
    _counter--;
    _streamController.add(null);
    setState(() {});
  }

  @js.JSExport()
  void setValue(String value) {
    _value = value;
    _streamController.add(null);
    setState(() {});
  }

  @js.JSExport()
  void setNavigationVisibility(bool value) {
    _isShowNavigation = value;
    _streamController.add(null);
    setState(() {});
  }

  _launchUrl() {
    var host = Uri(scheme: 'https', host: _value);
    window.open(
      host.toString(),
      'flutter ankara',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: increment,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: decrement,
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            if (_isShowNavigation)
              FloatingActionButton.extended(
                  onPressed: _launchUrl, label: Text("Navigate To $_value")),
          ],
        ),
      ),
    );
  }
}
