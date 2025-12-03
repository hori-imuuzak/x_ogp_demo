import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ogp_data.dart';
import '../repositories/ogp_repository.dart';

final ogpRepositoryProvider = Provider((ref) => OgpRepository());

final ogpProvider =
    StateNotifierProvider<OgpNotifier, AsyncValue<OgpData?>>((ref) {
  return OgpNotifier(ref.read(ogpRepositoryProvider));
});

class OgpNotifier extends StateNotifier<AsyncValue<OgpData?>> {
  final OgpRepository _repository;

  OgpNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> fetchOgp(String url) async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.fetchOgp(url);
      state = AsyncValue.data(data);
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
