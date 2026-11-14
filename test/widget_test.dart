import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Smoke test CATSU Lost and Found App loads and displays dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const CatsuLostAndFoundApp());
    await tester.pumpAndSettle();

    // Verify CATSU header and Mabuhay greeting are present
    expect(find.text('CATSU Lost & Found'), findsWidgets);
    expect(find.text('Mabuhay, Jansen Lee!'), findsOneWidget);
    expect(find.text('Report Lost Item'), findsOneWidget);
    expect(find.text('Report Found Item'), findsOneWidget);
  });
}
