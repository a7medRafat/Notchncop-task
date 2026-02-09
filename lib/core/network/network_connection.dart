import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnection {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResults =
        await _connectivity.checkConnectivity();

    /// Check if any of the connections are wifi or mobile
    return connectivityResults.contains(ConnectivityResult.wifi) ||
        connectivityResults.contains(ConnectivityResult.mobile);
  }
}
