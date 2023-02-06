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
  testWidgets('gui', (WidgetTester tester) async {
    await tester.pumpWidget(ApplicationCompte());

    // Widgets Text
    expect(find.text('Solde'), findsOneWidget);
    expect(find.text('Montant'), findsOneWidget);
    //expect(find.text('1'), findsNothing);
    final compte = Compte.defaut("Moi");
    double solde = compte.solde;
    expect(find.text(solde.toString()), findsOneWidget);

    // Widgets RaisedButton
    expect(find.text("Créditer"), findsOneWidget);
    expect(find.text("Débiter"), findsOneWidget);

    await tester.enterText(find.byType(TextField), '100.0');
    // Tap Créditer
    await tester.tap(find.text("Créditer"));
    await tester.pump();
    solde += 100.0;
    expect(find.text(solde.toString()), findsWidgets);

    await tester.enterText(find.byType(TextField), '50.0');
    // Tap Créditer
    await tester.tap(find.text("Débiter"));
    await tester.pump();
    solde -= 50.0;
    expect(find.text(solde.toString()), findsWidgets);
  });
}
