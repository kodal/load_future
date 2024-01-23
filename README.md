Load Future with dialog progress bar

## Preview

![The preview app running in macOS](https://github.com/kodal/load_future/raw/master/screen_records/record_1.gif?raw=true)

## Features

- Load Future
- Customize loader
- Without context
- return Future

## Getting started

### Add dependency

```yaml
load_future: ^0.1.0
```

### Wrap App or any Widget with LoadBuilder

Wrap `MaterialApp` or any `Widget` with `LoadBuilder` where you want to show loading.

```dart
LoadBuilder(
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
```

## Usage

### Wrap your `Future<T>` with `Future<T> context.load(Future<T> future)`

```dart
Future<Response> longTask() async {
  ...;
}

onTap: () => context.load(longTask())
            .then((response) => ...) // work with success result
            .catchError((e, s) => ...) // work with error
```

## Warning

`load` can be called only with BuildContext.

Dialog is not dismissible.  You should cancel wrapped Future by own. Example: 
`load(future.timeout(duration))`
