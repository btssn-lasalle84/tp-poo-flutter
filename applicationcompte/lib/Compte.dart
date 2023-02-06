import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Compte extends ChangeNotifier {
  String _titulaire = "";
  double _solde = 0.0;
  String _devise = "EUR";
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  Compte.defaut(this._titulaire) {
    recuperer();
  }

  Compte(this._titulaire, this._solde, this._devise);

  String get titulaire => _titulaire;
  double get solde => _solde;
  String get devise => _devise;

  String getSolde() {
    return _solde.toString();
  }

  void crediter(double montant) {
    _solde += montant;
    enregistrer();
    notifyListeners();
  }

  bool debiter(double montant) {
    if (_solde - montant >= 0) {
      _solde -= montant;
      enregistrer();
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> enregistrer() async {
    final SharedPreferences preferences = await _preferences;
    preferences
        .setStringList("compte", [_titulaire, _solde.toString(), _devise]);
  }

  Future<void> recuperer() async {
    final SharedPreferences preferences = await _preferences;

    if (preferences.getStringList("compte") != null) {
      List<String>? compte = preferences.getStringList("compte");
      if (compte != null) {
        if (this._titulaire == compte[0]) _solde = double.parse(compte[1]);
        _devise = compte[2];
        notifyListeners();
      }
    }
  }

  Future<void> supprimer() async {
    final SharedPreferences preferences = await _preferences;
    preferences.remove("compte");
    _titulaire = "";
    _solde = 0.0;
    _devise = "EUR";
    notifyListeners();
  }
}
