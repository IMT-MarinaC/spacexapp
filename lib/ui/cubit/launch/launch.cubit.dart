import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/launch.service.dart';
import '../../../data/model/launch.model.dart';

class LaunchState {
  final bool loading;
  final List<Launch> launches;
  final String? error;
  final String? filteredRocketId;

  const LaunchState({
    this.loading = false,
    this.launches = const [],
    this.error,
    this.filteredRocketId,
  });

  LaunchState copyWith({
    bool? loading,
    List<Launch>? launches,
    String? error,
    String? filteredRocketId,
  }) {
    return LaunchState(
      loading: loading ?? this.loading,
      launches: launches ?? this.launches,
      error: error,
      filteredRocketId: filteredRocketId,
    );
  }
}

class LaunchCubit extends Cubit<LaunchState> {
  LaunchCubit() : super(const LaunchState(loading: true)) {
    fetchLaunches();
  }

  Future<void> fetchLaunches() async {
    try {
      emit(state.copyWith(loading: true));
      final launches = await getAll();
      emit(state.copyWith(loading: false, launches: launches));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void filterByRocket(String rocketId) {
    emit(state.copyWith(filteredRocketId: rocketId));
  }

  void clearFilter() {
    emit(state.copyWith(filteredRocketId: null));
  }

  List<Launch> get filteredLaunches {
    if (state.filteredRocketId == null) return state.launches;
    return state.launches
        .where((launch) => launch.rocket == state.filteredRocketId)
        .toList();
  }
}
