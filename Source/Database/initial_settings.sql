-- #######################################################################################
-- SentraQ initial settings, please replace all <todo> accordingly!
-- 2026-02-10
-- Copyright (c) 2026 Stefan Watermann, www.watermann-it.de
-- DO NOT CHANGE <todo> HERE! Replace all <todo> with real values in your database ONLY.
-- #######################################################################################

-- DELETE FROM public."Setting";
INSERT INTO public."Setting" ("Key","Value") VALUES
	('Controller:Mqtt:Broker:Hostname','localhost'),
	('Controller:Mqtt:Broker:Port','1883'),
	('Controller:Mqtt:Broker:Username','<todo>'),
	('Controller:Mqtt:Broker:Password','<todo>'),
	('Controller:Mqtt:ClientTopic','<todo>'),
	('Controller:FrontendApi:ApiAuthKey','<todo>'),
	('Controller:FrontendApi:Url','http://localhost:9004/api/update/realtime/'),
	('Api:RequiredAuthKey','<todo>'),
	('Mail:Server:Name','<todo>'),
	('Mail:Server:Port','465')
	('Mail:Server:User','<todo>'),
	('Mail:Server:Password','<todo>'),
	('Alert:Mail:ResendMinutes','15'),
	('Alert:Mail:FrontendUrl','<todo>'),
	('Alert:Mail:Subject','STÖRUNG in Station ''{Station.ShortName}'''),
	('Alert:Mail:Body','<p>
Es ist eine Störung in Station <b>{Station.ShortName}</b> aufgetreten.
</p>
<p>
Zeitpunkt: {Alert.FirstEventTs} <br/>
Störung: {Component.DisplayName} (#{Component.HardwareId})
</p>
<p>
<a href="{FrontendUrl},{Station.Uid}">Störung quittieren</a>
</p>');
