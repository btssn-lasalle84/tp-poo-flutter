// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:applicationcompte/main.dart';
import 'package:applicationcompte/Compte.dart';

void main() {
  group('Compte', () {
    test('accesseurs', () {
      final compte = Compte.defaut("Moi");

      expect(compte.titulaire, "Moi");
      expect(compte.devise, "EUR");
    });

    test('crediter', () {
      final compte = Compte.defaut("Moi");

      double solde = compte.solde;
      compte.crediter(100.0);

      expect(compte.solde, (solde + 100.0));
    });

    test('debiter', () {
      final compte = Compte.defaut("Moi");

      double solde = compte.solde;
      if (solde - 100.0 < 0)
        solde = 0;
      else
        solde -= 100.0;
      compte.debiter(100.0);
      expect(compte.solde, solde);

      compte.crediter(150.0);
      compte.debiter(100.0);
      expect(compte.solde, 50.0);
    });
  });
}
