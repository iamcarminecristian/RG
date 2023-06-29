import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const App());
  Timer(Duration(seconds: 120), () {
    SystemNavigator.pop();
  });
}

class App extends StatelessWidget {
  final double milliseconds = 8.33;

  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Holder(milliseconds: milliseconds),
              Holder(milliseconds: milliseconds * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class Holder extends StatelessWidget {
  final double milliseconds;

  const Holder({Key? key, required this.milliseconds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Counter(milliseconds: milliseconds),
        Counter(milliseconds: milliseconds),
        Counter(milliseconds: milliseconds),
      ],
    );
  }
}

class Counter extends StatefulWidget {
  final double milliseconds;

  const Counter({Key? key, required this.milliseconds}) : super(key: key);

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int counter = 0;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Text("$counter");
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: widget.milliseconds.toInt()), (Timer t) {
      setState(() {
        counter += 1;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
