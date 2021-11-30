import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/app/modules/login/controllers/login_controller.dart';

void main() async {
  const input1 = 'Email';
  const input2 = 'Password';
  test('Login form validate when formdata empty', () {
    //Arrange
    const email = '';
    const password = '';
    //Action
    final response1 = LoginController().validate(email, input1);
    final response2 = LoginController().validate(password, input2);
    //Assert
    expect(response1, 'No Empty $input1!');
    expect(response2, 'No Empty $input2!');
  });

  test('Login form validate when formdata invalid', () {
    //Arrange
    const email = 'test.tempmail@';
    const password = '123';
    //Action
    final response1 = LoginController().validate(email, input1);
    final response2 = LoginController().validate(password, input2);
    //Assert
    expect(response1, 'Invalid $input1!');
    expect(response2, 'Invalid $input2!');
  });

  test('Login form validate when formdata valid', () {
    //Arrange
    const email = 'test@tempmail.com';
    const password = '123456';
    //Action
    final response1 = LoginController().validate(email, input1);
    final response2 = LoginController().validate(password, input2);
    //Assert
    expect(response1, null);
    expect(response2, null);
  });
}
