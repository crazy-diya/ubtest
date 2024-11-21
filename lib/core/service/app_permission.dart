import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionManager {
  static requestCameraPermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.camera.request().isGranted) {
      onGranted();
    }
  }

  // static requestExternalStoragePermission(
  //     BuildContext context, VoidCallback onGranted) async {
  //   final permissionValidator = EasyPermissionValidator(
  //       context: context,
  //       appName: "UnionBankMobile",
  //       //customDialog: AppPermissionDialog()
  //   );
  //   final result = await permissionValidator.storage();
  //   if (result) onGranted();
  // }

  static requestExternalStoragePermission(
      BuildContext context, VoidCallback onGranted) async {
    if (Platform.isIOS) {
      if (await Permission.storage.request().isGranted) {
        onGranted();
      }
    } else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 33) {
        onGranted();
      }else{
        if (await Permission.storage.request().isGranted) {
          onGranted();
        }
      }
    }


  }

  // static requestManageStoragePermission(
  //     BuildContext context, VoidCallback onGranted) async {
  //   if (await Permission.manageExternalStorage.request().isGranted) {
  //     onGranted();
  //   }
  // }

  static requestLocationPermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.location.request().isGranted) {
      onGranted();
    }
  }

  static requestNotificationPermission(BuildContext context, VoidCallback onGranted) async {
      if (await Permission.notification.request().isGranted) {
        onGranted();
      } 
      if(await Permission.notification.request().isDenied){
        await Permission.notification.request();
      }
  }

  static requestGalleryPermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.mediaLibrary.request().isGranted) {
      onGranted();
    }
  }

  static requestContactPermission(
      BuildContext context, VoidCallback onGranted) async {
    if (await Permission.contacts.request().isGranted) {
      onGranted();
    }
  }

  static requestReadPhoneStatePermission(
      BuildContext context, VoidCallback onGranted) async {
    if (Platform.isIOS) {
      onGranted();
    } else if (await Permission.phone.request().isGranted) {
      onGranted();
    }
  }
}
