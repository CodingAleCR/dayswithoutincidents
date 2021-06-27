import 'package:uuid/uuid.dart';

abstract class CrudService<T> {
  Future<List<T>> findAll();
  Future<T> findById(Uuid id);
  Future<T> save(T model);
  Future<void> deleteById(Uuid id);
}
