import 'package:flutter/material.dart';
import 'package:union_bank_mobile/core/configurations/app_config.dart';
import 'package:union_bank_mobile/features/presentation/views/map/google_map_locator.dart';
import 'package:union_bank_mobile/features/presentation/views/map/huawei_map_locator.dart';
import 'package:union_bank_mobile/utils/enums.dart';

class MapLocator extends StatefulWidget {
  const MapLocator({super.key});

  @override
  State<MapLocator> createState() => _MapLocatorState();
}

class _MapLocatorState extends State<MapLocator> {
  @override
  Widget build(BuildContext context) {
    return AppConfig.deviceOS == DeviceOS.HUAWEI
        ? const HuaweiMapLocator()
        : const GoogleMapLocator();
  }
}

  