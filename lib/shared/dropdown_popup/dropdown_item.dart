import 'package:flutter/cupertino.dart';

class DropdownItem<T> {
  Widget child;
  T value;
  DropdownItem({
    required this.child,
    required this.value,
  });
}
