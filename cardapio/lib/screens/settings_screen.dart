import 'package:cardapio/components/main_drawer.dart';
import 'package:cardapio/models/settings.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettlingsChanged;

  SettingsScreen(
    this.onSettlingsChanged,
    this.settings,
  );

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettlingsChanged(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              "Configurações",
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              createSwitch(
                "Sem Gluten",
                "Só exibe refeições sem gluten",
                settings.isGlutenFree,
                (v) {
                  setState(() => settings.isGlutenFree = v);
                },
              ),
              createSwitch(
                "Sem Lactose",
                "Só exibe refeições sem Lactose",
                settings.isLactoseFree,
                (v) {
                  setState(() => settings.isLactoseFree = v);
                },
              ),
              createSwitch(
                "Vegana",
                "Só exibe refeições Vegana",
                settings.isVegan,
                (v) {
                  setState(() => settings.isVegan = v);
                },
              ),
              createSwitch(
                "Vegetariana",
                "Só exibe refeições Vegetariana",
                settings.isVegetarian,
                (v) {
                  setState(() => settings.isVegetarian = v);
                },
              ),
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
