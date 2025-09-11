import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  SectionTitle(this.title);
  @override
  Widget build(BuildContext context) =>
      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700));
}
