import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/rocket.service.dart';
import '../../../data/model/rocket/rocket.model.dart';

class RocketState {
  final bool loading;
  final Rocket? rocket;
  final String? error;

  RocketState({this.loading = false, this.rocket, this.error});
}

class RocketCubit extends Cubit<RocketState> {
  final Map<String, Rocket> _cache = {};

  RocketCubit() : super(RocketState(loading: true));

  Future<void> fetchRocket(String rocketId) async {
    if (_cache.containsKey(rocketId)) {
      emit(RocketState(loading: false, rocket: _cache[rocketId]));
      return;
    }

    try {
      emit(RocketState(loading: true));
      final rocket = await RocketService().fetchRocket(rocketId);
      _cache[rocketId] = rocket;
      emit(RocketState(loading: false, rocket: rocket));
    } catch (e) {
      emit(RocketState(loading: false, error: e.toString()));
    }
  }
}
