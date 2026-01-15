import 'package:get_storage/get_storage.dart';

class TimerService {
  static const String _timerKey = 'timer_start_time';
  static const String _orderIdKey = 'current_order_id';
  final GetStorage _storage = GetStorage();

  void startTimer(int seconds, {String? orderId}) {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    _storage.write(_timerKey, startTime);
    _storage.write('timer_duration', seconds);

    if (orderId != null) {
      _storage.write(_orderIdKey, orderId);
    }
  }

  int getRemainingSeconds() {
    final startTime = _storage.read(_timerKey);
    final duration = _storage.read('timer_duration') ?? 600;

    if (startTime == null) return 0;

    final elapsedMilliseconds =
        DateTime.now().millisecondsSinceEpoch - startTime;
    final elapsedSeconds = (elapsedMilliseconds / 1000).floor();
    final remaining = duration - elapsedSeconds;

    return remaining > 0 ? remaining : 0;
  }

  void clearTimer() {
    _storage.remove(_timerKey);
    _storage.remove('timer_duration');
  }

  String? getOrderId() {
    return _storage.read(_orderIdKey);
  }

  void setOrderId(String orderId) {
    _storage.write(_orderIdKey, orderId);
  }
}
