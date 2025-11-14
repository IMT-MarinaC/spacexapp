import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/launch.service.dart';
import '../../../data/model/launch.model.dart';

class LaunchState {
  final bool loading;
  final List<Launch> launches;
  final String? error;

  LaunchState({this.loading = false, this.launches = const [], this.error});
}

class LaunchCubit extends Cubit<LaunchState> {
  LaunchCubit() : super(LaunchState(loading: true)) {
    fetchLaunches();
  }

  Future<void> fetchLaunches() async {
    try {
      emit(LaunchState(loading: true));
      final launches = await getAll();
      emit(LaunchState(loading: false, launches: launches));
    } catch (e) {
      emit(LaunchState(loading: false, error: e.toString()));
    }
  }
}
