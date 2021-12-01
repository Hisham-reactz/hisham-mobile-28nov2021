import 'package:flutter_driver/flutter_driver.dart' as dvr;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('description', () {
    final button = dvr.find.byValueKey('loginButton');
    dvr.FlutterDriver? driver;

    setUpAll(() async {
      driver = await dvr.FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('LoginButton onTap', () async {
      //Arrange
      const expectText = 'No Empty Email';
      //Act
      await driver!.tap(button);
      final text = dvr.find.text(expectText);
      //Assert
      expect(await driver!.getText(text), expectText);
    });
  });
}
