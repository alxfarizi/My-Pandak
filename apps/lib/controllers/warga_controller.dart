import '../data/models/warga.dart';
import '../data/repos/warga_repository.dart';

class WargaController {
  final WargaRepository _repo = WargaRepository();

  Future<List<Warga>> loadWarga() async {
    return await _repo.getAll();
  }

  Future<int> addWarga(Warga warga) async {
    return await _repo.insert(warga);
  }

  Future<int> updateWarga(Warga warga) async {
    return await _repo.update(warga);
  }

  Future<int> deleteWarga(int id) async {
    return await _repo.delete(id);
  }
}
