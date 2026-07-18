import 'package:flutter_test/flutter_test.dart';

import 'package:orange_a_i_hub/flutter_flow/form_field_controller.dart';

void main() {
  group('FormFieldController', () {
    test('starts with the initial value', () {
      final controller = FormFieldController<String>('hello');
      expect(controller.value, 'hello');
    });

    test('reset restores the initial value after a change', () {
      final controller = FormFieldController<String>('hello');
      controller.value = 'changed';
      expect(controller.value, 'changed');

      controller.reset();
      expect(controller.value, 'hello');
    });

    test('update notifies listeners without changing the value', () {
      final controller = FormFieldController<int>(1);
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.update();
      expect(notifications, 1);
      expect(controller.value, 1);
    });
  });

  group('FormListFieldController', () {
    test('reset restores the original list even if it was mutated in place',
        () {
      // This controller exists specifically to guard against the initial
      // list being modified by reference — verify that guarantee.
      final controller = FormListFieldController<String>(['a', 'b']);
      controller.value!.add('c');
      controller.value = [...controller.value!, 'd'];
      expect(controller.value, ['a', 'b', 'c', 'd']);

      controller.reset();
      expect(controller.value, ['a', 'b']);
    });

    test('reset produces a fresh copy, not the same list instance', () {
      final controller = FormListFieldController<int>([1, 2]);
      controller.reset();
      final firstReset = controller.value;
      controller.reset();
      expect(identical(firstReset, controller.value), isFalse);
    });
  });
}
