#import "template/template.typ": diagram
#import "@preview/lovelace:0.3.0": *

#show figure: set block(breakable: true)

= Analyse

== Auftrag durchführen vom Erstkontakt bis zur Bezahlung der Rechnung

Da das erste Szenario "Auftrag durchführen vom Erstkontakt bis zur Bezahlung der Rechnung" lautet,
wird der gesamte Prozess von der Anfrage bis zur Archivierung des Auftrags beschrieben. Da dieses
Szenario das zweite Szenario "Materialbestellungen für obigen Auftrag durchführen" beinhaltet und
damit inherent mehr Akteure besitzt, wurde sich dazu entschieden das Sequenzdiagramm für dieses
Szenario zu erstellen.

Um die Erstellung zu vereinfachen wurde zuerst Pseudocode für das Szenario erstellt. Sobald der
Pseudocode nicht mehr groß verändert wurde, wurde das Sequenzdiagramm erstellt.

#figure(
  pseudocode-list[
    + *START* _Auftrag durchführen vom Erstkontakt bis zur Bezahlung der Rechnung_

      + Kunde stellt Anfrage zum Streichen zweier Office-Räume (E-Mail)
      + Anfrage entgegennehmen und beantworten
      + *FALLS* Kunde nicht in Datenbasis
        + *SOLANGE* Noch nicht alle benötigten Daten vorhanden
          + Stelle Rückfrage an Kunden
          + *WARTE* Auf Antwort des Kunden
        + Erstelle Kundenprofil

      + Erstelle vorläufigen Auftrag (noch kein Start- und End-Termin)
      + Verknüpfe Auftrag mit Kundenprofil

      + *SOLANGE* Kein Besichtigungstermin gefunden
        + Neuen Besichtigungstermin vorschlagen
        + *WARTE* Auf Antwort des Kunden

      + Besichtigungstermin erstellen
      + Besichtigungstermin mit vorläufigem Auftrag verknüpfen

      + *FÜHRE* _Besichtigungstermin wahrnehmen_ *AUS*

      + Füge gemachte Notizen und Fotos zum Auftrag hinzu

      + *FÜHRE* _Angebot berechnen_ *AUS*

      + *FÜHRE* _Sende berechnetes Angebot an Kunden_ *AUS*

      + *SOLANGE* Kunde akzeptiert Angebot nicht
        + Verhandlung mit Kunden führen
        + *FALLS* Verhandlung erfolgreich
          + Vereinbare Start- und End-Termin mit Kunden
          + Speichere Start- und End-Termin im Auftrag
          + Angebot anpassen
          + *FÜHRE* _Sende Angebot an Kunden_ *AUS*
        + *SONST*
          + *FÜHRE* _Auftrag archivieren_ als _nicht erfolgreich_ *AUS*
          + *ENDE* Auftrag durchführen

      + *FÜHRE* _Materialbestellung für Auftrag_ *AUS*

      + *FÜHRE* _Zimmer streichen_ *AUS*
        + *FALLS* Auftrag nicht erfolgreich
          + *FÜHRE* _Auftrag archivieren_ als nicht erfolgreich *AUS*
          + *ENDE* Auftrag durchführen
        + *SONST*
          + *FÜHRE* _Auftrag archivieren_ als erfolgreich *AUS*

    + *ENDE* _Auftrag durchführen vom Erstkontakt bis zur Bezahlung der Rechnung_
  ],
  caption: [Auftrag durchführen],
  supplement: "Pseudocode",
)

Hierbei wurden Teile des Pseudocodes, die den Hauptprogrammfluss unterbrechen, in eigene
Verfeinerungen ausgelagert. Diese Verfeinerungen sind in den folgenden Abschnitten beschrieben.

#figure(
  pseudocode-list[
    + *START* _Besichtigungstermin wahrnehmen_
      + *FALLS* Kunde nicht an Besichtigungsort anwesend
        // + *FÜHRE* _Neuen Besichtigungstermin vereinbaren_ *AUS*
        + *ENDE* Besichtigungstermin
      + Treffe Kunden
      + *WÄHREND* Auf Besichtigungstermin
        + Mache Notizen und Fotos
    + *ENDE* _Besichtigungstermin wahrnehmen_
  ],
  caption: [Besichtigungstermin wahrnehmen],
  supplement: "Pseudocode",
)

Wichtig bei der Umsetzung von "Besichtigungstermin wahrnehmen" ist, dass der bisherige
Akteur ("Bearbeiter") nicht umbedingt mit dem Kunden interagiert, sondern auch ein anderer
Mitarbeiter die Besichtigung durchführen kann.


