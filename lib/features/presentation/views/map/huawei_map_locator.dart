import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:huawei_map/huawei_map.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

import 'package:union_bank_mobile/features/domain/entities/response/locator_entity.dart';
import 'package:union_bank_mobile/features/presentation/views/map/widgets/location_marker_card.dart';

import 'package:union_bank_mobile/features/presentation/widgets/appbar.dart';
import 'package:union_bank_mobile/features/presentation/widgets/sliding_segmented_bar.dart';

import 'package:union_bank_mobile/utils/app_localizations.dart';
import 'package:union_bank_mobile/utils/bitmap_sizer.dart';
import 'package:union_bank_mobile/utils/enums.dart';

import '../../../../core/service/app_permission.dart';
import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_assets.dart';

import '../../../../utils/app_sizer.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/locator_bloc/locator_bloc.dart';
import '../../bloc/locator_bloc/locator_event.dart';
import '../../bloc/locator_bloc/locator_state.dart';
import '../../widgets/pop_scope/ub_pop_scope.dart';
import '../../widgets/toast_widget/toast_widget.dart';
import '../base_view.dart';

class HuaweiMapLocator extends BaseView {
  static const CameraPosition _sriLankaMap = CameraPosition(
    target: LatLng(8.2, 80.75),
    zoom: 7.6,
  );

  const HuaweiMapLocator({super.key});

  @override
  _HuaweiMapLocatorState createState() => _HuaweiMapLocatorState();
}

class _HuaweiMapLocatorState extends BaseViewState<HuaweiMapLocator> {
  final LocatorBloc _bloc = injection<LocatorBloc>();
  final List<LocatorEntity> branchData = [];
  final List<LocatorEntity> atmData = [];
  final List<LocatorEntity> cdmData = [];
  List<LocatorEntity> allData = [];
  final TextEditingController _controller = TextEditingController();
  bool viewList = false;
  bool isCardShowing = false;
  LocatorEntity? _selectedMarker;

  HuaweiMapController? mapController;
  List<LocatorEntity> searchedList = [];
  List<LocatorEntity> searchedAtmList = [];
  List<LocatorEntity> searchedCdmList = [];
  List<LocatorEntity> searchedBranchList = [];
  BitmapDescriptor? customIconB;
  BitmapDescriptor? customIconR;
  int current = 0;
  final Completer<HuaweiMapController> _mapController = Completer();

  createMarkers() async {
    customIconB = BitmapDescriptor.fromBytes(
      await getBytesFromAsset(AppAssets.locationMarker, 60.w),
    );

    customIconR = BitmapDescriptor.fromBytes(
        await getBytesFromAsset(AppAssets.locationMarkerSelected, 60.w));
  }

  @override
  void initState() {
    super.initState();
    HuaweiMapInitializer.initializeMap();
    createMarkers();
    _bloc.add(GetLocatorEvent(locatorEntity: LocatorEntity()));
    AppPermissionManager.requestLocationPermission(context, () {
      _determinePosition();
    });
  }

  void initialMapSize() {}

