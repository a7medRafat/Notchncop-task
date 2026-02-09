// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:daftor/main.dart';

// class ConnectivityHandler {
//   static final Connectivity _connectivity = Connectivity();
//   static StreamSubscription<List<ConnectivityResult>>? _subscription;
//   static bool _isOffline = false;

//   static void startMonitoring() {
//     _subscription ??= _connectivity.onConnectivityChanged.listen((results) {
//       final hasConnection = results.any((r) => r != ConnectivityResult.none);

//       if (!hasConnection && !_isOffline) {
//         _isOffline = true;
//         navigatorKey.currentState?.push(
//           MaterialPageRoute(
//             fullscreenDialog: true,
//             builder: (_) => const NoInternetScreen(),
//           ),
//         );
//       } else if (hasConnection && _isOffline) {
//         _isOffline = false;
//         navigatorKey.currentState?.maybePop();
//       }
//     });
//   }

//   static void dispose() {
//     _subscription?.cancel();
//     _subscription = null;
//   }
// }