#figure(
  pseudocode-list[
    + *START* _Angebot berechnen_
      + Betrachte Notizen und Fotos und Berate zu Anforderungen (Material, Mitarbeiter, Arbeitszeit, Werkzeuge)

      + *PARALLEL*
        + Erstelle Material- und Werkzeugliste
        + Erstelle Mitarbeiter- und Arbeitszeitliste

      + Betrachte Listen, Anforderungen und erstelle und speichere Angebot. Verknüpfe mit Auftrag
    + *ENDE* _Angebot berechnen_
  ],
  caption: [Angebot berechnen],
  supplement: "Pseudocode",
)

#figure(
  pseudocode-list[
    + *START* _Sende berechnetes Angebot an Kunden_
      + *FALLS* Kontaktoption
        + *IST* E-Mail
          + Sende Angebot per E-Mail
        + *IST* Post
          + Sende Angebot per Post
        + *IST* Fax
          + Sende Angebot per Fax
    + *ENDE* _Sende berechnetes Angebot an Kunden_
  ],
  caption: [Sende berechnetes Angebot an Kunden],
  supplement: "Pseudocode",
)

== Sequenzdiagramm

#figure(
  image("./diagrams/Sequenzdiagramm/Hauptdiagramm.svg", width: 91%),
  caption: [Sequenzdiagramm, Szenario: Auftrag durchführen vom Erstkontakt bis zur Bezahlung der Rechnung],
)

=== Unterdiagramm: Auftrag finden

#figure(
  image("./diagrams/Sequenzdiagramm/Verfeinerung-Auftrag-finden.svg"),
  caption: [Sequenzdiagramm, Szenario: Auftrag finden],
)

=== Unterdiagramm: Besichtigungstermin anlegen

#figure(
  image("./diagrams/Sequenzdiagramm/Verfeinerung-Besichtigungstermin-anlegen.svg"),
  caption: [Sequenzdiagramm, Szenario: Besichtigungstermin anlegen],
)

=== Unterdiagramm: Besichtigungstermin wahrnehmen

#figure(
  image(
    "./diagrams/Sequenzdiagramm/Verfeinerung-Besichtigungstermin-wahrnehmen.svg",
    width: 90%,
  ),
  caption: [Sequenzdiagramm, Szenario: Besichtigungstermin wahrnehmen],
)

== Materialbestellungen für obigen Auftrag durchführen

#pseudocode-list[

  + *BEGINNE* Materialbestellung für Auftrag

  + *FÜHRE* Auftrag aus System abrufen *AUS*

  + *FÜHRE* Erstelle allgemeine Bestellliste *AUS*

  + *FÜHRE* Materialbedarf bestimmen *AUS*

  + *FÜR JEDES* Material *IN* Materialbedarf

    + *FÜHRE* Bestimme Bestand in Lager *AUS*

    + *WENN* Lagerbestand *KLEINER ALS* Benötigte Menge

      + *FÜHRE* Füge zu allgemeiner Bestellliste hinzu *AUS*

    + *ENDE-WENN*

  + *FÜR JEDES* Material *IN* allgemeine Bestellliste

    + *FÜHRE* Ermittle günstigsten Lieferanten *AUS*

    + *WENN* Keine Bestellliste für diesen Lieferanten

      + *FÜHRE* Erstelle eine Bestellliste für diesen Lieferanten *AUS*

    + *ENDE-WENN*

    + *FÜHRE* Füge Material zu Bestellliste von Lieferanten hinzu *AUS*

  + *FÜR JEDE* Bestellliste

    + *FÜHRE* Erstelle Bestellung *AUS*

    + *FÜHRE* Sende Bestellung an Lieferanten *AUS*

  + *ENDE* Materialbestellung für Auftrag

]


#pseudocode-list[

  + *BEGINNE* Auftrag aus System abrufen

  + *SOLANGE* Auftrag nicht gefunden

    + Nächsten Auftrag mit gesuchter Identifikationsnummer abgleichen

    + *WENN* Identifikationsnummern gleich sind

      + Gebe gefundenen Auftrag zurück

    + *ELSE WENN* alle Aufträge durchsucht

      + Fehlermeldung anzeigen

      + Vorgang beenden

    + *ENDE-WENN*

  + *ENDE* Auftrag aus System abrufen

]


#pseudocode-list[

  + *BEGINNE* Erstelle allgemeine Bestellliste

  + Eindeutige Identifikation des Auftrags auslesen

  + Bestellliste erzeugen

  + Referenz auf Auftrag der Bestellliste hinzufügen

  + Bestellliste im Datenbanksystem speichern

  + *ENDE* Erstelle allgemeine Bestellliste

]


