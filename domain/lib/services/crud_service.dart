import 'package:uuid/uuid.dart';

abstract class CrudService<T> {
  Future<List<T>> findAll();
  Future<T> findById(UuidValue id);
  Future<T> save(T model);
  Future<void> deleteById(UuidValue id);
}
