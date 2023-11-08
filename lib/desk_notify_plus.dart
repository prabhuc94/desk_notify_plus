library desk_notify_plus;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

class Notification {
  Notification._() {
    _windowsNotification = WindowsNotification(applicationId: "appname");
    if (Platform.isLinux || Platform.isMacOS) {
      localNotifier.setup(appName: (_appName ?? "appname"), shortcutPolicy: ShortcutPolicy.ignore);
    }
  }

  late WindowsNotification _windowsNotification;

  String? _appName;


  set appName(String value) {
    _appName = value;
    _windowsNotification = WindowsNotification(applicationId: _appName);
  }

  static final Notification instance = Notification._();

  dynamic show({required String title, required String message, String? subTitle, Map<String, dynamic>? payload, List<LocalNotificationAction>? actions}) async {
    if (Platform.isWindows) {
      await _windowsNotification.showNotificationPluginTemplate(
          NotificationMessage.fromPluginTemplate(PageStorageKey(DateTime
              .now()
              .millisecondsSinceEpoch
              .toString()).value, title, message, payload: payload ?? {}));
    } else if (Platform.isMacOS || Platform.isLinux) {
      var notificaion = LocalNotification(title: title, subtitle: (subTitle ?? ""), body: (message ?? ""), identifier: (title ?? (message ?? "")), actions: actions, silent: false);
      notificaion.show();
      return notificaion;
    }
  }

}

final notification = Notification.instance;
