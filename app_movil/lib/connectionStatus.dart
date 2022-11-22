import 'package:connectivity/connectivity.dart';
import 'dart:io';
import 'dart:async';


class ConnectionStatusSingleton {

  static final ConnectionStatusSingleton _singleton = ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _singleton;

  int hasConnection = 0;

  StreamController connectionChangeController = StreamController.broadcast();

  final Connectivity _connectivity =Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  // Because this is meant to exist through the entire application life cycle this isn't
  // really an issue
  void dispose() {
    connectionChangeController.close();
  }
  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }
  //The test to actually see if there is a connection
  Future checkConnection() async {
    int previousConnection = hasConnection;
    try {
      final result =await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        try{
          final result = await InternetAddress.lookup('www.edamam.com');
          if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
            hasConnection = 0; //CONNECTION OK
          }
        } on SocketException catch(_) {
          hasConnection = 1; //SERVER
        }
      }
    } on SocketException catch(_) {
      hasConnection = 2; //RED
    }
    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }
}