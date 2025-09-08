import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/text_widget.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  static pageRoute() => CupertinoPageRoute(builder: (context) => BlogPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: TextWidget('Landed Home page')));
  }
}
