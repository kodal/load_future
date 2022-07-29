import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:load_future/load_future.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static const title = 'Load Future Example';

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return LoadWidget(
      navigatorKey: navigatorKey,
      child: MaterialApp(
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        home: const MyHomePage(title: title),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Default 3s'),
                onPressed: () =>
                    load(Future.delayed(const Duration(seconds: 3))),
              ),
              ElevatedButton(
                child: const Text('With result'),
                onPressed: () => load<String>(Future.delayed(
                  const Duration(seconds: 2),
                  () => 'result',
                )).then(
                  (value) => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Success'),
                      content: Text(value),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                child: const Text('With error'),
                onPressed: () => load(
                  Future.delayed(const Duration(seconds: 10))
                      .timeout(const Duration(seconds: 3)),
                ).catchError(
                  (e, _) => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(e.toString()),
                    ),
                  ),
                ),
              ),
            ].expand((e) => [e, const SizedBox(height: 16)]).toList(),
            ),
      ),
    );
  }
}

