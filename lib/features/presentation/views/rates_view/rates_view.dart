import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:union_bank_mobile/features/presentation/bloc/splash/splash_bloc.dart';
import 'package:union_bank_mobile/utils/app_constants.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../widgets/appbar.dart';
import '../base_view.dart';

class RatesView extends BaseView {
  RatesView({Key? key}) : super(key: key);

  @override
  _RatesViewState createState() => _RatesViewState();
}

class _RatesViewState extends BaseViewState<RatesView> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  final _bloc = injection<SplashBloc>();
  bool isLoading = true;
  double progress = 0.0;

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
      appBar: const UBAppBar(title: "Rates"),
      body: Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
              url: Uri.parse(AppConstants.RATES_URL!),
            ),
            onReceivedServerTrustAuthRequest: (controller, challenge) async {
              return ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED,
              );
            },
            onWebViewCreated: onWebViewCreated,
            initialOptions: options,
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100; // Ensure progress is in the range [0, 1]
              });
            },
          ),
          if (isLoading)
            LinearProgressIndicator(
              value: progress,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              backgroundColor: Colors.grey[300],
            ),
        ],
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
    automaticallyAdjustsScrollIndicatorInsets: true,
  ),
);
