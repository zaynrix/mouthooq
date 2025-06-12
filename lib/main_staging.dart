import 'package:flutter/material.dart';
import 'app_config/environment.dart';
import 'main.dart' as app;

void main() {
  EnvironmentConfig.setEnvironment(Environment.staging);
  EnvironmentConfig.printConfig();
  app.main();
}