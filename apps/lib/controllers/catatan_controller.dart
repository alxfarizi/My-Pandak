import '../data/models/catatan.dart';
import '../data/repos/catatan_repository.dart';

class CatatanController {
  final CatatanRepository _repo = CatatanRepository();

  Future<List<Catatan>> loadCatatan() async {
    return await _repo.getAll();
  }

  Future<int> addCatatan(Catatan catatan) async {
    return await _repo.insert(catatan);
  }

  Future<int> updateCatatan(Catatan catatan) async {
    return await _repo.update(catatan);
  }

  Future<int> deleteCatatan(int id) async {
    return await _repo.delete(id);
  }
}
