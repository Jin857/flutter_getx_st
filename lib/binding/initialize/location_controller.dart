import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

/// 本地地址初始化
/// 可以初始化加载这个类但是不能初始化去调用地址方法，需要等待页面进入App内首页调用请求地址方法
class LocationController extends GetxController {
  static const String _kLocationServicesDisabledMessage = '位置服务已禁用';
  static const String _kPermissionDeniedMessage = '权限被拒绝';
  static const String _kPermissionDeniedForeverMessage = '永久拒绝许可';
  static const String _kPermissionGrantedMessage = '已授予许可';
  final List<_PositionItem> _positionItems = <_PositionItem>[];

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  RxString locationStr = "尚未定位".obs;

  /// 初始化注入
  @override
  void onInit() {
    super.onInit();
  }

  /// 获取地址
  Future<void> getLocation() async {
    locationStr.value = "定位中...";
    _getCurrentPosition();
  }

  /// 手动选择地址
  /// - 返回bool true 选择 false 未选择
  Future<bool> openSelectAddress(String text) async {
    return text != locationStr.value;
  }

  /// 获取当前位置Position
  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return;
    }
    final position = await _geolocatorPlatform.getCurrentPosition();
    _updatePositionList(_PositionItemType.position, position.toString());
  }

  /// 申请权限
  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 测试位置服务是否已启用
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 位置服务未启用。请不要继续访问该位置，并请求应用程序的用户启用位置服务。
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );
      return false;
    }
    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // 权限被拒绝，下次您可以再次尝试请求权限（这也是Android的shouldShowRequestPermissionRationale返回true的地方。根据Android的指导方针，您的应用程序现在应该显示一个解释性的UI。
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // 权限永远被拒绝，请妥善处理。
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );
      return false;
    }
    // 当我们到达这里时，权限被授予，我们可以继续访问设备的位置。
    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    print("------->> displayValue:${displayValue}");
    _positionItems.add(_PositionItem(type, displayValue));
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
