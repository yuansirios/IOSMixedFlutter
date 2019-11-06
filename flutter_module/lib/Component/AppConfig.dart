enum EnvType {
  EnvType_Dev,
  EnvType_Test,
  EnvType_Release,
}

class AppConfig {
  static EnvType env = EnvType.EnvType_Dev;

// app名称
  static String get appName {
    switch (env) {
      case EnvType.EnvType_Dev:
        return "开发环境";
      case EnvType.EnvType_Test:
        return "测试环境";
      case EnvType.EnvType_Release:
      default:
        return "生产环境";
    }
  }

// api地址
  static String get apiHost {
    switch (env) {
      case EnvType.EnvType_Dev:
        return "https://开发地址";
      case EnvType.EnvType_Test:
        return "https://测试地址";
      case EnvType.EnvType_Release:
      default:
        return "https://生产地址";
    }
  }
}
