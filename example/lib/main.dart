import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:load_future/load_future.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const title = 'Load Future Example';

  @override
  Widget build(BuildContext context) => LoadBuilder(
        builder: (context, child, isLoading) => DialogBarrier(
          isLoading: isLoading,
          indicator: const CircularProgressIndicator(),
          child: child,
        ),
        child: const MaterialApp(
          title: title,
          home: MyHomePage(title: title),
        ),
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        // body: _MyHomeBody(),
        body: LoadBuilder(
          builder: (context, child, isLoading) => DialogBarrier(
            isLoading: isLoading,
            indicator: const CircularProgressIndicator(),
            child: child,
          ),
          child: _MyHomeBody(),
        ),
      );
}

class _MyHomeBody extends StatefulWidget {
  @override
  State<_MyHomeBody> createState() => _MyHomeBodyState();
}

class _MyHomeBodyState extends State<_MyHomeBody> {
  final _loadButton = GlobalKey<LoadState>();
  final _defaultDuration = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.load(Future.delayed(_defaultDuration));
    });
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Load'),
              onPressed: () => context.load(
                Future.delayed(_defaultDuration),
              ),
            ),
            ElevatedButton(
              child: const Text('Load root'),
              onPressed: () => context.loadRoot(
                Future.delayed(_defaultDuration),
              ),
            ),
            ElevatedButton(
              child: const Text('With result'),
              onPressed: () => context
                  .load(Future.delayed(
                    _defaultDuration,
                    () => 'result',
                  ))
                  .then(
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
              onPressed: () => context
                  .load(
                    Future.delayed(const Duration(seconds: 10))
                        .timeout(_defaultDuration),
                  )
                  .catchError(
                    (e, _) => context.mounted
                        ? showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: Text(e.toString()),
                            ),
                          )
                        : null,
                  ),
            ),
            ElevatedButton(
              onPressed: () => _loadButton.currentState?.load(
                Future.delayed(_defaultDuration),
              ),
              child: LoadBuilder(
                key: _loadButton,
                builder: (context, child, isLoading) => isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      )
                    : child,
                child: const Text('Button load'),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const MyHomePage(title: 'Inner Page'),
                ),
              ),
              child: const Text('Navigate to Inner'),
            ),
          ].expand((e) => [e, const SizedBox(height: 16)]).toList(),
        ),
      );
}
