interface class DataLoading {}

interface class DataEmpty {}

abstract interface class DataError {
  String get errorMessage;
}

abstract interface class DataLoaded<T> {
  T get data;
}

abstract interface class DataUpdated {}
