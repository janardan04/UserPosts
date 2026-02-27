class UiState<T> {}

class Initial<T> extends UiState<T> {}

class Loading<T> extends UiState<T> {}

class Success<T> extends UiState<T> {
  T? data;

  Success(this.data);
}

class Failure<T> extends UiState<T> {
  String? errorMsg;

  Failure(this.errorMsg);
}
