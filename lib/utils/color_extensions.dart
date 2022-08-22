// Created By Amit Jangid on 12/08/22

extension ColorExtension on String {
  /// this extension will convert # color
  int get toColor => int.parse(replaceAll('#', '0xff'));
}
