import 'package:flutter/material.dart';

import '../tools/bg_consts.dart';
import '../widgets/items.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(BgConsts.hSpace),
      child: GridView.count(
        crossAxisCount: 9,
        childAspectRatio: 1.5 / 1,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        shrinkWrap: true,
        children: _x(),
      ),
    );
  }

  List<Widget> _x() {
    return List.generate(5, (int position) {
      if (position == 0) {
        return Text('data');
      }
      return Items.project();
    });
  }
}
