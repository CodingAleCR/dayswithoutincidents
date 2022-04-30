/// Base behavior of a service that allows creating, reading, updating or
/// deleting a Model
abstract class CrudService<Model> {
  /// Finds all models stored.
  Future<List<Model>> findAll();

  /// Finds a model by a given uuid.
  Future<Model> findById(String uuid);

  /// Creates or updates a model.
  Future<Model> save(Model model);

  /// Deletes a model that has a given uuid.
  Future<void> deleteById(String uuid);
}
