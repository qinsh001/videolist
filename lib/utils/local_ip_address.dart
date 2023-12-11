import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:network_info_plus/network_info_plus.dart';

class LocalIPAddress {
  static Future<String> getIP() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.wifi) {
      try {
        final info = NetworkInfo();
        var wifiIp = await info.getWifiIP();
        if (wifiIp?.isNotEmpty == true && wifiIp != '0.0.0.0') {
          return wifiIp!;
        } else {
          return getLocalIPAddress();
        }
      } catch (e) {
        print(e);
        return getLocalIPAddress();
      }
    } else {
      return getLocalIPAddress();
    }
  }

  static bool isIPv4Address(String input) {
    final ipv4Pattern = RegExp(
        r"^((25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)\.){3}(25[0-5]|2[0-4]\d|1\d\d|[1-9]\d|\d)$");
    return ipv4Pattern.hasMatch(input);
  }

  static bool isIPv6Address(String address) {
    final ipv6Regex = RegExp(
      r'^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return ipv6Regex.hasMatch(address);
  }

  static Future<String> getLocalIPAddress() async {
    try {
      for (var interface in await NetworkInterface.list()) {
        for (var address in interface.addresses) {
          if (!address.isLoopback) {
            return address.address;
          }
        }
      }
    } catch (e) {
      print('error: $e');
    }
    return '127.0.0.1';
  }
}