#pseudocode-list[

  + *BEGINNE* Materialbedarf bestimmen

  + Anforderungen des Auftrags untersuchen

  + Liste für Materialien erzeugen

  + *FÜR JEDE* Anforderung

    + Benötigte Materialien bestimmen

    + Materialien in die Liste aufnehmen

  + Liste mit allen benötigten Materialien zurückgeben

  + *ENDE* Materialbedarf bestimmen

]


#pseudocode-list[

  + *BEGINNE* Bestimme Bestand in Lager

  + *FÜR JEDEN* Artikel *IN* Bestellliste

    + Zähler auf 0 setzen

    + *FÜR JEDEN* Artikel *IN* Lager

      + *WENN* Artikel im Lager mit dem Artikel aus der Bestellliste übereinstimmt

        + Zähler um 1 erhöhen

      + *ENDE-WENN*

    + Zähler für den Artikel als Bestand speichern

  + *ENDE* Bestimme Bestand in Lager

]


#pseudocode-list[

  + *BEGINNE* Füge zu allgemeiner Bestellliste hinzu

  + Kalkuliere noch benötigte Materialanzahl

  + Füge benötigte Material zur Bestellliste hinzu

  + *ENDE* Füge zu allgemeiner Bestellliste hinzu

]


#pseudocode-list[

  + *BEGINNE* Ermittle günstigsten Lieferanten

  + Nach Lieferanten recherchieren

  + *FÜR JEDEN* Lieferanten

    + *WENN* Lieferant das gesuchte Material hat

      + *WENN* Lieferant das bis jetzt günstigste Angebot hat

        + Lieferant merken

      + *ENDE-WENN*

    + *ENDE-WENN*

  + Zuletzt gemerkten Lieferanten als günstigsten Lieferanten speichern

  + *ENDE* Ermittle günstigsten Lieferanten

]


#pseudocode-list[

  + *BEGINNE* Erstelle eine Bestellliste für diesen Lieferanten

  + Datenbanksystem für Informationen über Lieferant anfragen

  + *WENN* Lieferant nicht im Datenbanksystem

    + "Nicht gefunden"-Fehlermeldung anzeigen

    + Programmablauf stoppen

  + *ENDE-WENN*

  + Eindeutige Identifikation des Lieferanten auslesen

  + Neue Bestellliste erzeugen

  + Referenz zum Lieferanten hinzufügen

  + Bestellliste im Datenbanksystem abspeichern

  + *ENDE* Erstelle eine Bestellliste für diesen Lieferanten

]


#pseudocode-list[

  + *BEGINNE* Füge Material zu Bestellliste von Lieferanten hinzu

  + Datenbanksystem für Informationen über Lieferant anfragen

  + *WENN* Lieferant nicht im Datenbanksystem

    + "Nicht gefunden"-Fehlermeldung anzeigen

    + Programmablauf stoppen

  + *ENDE-WENN*

  + Eindeutige Identifikation des Lieferanten auslesen

  + Bestellliste des Lieferanten im Datenbanksystem finden

  + *WENN* Bestellliste nicht gefunden werden konnte

    + "Datenkorruption"-Fehlermeldung anzeigen

    + Programmablauf stoppen

  + *ENDE-WENN*

  + Material zur Bestellliste hinzufügen

  + *ENDE* Füge Material zu Bestellliste von Lieferanten hinzu

]


#pseudocode-list[

  + *BEGINNE* Erstelle Bestellung

  + Bestellung erzeugen

  + *FÜR JEDEN* Artikel *IN* Bestellliste

    + Artikel der Bestellung hinzufügen mit Quantität

  + Firmenangaben tätigen

  + Lieferadresse hinzufügen

  + Rechnungsadresse hinzufügen

  + Email und Telefonnummer hinzufügen

  + *ENDE* Erstelle Bestellung

]


#pseudocode-list[

  + *BEGINNE* Sende Bestellung an Lieferanten

  + Bestellungsanfrage an Lieferanten stellen

  + Setze Status der Bestellung auf "Angefragt"

  + *WARTE* auf Antwort des Lieferanten

  + *WENN* Bestellungsanfrage abgelehnt wird

    + Setze Status der Bestellung auf "Abgelehnt"

    + Prozess neu ausführen

  + *ELSE*

    + Setze Status der Bestellung auf "Bestellt"

    + *WARTE* bis Bestellung geliefert wird

    + Setze Status der Bestellung auf "Abgeschlossen"

  + *ENDE-WENN*

  + *ENDE* Sende Bestellung an Lieferanten

]

  supplement: "Pseudocode",
  caption: [Materialbestellung für Auftrag],
)
