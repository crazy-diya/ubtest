import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/features/presentation/views/base_view.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import '../../../../../core/service/dependency_injection.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/appbar.dart';

class TrainScheduleView extends BaseView {
  TrainScheduleView({super.key});

  @override
  _TrainScheduleViewState createState() => _TrainScheduleViewState();
}

class _TrainScheduleViewState extends BaseViewState<TrainScheduleView> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  final _bloc = injection<SplashBloc>();
  bool webviewLoading = true;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();

        (InAppWebViewController controller, String origin, List<String> resources) async {
      return PermissionRequestResponse(
          resources: resources, action: PermissionRequestResponseAction.GRANT);
    };
  }

  void onWebViewCreated(controller) {
    webViewController = controller;

    controller.addJavaScriptHandler(
      handlerName: "myHandler",
      callback: (args) {
        return "Hello from Flutter!";
      },
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: const UBAppBar(title: "Train Ticket Booking"),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                url: Uri.parse(AppConstants.SEAT_RESERVATION_URL!),
              ),
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
              onWebViewCreated: onWebViewCreated,
              initialOptions: options,
              androidOnPermissionRequest: (InAppWebViewController controller,
                  String origin, List<String> resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              onLoadStart: (controller, url) {
                setState(() {
                  webviewLoading = true;
                });
              },
              onLoadStop: (controller, url) {
                setState(() {
                  webviewLoading = false;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  this.progress = progress / 100.0;
                });
              },
              onLoadError: (controller, url, code, message) {
              },
            ),
            if (webviewLoading)
              LinearProgressIndicator(
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                value: progress,
              ),
          ],
        ),
      ),
    );
  }

  @override
  BaseBloc<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  crossPlatform: InAppWebViewOptions(
    mediaPlaybackRequiresUserGesture: false,
    clearCache: true,
    javaScriptEnabled: true,
    cacheEnabled: false,
  ),
  ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
      allowsAirPlayForMediaPlayback: true,
      automaticallyAdjustsScrollIndicatorInsets: true),
);
