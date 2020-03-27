import 'package:permission_handler/permission_handler.dart';

class Permission {
  static Permission instance;

  static Permission getInstance() {
    if( instance == null ) {
      instance = Permission();
    }
    return instance;
  }

  /// 检测权限
  Future<bool> checkPermissionStatus(PermissionGroup group) async{
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.phone);
    return status==PermissionStatus.granted;
  }

  /// 判断权限，如无权限则申请
  Future<bool> checkAndApplyPermission(PermissionGroup group) async {
    bool status = await this.checkPermissionStatus(group);
    if (!status) {
      bool result = await this.applySinglePermission(group);
      return result;
    }
    return status;
  }

  /// 检测服务
  Future<bool> checkServiceStatus(PermissionGroup group) async {
    ServiceStatus serviceStatus = await PermissionHandler().checkServiceStatus(group);
    return serviceStatus==ServiceStatus.notApplicable;
  }

  /// 检测服务并申请权限
  Future<bool> checkAndApplyService(PermissionGroup group) async {
    bool status = await this.checkServiceStatus(group);
    if (!status) {
      bool result = await this.applySinglePermission(group);
      return result;
    }
    return status;
  }

  /// 申请权限
  Future<bool> applySinglePermission(PermissionGroup group) async {
    await PermissionHandler().requestPermissions([group]);
    bool result = await this.checkPermissionStatus(group);
    return result;
  }

  /// 申请多个权限
  Future<void> applyMultiplePermission(List<PermissionGroup> group) async {
    await PermissionHandler().requestPermissions(group);
  }

  /// 打开应用程序设置
  Future<bool> openAppSettings() async {
    bool isOpened = await PermissionHandler().openAppSettings();
    return isOpened;
  }
}