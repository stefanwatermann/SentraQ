# SentraQ - Visualisierung, Alarmierung und Monitoring für Wasser- oder Energienetze

Ein freies Softwaresystem zur Datensammlung, Visualisierung und Alarmierung für Einrichtungen der Wasserversorgung oder von Energienetzen.

Sentraq empfängt und verarbeitet MQTT Daten aus physischen Vor-Ort Stationen (z.B. Pumpstation) und stellt diese über ein web-basiertes Frontend dar.
Fehlersituationen können Alarme auslösen (z.B. Hochwasser), sodass Mitarbeiter schnell reagieren können und alle erforderlichen Informationen sofort zur Verfügung haben.

Sentraq besteht aus einem Web-Frontend, einem MQTT Broker, verschiedenen Backend Diensten (Controller, API, Watchdog), sowie einer PostgreSQL Datenbank.

![SentraQ Architecture](/Documentation/SentraqArchitecture.png)

## Backend
Der Sentraq Controller nimmt MQTT Nachrichten vom MQTT Broker entgegen, speichert diese in der Datenbank und sendet geänderte Daten direkt an das Frontend zur Darstellung im Browser. Weiterhin steuert der Controller alle internen Abläufe, wie Alarmierungen oder Betriebstundenzähler. Das API implementiert RESTful Services und dient dem Frontend als Datenquelle, da das Frontend selbst keinen direkten Zugriff auf die Datenbank hat. Der Watchdog überwacht den regelmäßigen Eingang von MQTT Nachrichten auf Stations-Basis und erzeugt einen Alarm, falls eine Station keine neuen Nachrichten mehr sendet (z.B. wegen Stromausfall vor Ort).

Das Backend verwendet die Open-Source Produkte mosquitto als MQTT Broker und PostgreSQL als relationale Datenbank. Der Controller, das API und der Watchdog sind Microsoft dotnet 9 Implementierungen.

## Frontend
Das Sentraq Frontend stellt die vorhandenen Stationen (On-Site Anlagen) als Liste oder auf einer Karte dar. Jede Station verfügt über eine oder mehrere Komponenten, wie Aktoren, Sensoren, Zähler oder Meldungen. 

![SentraQ Architecture](/Documentation/SentraqFrontend.png)

Das Frontend ist als XOJO Web-Application implementiert.

## Copyright und Lizenz
Copyright (c) 2026 Stefan Watermann, Watermann IT, Auetal (Germany) - www.watermann-it.de.

SentraQ ist freie Software, lizensiert unter der GPL 3.0 Lizenz. Siehe LICENSE (bzw. LIZENZ.MD) für die vollständige Lizenzinformation.
