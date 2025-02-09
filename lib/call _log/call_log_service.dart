import 'package:permission_handler/permission_handler.dart';
import 'package:call_e_log/call_log.dart';
import 'package:provider/provider.dart';
import 'package:sales_app/provider/user_provider.dart';

class CallLogService {
  final userprovider = UserProvider();
  Future<bool> requestCallLogPermission() async {
    PermissionStatus status = await Permission.phone.request();
    return status.isGranted;
  }

  Future<String?> fetchUserPhoneNumber(context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUser();
    return userProvider.currentUser?.phone;
  }

  Future<List<Map<String, dynamic>>> fetchFilteredLogs(context) async {
    if (await requestCallLogPermission()) {
      print('Call log permission Granted');

      String? userPhoneNumber = await fetchUserPhoneNumber(context);
      if (userPhoneNumber == null) {
        print('Api data error');
        return [];
      }
      Iterable<CallLogEntry> entries = await CallLog.get();

      return entries
          .where((entry) => entry.number == userPhoneNumber)
          .map((entry) => {
                "name": entry.name ?? "Unknown",
                "number": entry.number ?? "No Number",
                "CallType": entry.callType,
                "timestamp":
                    DateTime.fromMillisecondsSinceEpoch(entry.timestamp!),
                "duration": entry.duration ?? 0,
              })
          .toList();
    } else {
      print('Permission Denied');
      return [];
    }
  }
}
