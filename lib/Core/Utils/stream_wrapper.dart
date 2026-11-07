import 'dart:async';

class StreamWrapper<T> {
  final StreamController<T> _controller;
  T? _currentValue;

  /// Initializes the wrapper. Set [broadcast] to true if you need multiple listeners.
  StreamWrapper({T? initialValue, bool broadcast = false})
    : _currentValue = initialValue,
      _controller = broadcast
          ? StreamController<T>.broadcast()
          : StreamController<T>() {
    if (initialValue != null) {
      _controller.add(initialValue);
    }
  }

  /// Exposes the stream for listening to changes.
  Stream<T> get stream => _controller.stream;

  /// Synchronously retrieves the most recently emitted value.
  T? get value => _currentValue;

  /// Pushes a new value to the stream and updates the current state.
  void update(T newValue) {
    if (_controller.isClosed) return;
    _currentValue = newValue;
    _controller.sink.add(newValue);
  }

  /// Pushes an error to the stream.
  void addError(Object error, [StackTrace? stackTrace]) {
    if (_controller.isClosed) return;
    _controller.sink.addError(error, stackTrace);
  }

  /// Closes the stream to prevent memory leaks.
  /// Always call this inside your StatefulWidget's dispose() method.
  void dispose() {
    _controller.close();
  }
}
