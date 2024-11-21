import 'dart:async';

class OTPCountDown {
  late String _countDown;
  late Timer _timer;

  OTPCountDown.startOTPTimer({
    required int timeInMS,
    required void Function(String countDown) currentCountDown,
    required void Function(int countDown) currentCountDownMs,
    required void Function() onFinish,
  }) {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (Timer timer) {
      timeInMS -= 1000;
      Duration duration = Duration(milliseconds: timeInMS);

      if (duration.inSeconds % 60 == 0) {
        _countDown = "0${duration.inMinutes}:00";
      } else {
        int seconds = duration.inSeconds % 60;
        String secondsInString = seconds.toString();
        if (seconds < 10) {
          secondsInString = "0$seconds";
        }
        if (duration.inMinutes > 0) {
          _countDown = "0${duration.inMinutes}:$secondsInString";
        } else {
          _countDown = "00:$secondsInString";
        }
      }

      currentCountDown(_getCountDown);
      currentCountDownMs(duration.inMilliseconds);

      if (duration.inSeconds == 0) {
        onFinish();
        timer.cancel();
      }
    });
  }

  String get _getCountDown => _countDown;

  void cancelTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
  }

  String formattedTime(int time) {
    if (0 < time) {
      Duration duration = Duration(milliseconds: time);
      if (duration.inSeconds % 60 == 0) {
        return "0${duration.inMinutes}:00";
      } else {
        int seconds = duration.inSeconds % 60;
        String secondsInString = seconds.toString();
        if (seconds < 10) {
          secondsInString = "0$seconds";
        }
        if (duration.inMinutes > 0) {
          return "0${duration.inMinutes}:$secondsInString";
        } else {
          return "00:${secondsInString}";
        }
      }
    } else {
      return "00:00";
    }
  }
}
