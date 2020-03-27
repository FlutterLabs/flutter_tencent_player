class Validate {
  /// 是否为手机号码
  static bool isMobile(String val) {
    RegExp reg = new RegExp(r'^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\d{8}$');
    return reg.hasMatch(val);
  }

  /// 是否为邮箱
  static bool isEmail(String val) {
    RegExp reg = new RegExp(r'^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$');
    return reg.hasMatch(val);
  }

  /// 是否为电话号码
  static bool isTel(String val) {
    RegExp reg = new RegExp(r'^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$');
    return reg.hasMatch(val);
  }

  /// 验证是否为6~18位密码
  static bool isSixToEighteenPassword(String val) {
    RegExp reg = new RegExp(r"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$");
    return reg.hasMatch(val);
  }

  /// 验证是否为6位数字验证码
  static bool isSixNumberCaptcha(String val) {
    RegExp reg = new RegExp(r"\d{6}$");
    return reg.hasMatch(val);
  }

  /// 验证是否为4位数字验证码
  static bool isFourNumberCaptcha(String val) {
    RegExp reg = new RegExp(r"\d{4}$");
    return reg.hasMatch(val);
  }

  /// 是否为ip地址
  static bool isIpAddress(String val) {
    RegExp reg = new RegExp(r'^(\d+)\.(\d+)\.(\d+)\.(\d+)$');
    return reg.hasMatch(val);
  }

  /// 判断是否为正确的url地址
  static bool isUrl(String val) {
    RegExp reg = new RegExp(r'^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+).)+([A-Za-z0-9-~\/])+$');
    return reg.hasMatch(val);
  }

  /// 验证身份证号码
  static bool isIdCard(String cardId) {
    if (cardId.length != 18) {
      return false; // 位数不够
    }
    /// 身份证号码正则
    RegExp postalCode = new RegExp(r'^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[Xx])$');
    /// 通过验证，说明格式正确，但仍需计算准确性
    if (!postalCode.hasMatch(cardId)) {
      return false;
    }
    /// 将前17位加权因子保存在数组里
    final List idCardList = ["7", "9", "10", "5", "8", "4", "2", "1", "6", "3", "7", "9", "10", "5", "8", "4", "2"];
    /// 这是除以11后，可能产生的11位余数、验证码，也保存成数组
    final List idCardYArray = ['1', '0', '10', '9', '8', '7', '6', '5', '4', '3', '2'];
    /// 前17位各自乖以加权因子后的总和
    int idCardWiSum = 0;

    for (int i = 0; i < 17; i++) {
      int subStrIndex = int.parse(cardId.substring(i, i + 1));
      int idCardWiIndex = int.parse(idCardList[i]);
      idCardWiSum += subStrIndex * idCardWiIndex;
    }
    /// 计算出校验码所在数组的位置
    int idCardMod = idCardWiSum % 11;
    /// 得到最后一位号码
    String idCardLast = cardId.substring(17, 18);
    /// 如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if (idCardMod == 2) {
      if (idCardLast != 'x' && idCardLast != 'X') {
        return false;
      }
    } else {
      /// 用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
      if (idCardLast != idCardYArray[idCardMod]) {
        return false;
      }
    }
    return true;
  }
}