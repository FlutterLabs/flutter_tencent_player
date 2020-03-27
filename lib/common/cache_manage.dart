import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheManage {
  static CacheManage instance;

  static CacheManage getInstance() {
    if( instance == null ) {
      instance = CacheManage();
    }
    return instance;
  }

  Future<String> loadCacheSizeValue() async {
    double value = await loadCache();
    return _transformToString(value);
  }

  /// 获取缓存
  Future<double> loadCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      return value;
    } catch(_) {
      print("缓存目录读取失败");
      return 0.0;
    }
  }

  /// 清除缓存
  Future<bool> clearCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await _delDir(tempDir);
      return true;
    } catch(_) {
      print('清除缓存失败');
      return false;
    }
  }


  /// 递归方式删除目录
  Future<Null> _delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await _delDir(child);
      }
    }
    await file.delete();
  }

  /// 循环计算文件大小（递归算法）
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  /// 格式化字符串
  String _transformToString(double value) {
    if (null == value) {
      return "0.00M";
    }
    List<String> unitArr = List()
      ..add('B')
      ..add('K')
      ..add('M')
      ..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }
}