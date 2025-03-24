// ignore_for_file: constant_identifier_names

/// 基础配置
class BaseConfig {
  /// 基础URL
  final String baseUrl;

  /// 图片URL
  final String imageUrl;

  /// 开发模式
  final DevelopMode mode;

  BaseConfig({
    required this.mode,
    required this.baseUrl,
    required this.imageUrl,
  });

  factory BaseConfig.of(dynamic json) {
    return BaseConfig(
      mode: DevelopMode.fromJson(json['mode'] ?? "debug"),
      baseUrl: json['baseUrl'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  @override
  String toString() {
    return 'mode=$mode, serverURL=$baseUrl';
  }
}

/// 开发模式类型
enum DevelopMode {
  /// 正式
  RELEASE("release"),

  /// debug
  DEBUG("debug"),

  /// 本地开发
  LOCAL("local");

  final String cname;
  const DevelopMode(this.cname);

  factory DevelopMode.fromJson(String json) {
    return DevelopMode.values.firstWhere(
      (e) => e.cname == json,
      orElse: () => DevelopMode.LOCAL, // 默认值，避免出现异常
    );
  }
}
