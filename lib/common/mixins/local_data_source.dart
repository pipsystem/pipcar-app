import '../exception/cache_exception.dart';

mixin LocalDataSource {
  T call<T>(
    T Function() call,
    String message,
  ) {
    try {
      final response = call();
      return response;
    } on IndexError catch (_) {
      throw CacheException('index error');
    } catch (e) {
      throw CacheException(message);
    }
  }
}
