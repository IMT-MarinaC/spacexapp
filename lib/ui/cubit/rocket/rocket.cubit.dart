import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/rocket.service.dart';
import '../../../data/model/rocket/rocket.model.dart';

class RocketState {
  final bool loading;
  final Rocket? rocket;
  final String? error;

  const RocketState({this.loading = false, this.rocket, this.error});

  RocketState copyWith({bool? loading, Rocket? rocket, String? error}) {
    return RocketState(
      loading: loading ?? this.loading,
      rocket: rocket ?? this.rocket,
      error: error,
    );
  }
}

class RocketCubit extends Cubit<RocketState> {
  final RocketService _service;
  final Map<String, Rocket> _cache = {};

  RocketCubit({RocketService? service})
    : _service = service ?? RocketService(),
      super(const RocketState(loading: true));

  Future<void> fetchRocket(String rocketId) async {
    if (_cache.containsKey(rocketId)) {
      emit(RocketState(loading: false, rocket: _cache[rocketId]));
      return;
    }

    try {
      emit(const RocketState(loading: true));
      final rocket = await _service.fetchRocket(rocketId);
      _cache[rocketId] = rocket;
      emit(RocketState(loading: false, rocket: rocket));
    } catch (e) {
      emit(RocketState(loading: false, error: e.toString()));
    }
  }
}
