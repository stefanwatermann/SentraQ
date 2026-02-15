# SentraQ
## Visualisierung, Alarmierung und Monitoring für Wasser- oder Energienetze

Ein Softwaresystem zur Datensammlung, Visualisierung und Alarmierung für Einrichtungen der Wasserversorgung oder von Energienetzen.

Copyright (c) 2026 Stefan Watermann, Watermann IT, Auetal (Germany) - www.watermann-it.de.

Dies ist freie Software, lizensiert unter der GPL 3.0 Lizenz. Siehe LICENSE (bzw. LIZENZ.MD) für die vollständige Lizenzinformation.

-

Sentraq empfängt und verarbeitet MQTT Daten aus physischen Vor-Ort Stationen (z.B. Pumpstation) und stellt diese über ein web-basiertes Frontend dar.
Fehlersituationen können Alarme auslösen (z.B. Hochwasser), sodass Mitarbeiter schnell reagieren können und alle erforderlichen Informationen sofort zur Verfügung haben.

Sentraq besteht aus einem Web-Frontend, einem MQTT Broker, verschiedenen Backend Diensten (Controller, API, Watchdog), sowie einer PostgreSQL Datenbank.

<bild architektur>

## Source/Frontend
Das Sentraq Frontend stellt die vorhandenen Stationen (On-Site Anlagen) als Liste oder auf einer Karte dar. Jede Station verfügt über ein oder mehrere Komponenten, wie Aktoren, Sensoren, Zähler oder Meldungen.
Das Frontend als eine XOJO Web-Application implementiert.

<bild frontend>

## Source/Backend
Der Sentraq Controller nimmt MQTT Nachrichten vom MQTT Broker entgegen, speichert diese in der Datenbank und sendet geänderte Daten direkt an das Frontend zur Darstellung im Browser. Weiterhin steuert der Controller alle internen Abläufe, wie Alarmierungen oder die Betriebstundenzähler. Das API implementiert RESTful Services und dient dem Frontend als Datenquelle, da das Frontend selbst keinen direkten Zugriff auf die Datenbank hat. Der Watchdog überwacht den regelmäßigen Eingang von MQTT Nachrichten auf Stations-Basis und erzeugt einen Alarm, falls eine Station keine neuen Nachrichten mehr sendet (z.B. wegen Stromausfall vor Ort).
Das Backend verwendet die Open-Source Produkten mosquitto als MQTT Broker und PostgreSQL als relationale Datenbank. Der Controller, das API und der Watchdog sind Microsoft dotnet Core 9 Implementierungen.
