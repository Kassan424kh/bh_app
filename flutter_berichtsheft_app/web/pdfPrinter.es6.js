const createNewPage = (doc, data) => {
    // Default export is a4 paper, portrait, using millimeters for units
    doc.setFontSize(11)
    var marginTop = 20
    var space = 12

    // Ausbildungsnachweis (monatlich)                                 Nummer:______
    doc.setFontType('bold').text(15, marginTop, 'Ausbildungsnachweis')
    doc.setFontType('normal').text(57, marginTop, '(monatlich)')
    doc.setFontType('normal').text(140, marginTop, 'Nummer: ')
    doc.setFontType('bold').text(157, marginTop - 1, data.nummer.toString())
    doc.line(157, marginTop, 195, marginTop) // horizontal line

    // Name des/der Auszubildenden:__________________________________________________
    doc.setFontType('normal').text(15, marginTop + space, 'Name des/der Auszubildenden: ')
    doc.setFontType('bold').text(70, marginTop + space - 1, data.name)
    doc.line(70, marginTop + space, 195, marginTop + space) // horizontal line

    // Ausbildungsberuf:___________________________________ Ausbildungsjahr:_________
    doc.setFontType('normal').text(15, marginTop + (space * 2), 'Ausbildungsberuf: ')
    doc.setFontType('bold').text(47, marginTop + (space * 2) - 1, data.ausbildungsberuf)
    doc.line(47, marginTop + (space * 2), 153, marginTop + (space * 2)) // horizontal line
    doc.setFontType('normal').text(155, marginTop + (space * 2), 'Ausbildungsjahr: ')
    doc.setFontType('bold').text(189, marginTop + (space * 2) - 1, data.ausbildungsjahr.toString())
    doc.line(185, marginTop + (space * 2), 195, marginTop + (space * 2)) // horizontal line

    // Ausbildungsmonat vom_________bis_________ ggf. ausbildende Abteilung:__________
    doc.setLineWidth(0.5)
    doc.setFontType('normal').text(15, marginTop + (space * 3), 'Ausbildungsmonat vom')
    doc.setFontType('bold').text(57.5, marginTop + (space * 3) - 1, data.ausbildungsmonatVon)
    doc.line(57, marginTop + (space * 3), 78, marginTop + (space * 3)) // horizontal line
    doc.setFontType('normal').text(80, marginTop + (space * 3), 'bis')
    doc.setFontType('bold').text(87.5, marginTop + (space * 3) - 1, data.ausbildungsmonatBis)
    doc.line(87, marginTop + (space * 3), 108, marginTop + (space * 3)) // horizontal line
    doc.setFontType('normal').text(112, marginTop + (space * 3), 'ggf. ausbildende Abteilung: ')
    doc.setFontType('bold').text(160, marginTop + (space * 3) - 1, data.ausbildendeAbteilung)
    doc.line(160, marginTop + (space * 3), 195, marginTop + (space * 3)) // horizontal line
    doc.setLineWidth(0.25)

    // Table
    doc.setDrawColor(0, 0, 0)
    doc.setFillColor(0, 0, 0, 0.20)
    doc.rect(15, marginTop + (space * 4), 180, 15, "DF")
    doc.rect(175, marginTop + (space * 4), 20, 15, "DF")
    doc.setFontType('bold').text(17, marginTop + (space * 4.37), 'Betriebliche Tätigkeiten, Unterweisungen, Lehrgespräche, sonstige Schulungen,')
    doc.setFontType('bold').text(17, marginTop + (space * 4.8), 'Themen des Berufsschulunterrichts, ggf. Fehlzeiten.')

    doc.setDrawColor(0, 0, 0)
    doc.setFillColor(255, 255, 255)
    doc.rect(15, marginTop + (space * 5), 180, 160, "DF")
    doc.rect(175, marginTop + (space * 5), 20, 160, "DF")
    doc.setFontType('bold').text(177, marginTop + (space * 4.37), 'Stunden')

    var lengthOfTextLines = 0
    data.berichte.map(function (report, index) {
        var _index = index + 1
        var splitTitle = doc.splitTextToSize(report.text, 155);
        doc.setFontType('normal').text(17, marginTop + (space * (5.5 + (index === 0 ? 0 : lengthOfTextLines))), splitTitle)
        doc.setFontType('normal').text(177, marginTop + (space * (5.5 + (index === 0 ? 0 : lengthOfTextLines))), "10")

        if (index > 0 ){
            doc.line(15, marginTop + (space * (5.5 + (index === 0 ? 0 : lengthOfTextLines - 0.4))), 195, marginTop + (space * (5.5 + (index === 0 ? 0 : lengthOfTextLines - 0.4))))  // horizontal line
        }
        lengthOfTextLines += splitTitle.length / 2.3
    })

    // segnator
    var text = 'Durch die nachfolgenden Unterschriften wird die Richtigkeit und Vollständigkeit der obigen Angaben bestätigt.'
    var splitTitle = doc.splitTextToSize(text, 170);
    doc.setFontType('normal').text(15, marginTop + (space * 18.9), splitTitle)

    doc.setFontSize(8)

    doc.setFontType('normal').text(15, marginTop + (space * 20.6), 'Datum, Unterschrift Auszubildende/r')
    doc.line(15, marginTop + (space * 20.3), 90, marginTop + (space * 20.3)) // horizontal line
    doc.setFontType('normal').text(110, marginTop + (space * 20.6), 'Datum, Unterschrift des Ausbilders/der Ausbilderin')
    doc.line(110, marginTop + (space * 20.3), 195, marginTop + (space * 20.3)) // horizontal line

    doc.setFontType('normal').text(15, marginTop + (space * 22), 'Datum, Unterschrift gesetzlicher Vertreter')
    doc.line(15, marginTop + (space * 21.7), 90, marginTop + (space * 21.7)) // horizontal line
    doc.setFontType('normal').text(110, marginTop + (space * 22) , 'Datum, ggf. weitere Sichtvermerke')
    doc.line(110, marginTop + (space * 21.7), 195, marginTop + (space * 21.7)) // horizontal line
}

function ready(data) {
  let dataAsJson = JSON.parse(data);

  // Default export is a4 paper, portrait, using millimeters for units
  var doc = new jsPDF()
  doc.autoPrint();
  var oHiddFrame = document.createElement("iframe");

  createNewPage(doc, dataAsJson)
  doc.addPage()
  createNewPage(doc, dataAsJson)

  //doc.save ("Wochentlich_pdf.pdf");
  oHiddFrame.src = doc.output('bloburl');
  document.body.appendChild(oHiddFrame);
}