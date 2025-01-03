import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:project_bloc/core/core.dart';


extension NetworkAwareFunctionExtension on Function {
  Future<void> checkConncetion() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      await this();
    } else {
      "No internet connection".errorToast();
    }
  }

  Future<void> delayedOf({Duration? duration, int seconds = 3}) async {
    await Future.delayed(duration ?? Duration(seconds: seconds));
    await this();
  }
}
