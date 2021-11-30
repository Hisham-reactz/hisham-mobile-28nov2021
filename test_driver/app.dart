import 'package:flutter_driver/driver_extension.dart' as driver;
import 'package:twitter_clone/main.dart' as app;

void main() async {
  driver.enableFlutterDriverExtension();
  app.main();
}
