Load Future with dialog progress bar

## Preview

![The preview app running in macOS](https://github.com/kodal/load_future/raw/master/screenshot_records/record_1.gif?raw=true)

## Features

- Load Future
- Customize loader
- Without context
- return Future

## Getting started

### Add dependency

```yaml
load_future: ^latest
```

### Wrap XApp with LoadWidget

Wrap `MaterialApp` or `CupertinoApp` with `LoadWidget` and use common `navigatorKey`.

```dart
final navigatorKey = GlobalKey<NavigatorState>();

LoadWidget(
  navigatorKey: navigatorKey,
  ...
  child: MaterialApp(
    navigatorKey: navigatorKey,
    ...
    ),
);
```

## Usage

### Wrap your `Future<T>` with `Future<T> load(Future<T> future)`

```dart
Future<Response> longTask() async {
  ...;
}

onTap: () => load(longTask())
            .then((response) => ...) // work with success result
            .catchError((e, s) => ...) // work with error
```

## Warning

Dialog is not dismissible.  You should cancel wrapped Future by own. Example: 
`load(future.timeout(duration))`

## Feature plans:

- [ ] Load Stream Builder from Future
