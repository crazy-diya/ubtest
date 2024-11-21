import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:union_bank_mobile/core/service/platform_services.dart';
import 'package:union_bank_mobile/core/theme/text_styles.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';
import 'package:union_bank_mobile/features/presentation/views/lanka_qr_pay/qr_payment_view_view.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_localizations.dart';
import '../../../../utils/app_sizer.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../../data/models/common/lanka_qr_payload.dart';
import '../../bloc/account/account_bloc.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/appbar.dart';
import '../base_view.dart';

class ScanQRCodeView extends BaseView {
  final String? route;

  ScanQRCodeView({this.route});

  @override
  _ScanQRCodeViewState createState() => _ScanQRCodeViewState();
}

class _ScanQRCodeViewState extends BaseViewState<ScanQRCodeView> {
  final AccountBloc _bloc = injection<AccountBloc>();

  Barcode? result;
  QRViewController? qrcontroller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  StreamSubscription? _subscription;
  bool scanning = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrcontroller?.pauseCamera();
    } else if (Platform.isIOS) {
      qrcontroller?.resumeCamera();
    }
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      formatsAllowed: [BarcodeFormat.qrcode],
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        overlayColor: Colors.black.withOpacity(0.55),
        borderColor: colors(context).secondaryColor!,
        borderRadius: 12.w,
        borderLength: 32.w,
        borderWidth: 8.w,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    qrcontroller = controller;
    _subscription = controller.scannedDataStream.listen(
      (scanData) {
        if (mounted) {
          setState(() {
            scanning = true;
            result = scanData;
          });
          parseQRCode(result!.code!);
          qrcontroller?.pauseCamera();
        }
      },
      onDone: () {
        if (mounted) {
          setState(() {
            scanning = false;
          });
        }
      },
    );
  }


  void parseQRCode(String code) async {
    try {
      final String validatedQr = await PlatformServices.getQRDecoder(code);

      if (validatedQr.isNotEmpty) {
        final lankaQrPayload = LankaQrPayload.fromRawJson(validatedQr);

        if (mounted) {
          Future.delayed(Duration(milliseconds: 200), () async {
            await Navigator.pushReplacementNamed(
              context,
              Routes.kQRPaymentView,
              arguments: QRPaymentViewArgs(
                lankaQrPayload: lankaQrPayload,
                route: widget.route,
              ),
            );
          });
        } else {
          _showInvalidQRCodeDialog(context);
        }
      }
    } catch (error) {
      if (mounted) {
        _showInvalidQRCodeDialog(context);
      }
    }
  }

  void _showInvalidQRCodeDialog(BuildContext context) {
    if (!mounted) return;
    showAppDialog(
      alertType: AlertType.WARNING,
      title: AppLocalizations.of(context).translate("invalid_QR_code"),
      message: AppLocalizations.of(context).translate("scan_again"),
      negativeButtonText: AppLocalizations.of(context).translate("no"),
      positiveButtonText: AppLocalizations.of(context).translate("yes"),
      onNegativeCallback: () {
        if (mounted) Navigator.of(context).pop();
      },
      onPositiveCallback: () {
        startScanning();
      },
    );
  }

  void startScanning() {
    if (mounted) {
      setState(() {
        result = null;
        scanning = false;
      });
    }
    qrcontroller?.resumeCamera();
  }

  @override
  void dispose() {
    _subscription?.cancel(); // Cancel the stream subscription
    qrcontroller?.dispose();
    super.dispose();
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: UBAppBar(
        title: AppLocalizations.of(context).translate("qr_payment"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _buildQrView(context),
          Positioned(
            top: 50.h,
            child: Container(
              decoration: BoxDecoration(
                color: colors(context).blackColor,
                borderRadius: BorderRadius.circular(8).r,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10).w,
                child: Text(
                  AppLocalizations.of(context)
                      .translate(scanning ? "scanning" : "scan_Lanka_qr_code"),
                  style: size16weight400.copyWith(
                    color: colors(context).whiteColor,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 36.h + AppSizer.getHomeIndicatorStatus(context),
            child: InkWell(
              onTap: () async {
                await qrcontroller?.toggleFlash();
                if (mounted) {
                  setState(() {});
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors(context).primaryColor300,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16).w,
                  child: FutureBuilder(
                    future: qrcontroller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return PhosphorIcon(
                        PhosphorIcons.flashlight(PhosphorIconsStyle.bold),
                        color: colors(context).whiteColor,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}