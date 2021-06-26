import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';

ChangeNotifierProvider<HomeModel> createHome() {
  return ChangeNotifierProvider<HomeModel>(
    create: (_) => HomeModel(),
    child: _HomeView(),
  );
}

class _HomeView extends StatefulWidget {
  const _HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<HomeModel>();
    return Scaffold(
      // backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildPicker(model),
            SizedBox(height: 16),
            buildCategory(model),
            SizedBox(height: 16),
            buildTable(model),
          ],
        ),
      ),
    );
  }

  Widget buildPicker(HomeModel model) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MaterialButton(
          onPressed: model.pick,
          child: Text('Select file'),
        ),
        SizedBox(width: 16),
        Text('${model.fileName}'),
      ],
    );
  }

  Widget buildCategory(HomeModel model) {
    if (model.categories.isEmpty) return Container();
    final List<Widget> ls = [];
    model.categories.forEach((k, v) {
      ls.add(Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(k),
            Spacer(),
            Text(v),
          ],
        ),
      ));
    });
    return Container(
      height: 50,
      decoration: BoxDecoration(border: Border.all()),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: model.categories.length,
        separatorBuilder: (_, __) => VerticalDivider(color: Colors.black, width: 1),
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Text(model.categories.keys.toList()[i]),
                Spacer(),
                Text(model.categories.values.toList()[i]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTable(HomeModel model) {
    if (model.items.isEmpty) return Container();
    return Expanded(
      child: PlutoGrid(
        columns: model.cols,
        rows: model.rows,
        configuration: PlutoGridConfiguration.dark(),
      ),
    );
  }
}
