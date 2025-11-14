import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/rocket.service.dart';
import '../../../data/model/rocket/rocket.model.dart';

class RocketListState {
  final bool loading;
  final List<Rocket> rockets;
  final String? error;

  const RocketListState({
    this.loading = false,
    this.rockets = const [],
    this.error,
  });

  RocketListState copyWith({
    bool? loading,
    List<Rocket>? rockets,
    String? error,
  }) {
    return RocketListState(
      loading: loading ?? this.loading,
      rockets: rockets ?? this.rockets,
      error: error,
    );
  }
}

class RocketListCubit extends Cubit<RocketListState> {
  final RocketService _service;

  RocketListCubit({RocketService? service})
    : _service = service ?? RocketService(),
      super(const RocketListState(loading: true));

  Future<void> fetchRockets() async {
    try {
      emit(state.copyWith(loading: true));
      final rockets = await _service.fetchAllRockets();
      emit(state.copyWith(loading: false, rockets: rockets));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }
}