  @override
  Widget buildView(BuildContext context) {
    return UBPopScope(
      onPopInvoked: () async {
        if (isCardShowing == true) {
          setState(() {
            isCardShowing = false;
          });
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          // arguments: widget.isFromPreLogin ? true : false);
        }
        return false;
      },
      child: Scaffold(
        appBar: UBAppBar(
          onBackPressed: () {
            if (isCardShowing == true) {
              setState(() {
                isCardShowing = false;
              });
            } else {
              Navigator.pop(context);
            }
          },
          title: AppLocalizations.of(context).translate("locator"),
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            });
          },
          child: BlocProvider<LocatorBloc>(
            create: (_) => _bloc,
            child: BlocListener<LocatorBloc, BaseState<LocatorState>>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is GetLocatorLoadedState) {
                  branchData.clear();
                  branchData.addAll(state.branchData!.map(
                    (e) => LocatorEntity(
                        merchantName: e.name,
                        landMark: e.landMark,
                        startTime: e.startTime,
                        endTime: e.endTime,
                        startDayOfWeek: e.startDayOfWeek,
                        endDayOfWeek: e.endDayOfWeek,
                        locationCategory: e.locationCategory,
                        status: getStatus(
                          e.startDayOfWeek.toString(),
                          e.endDayOfWeek.toString(),
                          e.startTime!,
                          e.endTime!,
                        )
                            ? "Open "
                            : "Temporary Close ",
                        email: e.email,
                        address: e.address,
                        latitude: e.latitude.toString(),
                        longitude: e.longitude.toString(),
                        services: e.services,
                        telNumber: e.contactNo,
                        city: e.city),
                  ));
                   if (branchData.isNotEmpty) {
                    branchData.sort((a, b) =>
                        a.merchantName!.compareTo(b.merchantName ?? ""));
                  }
                  searchedBranchList = branchData;

                  atmData.clear();
                  atmData.addAll(state.atmData!.map(
                    (e) => LocatorEntity(
                        merchantName: e.name,
                        landMark: e.landMark,
                        locationCategory: e.locationCategory,
                        status: getStatus(
                          e.startDayOfWeek.toString(),
                          e.endDayOfWeek.toString(),
                          e.startTime!,
                          e.endTime!,
                        )
                            ? "Open "
                            : "Temporary Close ",
                        startDayOfWeek: e.startDayOfWeek,
                        endDayOfWeek: e.endDayOfWeek,
                        startTime: e.startTime,
                        endTime: e.endTime,
                        address: e.address,
                        latitude: e.latitude.toString(),
                        longitude: e.longitude.toString(),
                        services: e.services,
                        telNumber: e.contactNo,
                        city: e.city),
                  ));
                  if (atmData.isNotEmpty) {
                    atmData.sort((a, b) =>
                        a.merchantName!.compareTo(b.merchantName ?? ""));
                  }
                  searchedAtmList = atmData;

                  cdmData.clear();
                  cdmData.addAll(state.cdmData!.map(
                    (e) => LocatorEntity(
                        merchantName: e.name,
                        landMark: e.landMark,
                        locationCategory: e.locationCategory,
                        status: getStatus(
                          e.startDayOfWeek.toString(),
                          e.endDayOfWeek.toString(),
                          e.startTime!,
                          e.endTime!,
                        )
                            ? "Open "
                            : "Temporary Close ",
                        startDayOfWeek: e.startDayOfWeek,
                        endDayOfWeek: e.endDayOfWeek,
                        startTime: e.startTime,
                        endTime: e.endTime,
                        address: e.address,
                        latitude: e.latitude.toString(),
                        longitude: e.longitude.toString(),
                        services: e.services,
                        telNumber: e.contactNo,
                        city: e.city),
                  ));
                    if (cdmData.isNotEmpty) {
                    cdmData.sort((a, b) =>
                        a.merchantName!.compareTo(b.merchantName ?? ""));
                  }
                  searchedCdmList = cdmData;

                  allData.clear();

                  allData.addAll(atmData);

                  allData.addAll(branchData);

                  allData.addAll(cdmData);

                  List<LocatorEntity> uniqueAllData = [];

                  if (allData.isNotEmpty) {
                    allData.sort((a, b) =>
                        a.merchantName!.compareTo(b.merchantName ?? ""));
                    Set<String> seenLocations = {};

                    for (var location in allData) {
                      String key = '${location.latitude},${location.longitude}';

                      if (!seenLocations.contains(key)) {
                        seenLocations.add(key);
                        uniqueAllData.add(location);
                      }
                    }
                  }

                  allData = uniqueAllData;

                  searchedList = allData;

                  setState(() {});
                } else if (state is GetLocatorFailedState) {
                  ToastUtils.showCustomToast(
                      context, state.errorMessage!, ToastStatus.FAIL);
                }
              },
              child: Stack(
                children: [
                  HuaweiMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    onClick: (location) {
                      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                      setState(() {
                        _controller.clear();
                        viewList = false;
                        isCardShowing = false;
                        _selectedMarker = null;
                      });
                    },
                    markers: Set<Marker>.from((current == 0
                            ? allData // Show both branches and ATMs
                            : current == 1
                                ? branchData
                                : current == 2
                                    ? atmData
                                    : cdmData // Show ATMs only
                        )
                        .map((location) {
                      return Marker(
                        clickable: true,
                        onClick: () {
                          setState(() {
                            _selectedMarker =
                                location; // Update the selected marker
                            isCardShowing = true;
                          });
                          mapController
                              ?.animateCamera(CameraUpdate.newCameraPosition(
                            CameraPosition(
                              bearing: 0,
                              target: LatLng(double.parse(location.latitude!),
                                  double.parse(location.longitude!)),
                              zoom: 10,
                            ),
                          ));
                        },
                        markerId: MarkerId(location.merchantName!),
                        icon: _selectedMarker == location
                            ? customIconR!
                            : customIconB!,
                        position: LatLng(
                          double.parse(location.latitude!),
                          double.parse(location.longitude!),
                        ),
                        // infoWindow: InfoWindow(title: location.merchantName),
                      );
                    })),
                    initialCameraPosition: HuaweiMapLocator._sriLankaMap,
                    onMapCreated: (HuaweiMapController controller) {
                      _mapController.complete(controller);
                      mapController = controller;
                    },
                  ),
                  Container(
                    color: colors(context).primaryColor50,
                    // height: 4.30.h,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w,24.h,20.w,16.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 35,
                            child: SlidingSegmentedBar(
                              selectedTextStyle: size14weight700.copyWith(
                                  color: colors(context).whiteColor),
                              textStyle: size14weight700.copyWith(
                                  color: colors(context).blackColor),
                              backgroundColor: colors(context).whiteColor,
                               borderRadius: BorderRadius.circular(8),
                                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: 8),
                              onChanged: (int value) async{
                                setState(() {
                                  current = value;
                            
                                  viewList = false;
                                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                  isCardShowing = false;
                                  _selectedMarker = null;
                            
                                  _controller.clear();
                                  mapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      const CameraPosition(
                                        target: LatLng(8.2, 80.75),
                                        zoom: 7.6,
                                      ),
                                    ),
                                  );
                                  if (current == 0) {
                                  searchedList = allData;
                                } else if (current == 1) {
                                  searchedBranchList = branchData;
                                } else if (current == 2) {
                                  searchedAtmList = atmData;
                                } else {
                                  searchedCdmList = cdmData;
                                }
                                });
                              },
                              selectedIndex: current,
                              children: [
                                AppLocalizations.of(context).translate("all"),
                                AppLocalizations.of(context).translate("branches"),
                                AppLocalizations.of(context).translate("atms"),
                                AppLocalizations.of(context).translate("cdms")],
                            ),
                          ),
                          12.verticalSpace,
                          Container(
                            decoration: BoxDecoration(
                              color: colors(context).whiteColor,
                              borderRadius: BorderRadius.circular(8).w,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(child: _buildTextField()),
                                  ],
                                ),
                                 Visibility(
                                  visible: viewList,
                                    child: SizedBox(
                                      height: ScreenUtil().screenHeight * 0.3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: colors(context).whiteColor,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ).w,
                                        ),
                                        child: ListView.builder(
                                          physics: const BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount: current == 0
                                              ? searchedList.length
                                              : current == 1
                                                  ? searchedBranchList.length
                                                  : current == 2
                                                      ? searchedAtmList.length
                                                      : searchedCdmList.length,
                                          itemBuilder: (context, index) {
                                            LocatorEntity item;
                                            if (current == 0) {
                                              item = searchedList[index];
                                            } else if (current == 1) {
                                              item = searchedBranchList[index];
                                            } else if (current == 2) {
                                              item = searchedAtmList[index];
                                            } else {
                                              item = searchedCdmList[index];
                                            }
                                    
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  viewList = false;
                                                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                                    
                                                  _selectedMarker = item;
                                                  isCardShowing = true;
                                                });
                                                mapController
                                                    ?.animateCamera(CameraUpdate
                                                        .newCameraPosition(
                                                  CameraPosition(
                                                    bearing: 0,
                                                    target: LatLng(
                                                        double.parse(
                                                            item.latitude ?? ""),
                                                        double.parse(
                                                            item.longitude ??
                                                                "")),
                                                    zoom: 10,
                                                  ),
                                                ))
                                                    .then((value) {
                                                  viewList = false;
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.only(left: 20)
                                                        .w,
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 30.h,
                                                        child: ListTile(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                            vertical: 0,
                                                            horizontal: 0,
                                                          ).w,
                                                          title: Text(
                                                            item.merchantName ??
                                                                "",
                                                            style:
                                                                size16weight400,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Divider(
                                                        thickness: 1,
                                                        color: colors(context)
                                                            .greyColor,
                                                        endIndent: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                   Visibility(
                       visible: isCardShowing,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:   EdgeInsets.only(right: 25.w, bottom: 12.99),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () async {
                                  final Position position =
                                      await _determinePosition();
                      
                                 await mapController?.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(position.latitude,
                                            position.longitude),
                                        zoom: 10,
                                      ),
                                    ),
                                  );
                                  setState(() {});
                                },
                                child: Container(
                                 padding: EdgeInsets.all(17).w,
                                  decoration: BoxDecoration(
                                    color: colors(context).whiteColor,
                                    shape: BoxShape.circle,
                                  ),
                                   child: PhosphorIcon(PhosphorIcons.navigationArrow(PhosphorIconsStyle.fill),color: colors(context).primaryColor, size: 24,),
                                ),
                              ),
                            ),
                          ),
                          showCard(selectedMarker: _selectedMarker),
                        ],
                      ),
                    ),
                
                    Visibility(
                       visible: !isCardShowing,
                      child: Positioned.fill(
                        child: Padding(
                          padding:  EdgeInsets.only(right: 25.w, bottom: 12.99 + AppSizer.getHomeIndicatorStatus(context)),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                final Position position =
                                    await _determinePosition();
                      
                               await mapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                          position.latitude, position.longitude),
                                      zoom: 10,
                                    ),
                                  ),
                                );
                                setState(() {});
                              },
                              child: Container(
                               padding: EdgeInsets.all(17).w,
                                decoration: BoxDecoration(
                                  color: colors(context).whiteColor,
                                  shape: BoxShape.circle,
                                ),
                                 child: PhosphorIcon(PhosphorIcons.navigationArrow(PhosphorIconsStyle.fill),color: colors(context).primaryColor, size: 24,),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool getStatus(
      String startDate, String endDate, String startTime, String endTime) {
    try {
      DateTime today = DateTime.now();

      List<String> startSlot = startTime.split(":");
      List<String> endSlot = endTime.split(":");

      TimeOfDay tod1 = TimeOfDay(
          hour: int.parse(startSlot[0]), minute: int.parse(startSlot[1]));
      TimeOfDay tod2 =
          TimeOfDay(hour: int.parse(endSlot[0]), minute: int.parse(endSlot[1]));
      final dt1 =
          DateTime(today.year, today.month, today.day, tod1.hour, tod1.minute);
      final dt2 =
          DateTime(today.year, today.month, today.day, tod2.hour, tod2.minute);

      if (today.weekday >= int.parse(startDate) &&
          today.weekday <= int.parse(endDate)) {
        if (today.isAfter(dt1) && today.isBefore(dt2)) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return true;
    }
  }

  Widget showCard({LocatorEntity? selectedMarker}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: LocationMarkerCard(
        branchResponseEntity: selectedMarker,
        closeFunction: () {
          setState(() {
            isCardShowing = false;
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }

  Future<Position> _determinePosition() async {
    final Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  Widget _buildTextField() {
    String message = '';
    return LayoutBuilder(builder: (context, size) {
      final TextSpan text = TextSpan(
        text: _controller.text,
      );
      final TextPainter tp = TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
      tp.layout(maxWidth: size.maxWidth);

      final int lines = (tp.size.height / tp.preferredLineHeight).ceil();
      const int maxLines = 1;

      return Scrollbar(
        child: SizedBox(
          height: 40.h,
          child: TextField(
            onTap: () {
              isCardShowing = false;
              viewList = true;
              setState(() {});
            },
            contextMenuBuilder: (context, editableTextState) {
              return SizedBox.shrink();
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              // Hide the default border
              hintText: 'Search',
              hintStyle:
                  size16weight400.copyWith(color: colors(context).greyColor),
              prefixIcon: PhosphorIcon(
                PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
                color: colors(context).blackColor,
              ),
              contentPadding: EdgeInsets.only(
                top: 1,
              ).w,
            ),
            scrollPhysics: const BouncingScrollPhysics(),
            controller: _controller,
            maxLines: lines < maxLines ? null : maxLines,
            onChanged: (value) {
              setState(() {
                isCardShowing = false;
                if (current == 0) {
                  searchFromListAll(value);
                } else if (current == 1) {
                  searchFromListBranches(value);
                } else if (current == 2) {
                  searchFromListAtms(value);
                } else {
                  searchFromListCdms(value);
                }
              });
            },
            style: size16weight700.copyWith(color: colors(context).greyColor),
          ),
        ),
      );
    });
  }

  void searchFromListAll(String message) {
    if (message.isEmpty) {
      searchedList = allData;
      viewList = true;
    } else {
      searchedList = allData
          .where((element) => element.merchantName!
              .toLowerCase()
              .contains(message.toLowerCase())).toSet()
          .toList();
      if (searchedList.isEmpty) {
        viewList = false;
      } else {
        viewList = true;
      }
    }
    setState(() {});
  }

  void searchFromListBranches(String message) {
    if (message.isEmpty) {
      searchedBranchList = branchData;
      viewList = true;
    } else {
      searchedBranchList = branchData
          .where((element) => element.merchantName!
              .toLowerCase()
              .contains(message.toLowerCase())).toSet()
          .toList();
      if (searchedBranchList.isEmpty) {
        viewList = false;
      } else {
        viewList = true;
      }
    }
    setState(() {});
  }

  void searchFromListAtms(String message) {
    if (message.isEmpty) {
      searchedAtmList = atmData;
      viewList = true;
    } else {
      searchedAtmList = atmData
          .where((element) => element.merchantName!
              .toLowerCase()
              .contains(message.toLowerCase())).toSet()
          .toList();
      if (searchedAtmList.isEmpty) {
        viewList = false;
      } else {
        viewList = true;
      }
    }
    setState(() {});
  }

  void searchFromListCdms(String message) {
    if (message.isEmpty) {
      searchedCdmList = cdmData;
      viewList = true;
    } else {
      searchedCdmList = cdmData
          .where((element) => element.merchantName!
              .toLowerCase()
              .contains(message.toLowerCase())).toSet()
          .toList();
      if (searchedCdmList.isEmpty) {
        viewList = false;
      } else {
        viewList = true;
      }
    }
    setState(() {});
  }
}
