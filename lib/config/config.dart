import 'package:flutter/services.dart';
import 'package:flutter_getx_st/model/base_config.dart';
import 'package:yaml/yaml.dart';

class Config {
  /// 获取本地配置文件
  static Future<BaseConfig> getConfig() async {
    final yamlString = await rootBundle.loadString('assets/config.yaml');
    final dynamic yamlMap = loadYaml(yamlString);
    return BaseConfig.of(yamlMap);
  }
}
