import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:geolocator/geolocator.dart';
import 'package:huawei_location/huawei_location.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../core/configurations/app_config.dart';
import '../features/data/datasources/local_data_source.dart';
import 'app_constants.dart';
import 'app_extensions.dart';
import 'model/device_info.dart';

class DeviceData {
  final DeviceInfoPlugin? deviceInfo;
  final LocalDataSource? sharedData;
  final PackageInfo? packageInfo;

  DeviceData({this.deviceInfo, this.sharedData, this.packageInfo});

  Future<DeviceInfoRequest?> getDeviceData() async {
    DeviceInfoRequest? deviceData;

   if (Platform.isAndroid) {
      if (AppConfig.deviceOS == DeviceOS.HUAWEI) {
        deviceData = await _readHuaweiBuildData( await deviceInfo!.androidInfo, await _determinePositionHuawei());
      } else {
        deviceData = await _readAndroidBuildData( await deviceInfo!.androidInfo, await _determinePosition());
      }
    } else if (Platform.isIOS) {
      deviceData = await _readIosDeviceInfo(await deviceInfo!.iosInfo, await _determinePosition());
    }
    return deviceData;
  }

  Future<DeviceInfoRequest> _readHuaweiBuildData(AndroidDeviceInfo build, Location position) async {
    final deviceID = await FlutterUdid.consistentUdid;
    final ip = await getPublicIp();
    final pushID = await sharedData?.getPushToken()??"-";
    final dd = Dd(
        deviceId: deviceID,
        deviceModel: build.model,
        deviceName: Platform.isAndroid ? build.model : build.product,
        osName: "ANDROID",
        osVersion: Platform.isAndroid ? build.version.release : build.version.baseOS,
        platform:  'huawei',
        latitude: position.latitude.toString(),
        locale: "en_US",
        ip: ip,
        timeZone: "Eastern Standard Time",
        screenResolution: '${ScreenUtil().screenWidth.toStringAsFixed(0)}x${ScreenUtil().screenHeight.toStringAsFixed(0)}',
        longitude: position.longitude.toString(),
        pushId: pushID,
        channelType: kChannelType,
        deviceBrand: build.brand);

    return DeviceInfoRequest(dv: packageInfo!.version, dd: dd);
  }

  Future<DeviceInfoRequest> _readAndroidBuildData(AndroidDeviceInfo build, Position position) async {
    final deviceID = await FlutterUdid.consistentUdid;
    final ip = await getPublicIp();
    final pushID = await sharedData?.getPushToken()??"-";
    final dd = Dd(
        deviceId: deviceID,
        deviceModel: build.model,
        deviceName: Platform.isAndroid ? build.model : build.product,
        osName: Platform.isAndroid ? AppConfig.deviceOS.getValue() : build.version.codename,
        osVersion: Platform.isAndroid ? build.version.release : build.version.baseOS,
        platform:  'android',
        latitude: position.latitude.toString(),
        locale: "en_US",
        ip: ip,
        timeZone: "Eastern Standard Time",
        screenResolution: '${ScreenUtil().screenWidth.toStringAsFixed(0)}x${ScreenUtil().screenHeight.toStringAsFixed(0)}',
        longitude: position.longitude.toString(),
        pushId: pushID,
        channelType: kChannelType,
        deviceBrand: build.brand);

    return DeviceInfoRequest(dv: packageInfo!.version, dd: dd);
  }

  Future<DeviceInfoRequest> _readIosDeviceInfo(IosDeviceInfo data, Position position) async {
    final deviceID = await FlutterUdid.consistentUdid;
    final ip = await getPublicIp();
    final pushID = await sharedData?.getPushToken()??"-";

    final dd = Dd(
        deviceId: deviceID,
        deviceModel: data.model,
        deviceName: data.name,
        osName: data.systemName,
        osVersion: data.systemVersion,
        platform: "ios",
        latitude: position.latitude.toStringAsFixed(2),
        locale: "en_US",
        ip: ip,
        timeZone: "Eastern Standard Time",
        screenResolution: '${ScreenUtil().screenWidth.toStringAsFixed(0)}x${ScreenUtil().screenHeight.toStringAsFixed(0)}',
        longitude: position.longitude.toStringAsFixed(2),
        pushId: pushID,
        channelType: kChannelType,
        deviceBrand: "Apple");

    return DeviceInfoRequest(
      dv: packageInfo!.version,
      dd: dd,
    );
  }

  Future<String?> getPublicIp() async {
    String? ip;
    for (var interface in await NetworkInterface.list()) {
      for (var address in interface.addresses) {
        if (address.type == InternetAddressType.IPv4) {
          ip = address.address;
        }
      }
    }
    return ip ?? "";
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Position(
          latitude: 0.0,
          longitude: 0.0,
          heading: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 1.00,
          headingAccuracy: 1.00);
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Position(
            latitude: 0.0,
            longitude: 0.0,
            heading: 0,
            timestamp: DateTime.now(),
            accuracy: 0,
            altitude: 0,
            speed: 0,
            speedAccuracy: 0,
            altitudeAccuracy: 1.00,
            headingAccuracy: 1.00);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Position(
          latitude: 0.0,
          longitude: 0.0,
          heading: 0,
          timestamp: DateTime.now(),
          accuracy: 0,
          altitude: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 1.00,
          headingAccuracy: 1.00);
    }

   final lastKnownPosition = await Geolocator.getLastKnownPosition();
    if(lastKnownPosition==null){
      return  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    }else{
      return lastKnownPosition;
    }
  }
  
  Future<Location> _determinePositionHuawei() async {
    bool serviceEnabled;
    PermissionStatus permission;

    serviceEnabled = await Permission.location.serviceStatus.isEnabled;

    if (!serviceEnabled) {
      return Location(
        latitude: 0.0,
        longitude: 0.0,
        altitude: 0,
        speed: 0,
      );
    }

    permission = await Permission.location.status;

    if (permission == PermissionStatus.denied) {
      // permission = await Permission.location.request();
      if (permission == PermissionStatus.denied) {
        return Location(
          latitude: 0.0,
          longitude: 0.0,
          altitude: 0,
          speed: 0,
        );
      }
    }

    if (permission == PermissionStatus.permanentlyDenied) {
      return Location(
        latitude: 0.0,
        longitude: 0.0,
        altitude: 0,
        speed: 0,
      );
    }
    
    final FusedLocationProviderClient locationService =
        FusedLocationProviderClient()..initFusedLocationService();
    
    final LocationRequest locationRequest = LocationRequest();

    LocationSettingsRequest locationSettingsRequest = LocationSettingsRequest(
      requests: <LocationRequest>[locationRequest],
      needBle: true,
      alwaysShow: true,
    );
    try {
     await locationService.checkLocationSettings(locationSettingsRequest);
    } catch (e) {
    }

    try {
      final lastLocation = await locationService.getLastLocation();
      if ((lastLocation.latitude == null) ||( lastLocation.latitude == "null") || (lastLocation.latitude == "")) {
        return Location(
          latitude: 0.0,
          longitude: 0.0,
          altitude: 0,
          speed: 0,
        );
      } else {
        return lastLocation;
      }
    } catch (e) {
      await locationService.requestLocationUpdates(locationRequest);
      final lastLocation = await locationService.getLastLocation();
      if ((lastLocation.latitude == null) ||( lastLocation.latitude == "null") || (lastLocation.latitude == "")) {
        return Location(
          latitude: 0.0,
          longitude: 0.0,
          altitude: 0,
          speed: 0,
        );
      } else {
        return lastLocation;
      }
    }
  }
}
