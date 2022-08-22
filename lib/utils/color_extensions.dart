// Created By Amit Jangid on 12/08/22

extension ColorExtension on String {
  int get toColor => int.parse(replaceAll('#', '0xff'));
}
