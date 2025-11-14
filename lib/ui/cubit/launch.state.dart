import 'package:spacexapp/data/model/launch.model.dart';
import 'package:spacexapp/ui/cubit/cubit.state.dart';

typedef LaunchState = CubitState<LaunchStateData>;

class LaunchStateData {
  const LaunchStateData({
    required this.launches,
    this.likedLaunches = const <Launch>[],
  });

  final List<Launch> launches;
  final List<Launch> likedLaunches;
}
