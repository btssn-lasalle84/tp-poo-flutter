import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'Compte.dart';

Future<void> main() async {
  runApp(ApplicationCompte());
}

class ApplicationCompte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Application Compte',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Compte.defaut("Moi"),
      child: Accueil(),
    );
  }
}

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);
  @override
  _Accueil createState() => new _Accueil();
}

class _Accueil extends State<Accueil> {
  Compte? _compte;
  TextEditingController montant = new TextEditingController();

  @override
  void initState() {
    super.initState();
    print("initState()");
  }

  @override
  Widget build(BuildContext context) {
    print("[Accueil]");
    _compte = Provider.of<Compte>(context);
    print(
        "Compte : ${_compte!.titulaire} ${_compte!.solde} ${_compte!.devise}");
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Compte'),
      ),
      body: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text(
              "Solde",
              style: new TextStyle(
                  fontSize: 18.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
            ),
            new Text(
              _compte!.getSolde(),
              style: new TextStyle(
                  fontSize: 18.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
            ),
            Padding(padding: EdgeInsets.only(bottom: 25)),
            new Text(
              "Montant",
              style: new TextStyle(
                  fontSize: 18.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
            ),
            new TextField(
              controller: montant,
              style: new TextStyle(
                  fontSize: 18.0,
                  color: const Color(0xFF000000),
                  fontWeight: FontWeight.w200,
                  fontFamily: "Roboto"),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                LengthLimitingTextInputFormatter(15),
              ],
              /*inputFormatters: [FilteringTextInputFormatter.digitsOnly],*/
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'saisir un montant',
                isDense: true,
                contentPadding: EdgeInsets.all(10),
                border: InputBorder.none,
              ),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                      key: null,
                      onPressed: crediter,
                      color: const Color(0xFFe0e0e0),
                      child: new Text(
                        "Créditer",
                        style: new TextStyle(
                            fontSize: 12.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      )),
                  Padding(padding: EdgeInsets.only(right: 10)),
                  new RaisedButton(
                      key: null,
                      onPressed: debiter,
                      color: const Color(0xFFe0e0e0),
                      child: new Text(
                        "Débiter",
                        style: new TextStyle(
                            fontSize: 12.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      ))
                ])
          ]),
    );
  }

  void crediter() {
    if (!montant.text.isEmpty) {
      print(
          "créditer ${montant.text} : ${_compte!.titulaire} ${_compte!.solde} ${_compte!.devise}");
      _compte!.crediter(double.parse(montant.text));
    }
  }

  void debiter() {
    if (!montant.text.isEmpty) {
      print(
          "débiter ${montant.text} : ${_compte!.titulaire} ${_compte!.solde} ${_compte!.devise}");
      _compte!.debiter(double.parse(montant.text));
    }
  }
}
