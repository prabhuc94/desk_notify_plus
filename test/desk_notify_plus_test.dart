import 'package:desk_notify_plus/desk_notify_plus.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('adds one to input values', () {
    notification.show(title: "Sample title", message: "Sample message");
  });
}
