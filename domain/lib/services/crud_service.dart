abstract class CrudService<T> {
  Future<List<T>> findAll();
  Future<T> findById(String uuid);
  Future<T> save(T model);
  Future<void> deleteById(String uuid);
}
