import 'app_config/environment.dart';
import 'main.dart' as app;

void main() {
  EnvironmentConfig.setEnvironment(Environment.development);
  EnvironmentConfig.printConfig();
  app.main();
}