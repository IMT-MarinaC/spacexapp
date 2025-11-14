import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacexapp/data/api/launch.service.dart';
import 'package:spacexapp/ui/cubit/cubit.state.dart';
import 'package:spacexapp/ui/cubit/launch.state.dart';

import '../../data/model/launch.model.dart';

class LaunchCubit extends Cubit<LaunchState> {
  LaunchCubit() : super(const InitialState<LaunchStateData>());

  void getLaunches() async {
    try {
      emit(const LoadingState<LaunchStateData>());
      final List<Launch> launches = await LaunchService.getAll();
      emit(
        SuccessState<LaunchStateData>(
          data: LaunchStateData(launches: launches),
        ),
      );
    } on Exception catch (e) {
      emit(FailureState<LaunchStateData>(message: e.toString()));
    }
  }

  void like(Launch launch) {
    if (state is! SuccessState) return;
    final SuccessState<LaunchStateData> launchData =
        state as SuccessState<LaunchStateData>;

    final List<Launch> likedLaunches = <Launch>[
      ...launchData.data.likedLaunches,
    ];

    final int launchIndex = likedLaunches.indexWhere(
      (Launch currentLaunch) => currentLaunch.id == launch.id,
    );

    if (launchIndex == -1) {
      likedLaunches.add(launch);
    } else {
      likedLaunches.removeAt(launchIndex);
    }

    emit(
      SuccessState<LaunchStateData>(
        data: LaunchStateData(
          launches: launchData.data.launches,
          likedLaunches: likedLaunches,
        ),
      ),
    );
  }
}
