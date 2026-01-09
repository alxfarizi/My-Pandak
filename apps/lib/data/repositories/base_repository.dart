//base_repository.dart
abstract class BaseRepository<T> {
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<T?> create(T entity);
  Future<T?> update(int id, T entity);
  Future<bool> delete(int id);
}
