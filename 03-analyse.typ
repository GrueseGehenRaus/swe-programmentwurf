#import "template/template.typ"
#import "@preview/lovelace:0.3.0": *

= Analyse

== Pseudocode: Auftrag durchführen vom Erstkontakt bis zur Bezahlung der Rechnung

#pseudocode-list[
  + *BEGINNE* Auftrag durchführen

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

    + *FÜHRE* _Besichtigungstermin_ *AUS*

    + Füge gemachte Notizen und Fotos zum Auftrag hinzu

    + *FÜHRE* _Angebot berechnen_ *AUS*

    + *FÜHRE* _Sende Angebot an Kunden_ *AUS*

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

  + *ENDE* Auftrag durchführen
]

#pseudocode-list[
  + *BEGINNE* Besichtigungstermin
    + *FALLS* Kunde nicht anwesend
      + *FÜHRE* _Neuen Besichtigungstermin vereinbaren_ *AUS*
      + *ENDE* Besichtigungstermin
    + Treffe Kunden
    + *WÄHREND* Auf Besichtigungstermin
      + Mache Notizen und Fotos
  + *ENDE* Besichtigungstermin
]

#pseudocode-list[
  + *BEGINNE* Angebot berechnen
    + Betrachte Notizen und Fotos und Berate zu Anforderungen (Material, Mitarbeiter, Arbeitszeit, Werkzeuge)

    + *PARALLEL*
      + Erstelle Material- und Werkzeugliste
      + Erstelle Mitarbeiter- und Arbeitszeitliste

    + Betrachte Listen, Anforderungen und erstelle und speichere Angebot. Verknüpfe mit Auftrag
  + *ENDE* Angebot berechnen
]

#pseudocode-list[
  + *BEGINNE* Sende Angebot an Kunden
    + *FALLS* Kontaktoption
      + *IST* E-Mail
        + Sende Angebot per E-Mail
      + *IST* Post
        + Sende Angebot per Post
      + *IST* Fax
        + Sende Angebot per Fax
  + *ENDE* Sende Angebot an Kunden
]

== Diagramme

#figure(
  image("Abgabe.svg"),
  caption: [Foo],
)

== Pseudocode: Materialbestellungen für obigen Auftrag durchführen

#pseudocode-list[
  + *BEGINNE* Materialbestellung für Auftrag
  + *FÜHRE* Auftrag aus System abrufen *AUS*
  + *FÜHRE* Erstelle allgemeine Bestellliste *AUS*
  + *FÜHRE* Materialbedarf bestimmen *AUS*
  + *FÜR JEDES* Material *IN* Materialbedarf
    + *FÜHRE* Bestimme Bestand in Lager *AUS*
    + *FALLS* Lagerbestand *KLEINER ALS* Benötigte Menge
      + *FÜHRE* Füge zu allgemeiner Bestellliste hinzu *AUS*
  + *FÜR JEDES* Material *IN* allgemeine Bestellliste
    + *FÜHRE* Ermittle günstigsten Lieferanten *AUS*
    + *FALLS* Keine Bestellliste für diesen Lieferanten
      + *FÜHRE* Erstelle eine Bestellliste für diesen Lieferanten *AUS*
    + *FÜHRE* Füge Material zu Bestellliste von Lieferanten hinzu *AUS*
  + *FÜR JEDE* Bestellliste
    + *FÜHRE* Erstelle Bestellung *AUS*
    + *FÜHRE* Sende Bestellung an Lieferanten *AUS*
  + *ENDE* Materialbestellung für Auftrag
]
