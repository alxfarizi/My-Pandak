import '../data/models/keluarga.dart';
import '../data/repos/keluarga_repository.dart';

class KeluargaController {
  final KeluargaRepository _repo = KeluargaRepository();

  Future<List<Keluarga>> loadKeluarga() async {
    return await _repo.getAll();
  }

  Future<int> addKeluarga(Keluarga keluarga) async {
    return await _repo.insert(keluarga);
  }

  Future<int> updateKeluarga(Keluarga keluarga) async {
    return await _repo.update(keluarga);
  }

  Future<int> deleteKeluarga(int id) async {
    return await _repo.delete(id);
  }
}
