import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'dart:convert';

// ignore: avoid_web_libraries_in_flutter
//import 'dart:js' as js;

class PdfConverter {
  static Future<List<int>> converter() async {
    final Document pdf = Document(
      pageMode: PdfPageMode.fullscreen,
      title: "Berichtsheft",
    );

    Map<String, dynamic> data = {
      "nummer": 98798789,
      "name": "Khalil Khalil",
      "ausbildungsberuf": "Fachinformatiker Anwendungsentwicklung",
      "ausbildungsjahr": 2,
      "ausbildungsmonatVon": "01-02-2020",
      "ausbildungsmonatBis": "29-02-2020",
      "ausbildendeAbteilung": "BlaBlaBla",
      "berichte": [
        {
          "text": "One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour-like back, \nand if he lifted his"
           "head.",
          "hours": 10
        },
        {
          "text": "One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour-like back, \nand if he lifted his"
           "head.",
          "hours": 10
        },
      ],
    };

    //js.context.callMethod('ready', [json.encode(data)]);

    return pdf.document.save();
  }

  static PdfDocument generateDocument() {
    final pdf = new PdfDocument();
    final page = new PdfPage(pdf, pageFormat: PdfPageFormat.a4);
    return pdf;
  }
}
