import '../../../utils/enums.dart';
import '../../configurations/app_config.dart';
import 'cloud_services_impl.dart';

class CloudServices {
  final CloudServicesImpl _pushNotificationsManager;

  CloudServices(this._pushNotificationsManager);

  
  Future<bool?> capturePushToken() {
    if(AppConfig.deviceOS == DeviceOS.ANDROID) {
      return _pushNotificationsManager.getFCMToken();
    } else {
      return _pushNotificationsManager.getHCMToken();
    }
  }
  

  
  topicSubscribe(String topic) {
    if(AppConfig.deviceOS == DeviceOS.ANDROID) {
      _pushNotificationsManager.subscribeFCMTopic(topic);
    } else {
      _pushNotificationsManager.subscribeHCMTopic(topic);
    }
  }

  topicUnsubscribe(String topic) {
    if(AppConfig.deviceOS == DeviceOS.ANDROID) {
      _pushNotificationsManager.unsubscribeFCMTopic(topic);
    } else {
      _pushNotificationsManager.unsubscribeHCMTopic(topic);
    }
  }
}
