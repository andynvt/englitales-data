import 'package:flutter/material.dart';
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
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            buildPicker(model),
            SizedBox(height: 16),
            buildCategory(model),
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
          child: Text(
            'Pick',
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(width: 16),
        Text('${model.fileName}'),
      ],
    );
  }

  Widget buildCategory(HomeModel model) {
    if (model.data.isEmpty) return Container();
    return Container(
      color: Colors.amber,
      height: 100,
    );
  }
}
