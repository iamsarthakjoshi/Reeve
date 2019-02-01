DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `workspaceURL` varchar(255) NOT NULL DEFAULT '',
  `subscriptionId` int(3) NOT NULL DEFAULT '1',
  `subscriptionStartDate` datetime DEFAULT NULL,
  `subscriptionEndDate` datetime DEFAULT NULL,
  `billingCycle` int(2) DEFAULT NULL,
  `defaultLanguage` int(11) unsigned NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_default_language_id` (`defaultLanguage`),
  CONSTRAINT `FK_default_language_id` FOREIGN KEY (`defaultLanguage`) REFERENCES `languages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `clientStyling`;

CREATE TABLE `clientStyling` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `clientId` int(11) unsigned NOT NULL,
  `logoImage` varchar(255) DEFAULT NULL,
  `backgroundImage` varchar(255) DEFAULT NULL,
  `backgroundColor` varchar(32) DEFAULT NULL,
  `primaryColor` varchar(32) DEFAULT NULL,
  `secondaryColor` varchar(32) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_clientId_style` (`clientId`),
  CONSTRAINT `FK_clientId_style` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `emailTemplates`;

CREATE TABLE `emailTemplates` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(11) unsigned NOT NULL,
  `language` int(11) unsigned NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `html` text NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Email_Type` (`type`),
  KEY `FK_Email_Language` (`language`),
  CONSTRAINT `FK_Email_Language` FOREIGN KEY (`language`) REFERENCES `languages` (`id`),
  CONSTRAINT `FK_Email_Type` FOREIGN KEY (`type`) REFERENCES `emailTypes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `emailTemplates` WRITE;
/*!40000 ALTER TABLE `emailTemplates` DISABLE KEYS */;

INSERT INTO `emailTemplates` (`id`, `type`, `language`, `name`, `description`, `subject`, `html`, `createdAt`, `updatedAt`)
VALUES
	(1,1,1,'Client Welcome','Introductory email (with activation link) on client registration','Welcome to Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Welcome to Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Dear <%= firstName %>,</p>\n		<p>Congratulations! You\'ve just joined a phenominal SaaS company, and an amazing trial product to enjoy for the next 30 days.</p>\n		<p>Please click the following link to verify your email address <a href=\"<%= validationLink %>\"><%= validationLink %></a>.</p>\n		<p>Once your email is verified, you can continue to access your account from the following link <a href=\"<%= workspaceURL %>\"><%= workspaceURL %></a>.</p>\n 		<p>Please reply to this email if you have any suggestions/feedback.</p>\n		<p>Best Regards,<br>Reeve Customer Support</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. All Rights Reserved.\n        </div>\n    </body>\n</html>','2018-07-18 11:59:16','2018-07-18 11:59:16'),
	(2,2,1,'Verify Email','User email verification link email','Please verify your email address | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Please verify your email address | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Dear <%= firstName %>,</p>\n		<p>Please click the following link to verify your email address with Reeve <a href=\"<%= validationLink %>\"><%= validationLink %></a>.</p>\n		<p>A verified email address allows you to receive account notifications and ensures you receive updates relating to our product.</p>\n 		<p>Please reply to this email if you have any suggestions/feedback.</p>\n		<p>Best Regards,<br>Reeve Customer Support</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. All Rights Reserved.\n        </div>\n    </body>\n</html>','2018-08-01 21:45:00','2018-08-01 21:45:03'),
	(3,3,1,'Forgot Account Details','Email containing account details associated with an email address for all client','Forgot Account Details | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Forgot Account Details | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Hi there!</p>\n		<p>You recently entered your email address into the forgot account details page on Reeve. We want to help you get back into your account.</p>\n		<p>The accounts linked to this email address include:</p>\n		<div>\n			<% accounts.forEach(function(account){ %>\n				<p>\n					<b>Client:</b> <%= account.clientName %><br>\n					<b>FirstName:</b> <%= account.firstName %><br>\n					<b>LastName:</b> <%= account.lastName %><br>\n					<b>Login Link:</b> <a href=\"<%= account.workspaceLink %>\"><%= account.workspaceLink %></a><br>\n					<b>Reset Password Link:</b> <a href=\"<%= account.resetPasswordLink %>\"><%= account.resetPasswordLink %></a>\n				</p>\n  			<% }); %>\n		</div>\n		<p>Best Regards,<br>Reeve Customer Support</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. All Rights Reserved.\n        </div>\n    </body>\n</html>','2018-08-04 17:33:49','2018-08-04 17:33:49'),
	(4,4,1,'Reset Password','Email with link to reset account password','Reset Password | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Reset Password | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Dear <%= firstName %>,</p>\n		<p>You recently entered your email address into the forgot account details page of the workspace <b><%= clientName %></b>. We want to help you get back into your account.</p>\n		<p>You can use the following link below to reset the password to your account:</p>\n		<div><a href=\"<%= resetPasswordLink %>\"><%= resetPasswordLink %></a></div>\n		<p>Best Regards,<br>Reeve Customer Support</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. All Rights Reserved.\n        </div>\n    </body>\n</html>','2018-08-05 19:52:34','2018-08-05 19:52:34'),
	(5,5,1,'Password Reset Success','Success email when a user resets their password','Your account password has changed | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Reset Password | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Dear <%= firstName %>,</p>\n		<p>We are sending you this email to confirm that the password to your account on the workspace <%= workspaceName %> has recently been updated.</p>\n		<p>If you did not make this change. Please contact support immediately by replying to this email.</p>\n		<p>Best Regards,<br>Reeve Customer Support</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. All Rights Reserved.\n        </div>\n    </body>\n</html>','2018-08-11 18:27:34','2018-08-11 18:27:36'),
	(6,1,2,'Benvenuto del cliente','Email introduttiva (con link di attivazione) sulla registrazione del cliente','Benvenuto a Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Benvenuto a Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Caro <%= firstName %>,</p>\n		<p>Congratulazioni! Hai appena aderito a una società fenomenale SaaS e un fantastico prodotto di prova da provare per i prossimi 30 giorni.</p>\n		<p>Fare clic sul seguente collegamento per verificare il proprio indirizzo email <a href=\"<%= validationLink %>\"><%= validationLink %></a>.</p>\n		<p>Una volta verificata la tua email, puoi continuare ad accedere al tuo account dal seguente link <a href=\"<%= workspaceURL %>\"><%= workspaceURL %></a>.</p>\n 		<p>Si prega di rispondere a questa e-mail se avete suggerimenti.</p>\n		<p>I migliori saluti,<br>Reeve Servizio Clienti</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. Tutti i diritti riservati.\n        </div>\n    </body>\n</html>','2018-10-06 10:07:59','2018-10-06 10:07:59'),
	(7,2,2,'Verifica Email','Email del link di verifica email utente','Per favore verifica il tuo indirizzo email | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Per cortesia verifichi il suo indirizzo email | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Caro <%= firstName %>,</p>\n		<p>Fare clic sul seguente collegamento per verificare il proprio indirizzo email con Reeve <a href=\"<%= validationLink %>\"><%= validationLink %></a>.</p>\n		<p>Un indirizzo email verificato consente di ricevere notifiche sull\'account e garantisce di ricevere aggiornamenti relativi al nostro prodotto.</p>\n 		<p>Si prega di rispondere a questa e-mail se avete qualche suggerimento.</p>\n		<p>I migliori saluti,<br>Reeve Servizio Clienti</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. Tutti i diritti riservati.\n        </div>\n    </body>\n</html>','2018-10-06 10:07:59','2018-10-06 10:07:59'),
	(8,3,2,'Hai dimenticato i dettagli dell\'account','Email contenente i dettagli dell\'account associati a un indirizzo email per tutti i client','Hai dimenticato i dettagli del conto | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Hai dimenticato i dettagli dell\'account | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Ciao!</p>\n		<p>Di recente hai inserito il tuo indirizzo email nella pagina dei dettagli dell\'account dimenticata su Reeve. Vogliamo aiutarti a tornare nel tuo account.</p>\n		<p>Gli account collegati a questo indirizzo email includono:</p>\n		<div>\n			<% accounts.forEach(function(account){ %>\n				<p>\n					<b>Cliente:</b> <%= account.clientName %><br>\n					<b>Nome di battesimo:</b> <%= account.firstName %><br>\n					<b>Cognome:</b> <%= account.lastName %><br>\n					<b>Link di accesso:</b> <a href=\"<%= account.workspaceLink %>\"><%= account.workspaceLink %></a><br>\n					<b>Reimposta collegamento password:</b> <a href=\"<%= account.resetPasswordLink %>\"><%= account.resetPasswordLink %></a>\n				</p>\n  			<% }); %>\n		</div>\n		<p>I migliori saluti,<br>Reeve Servizio Clienti</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. Tutti i diritti riservati.\n        </div>\n    </body>\n</html>','2018-10-06 10:07:59','2018-10-06 10:07:59'),
	(9,4,2,'Resetta la password','Email con link per reimpostare la password dell\'account','Reimposta password | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Resetta la password | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Caro <%= firstName %>,</p>\n		<p>Di recente hai inserito il tuo indirizzo email nella pagina dei dettagli dell\'account dimenticata dello spazio di lavoro <b><%= clientName %></b>. Vogliamo aiutarti a tornare nel tuo account.</p>\n		<p>Puoi utilizzare il seguente link qui sotto per reimpostare la password sul tuo account:</p>\n		<div><a href=\"<%= resetPasswordLink %>\"><%= resetPasswordLink %></a></div>\n		<p>I migliori saluti,<br> Reeve Servizio Clienti</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. Tutti i diritti riservati.\n        </div>\n    </body>\n</html>','2018-10-06 10:07:59','2018-10-06 10:07:59'),
	(10,5,2,'Password reimpostata con successo','Email di successo quando un utente reimposta la propria password','La password del tuo account è cambiata | Reeve','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n    <head>\n        <meta name=\"viewport\" content=\"width=device-width\">\n        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n        <title>Resetta la password | Reeve</title>\n        <style>\n            img {max-width: 100%; height: auto;}\n        </style>\n</head>\n    <body>\n        <div id=\"content\">\n		<p>Caro <%= firstName %>,</p>\n		<p>Ti stiamo inviando questa email per confermare la password del tuo account nell\'area di lavoro <%= workspaceName %> è stato recentemente aggiornato.</p>\n		<p>Se non hai fatto questo cambiamento. Contatta immediatamente l\'assistenza rispondendo a questa email.</p>\n		<p>I migliori saluti,<br>Reeve Servizio Clienti</p>\n	</div>\n	<br><br>\n        <div id=\"footer\">\n	&copy; Copyright 2018 Reeve. Tutti i diritti riservati.\n        </div>\n    </body>\n</html>','2018-10-06 10:07:59','2018-10-06 10:07:59');

/*!40000 ALTER TABLE `emailTemplates` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `emailTypes`;

CREATE TABLE `emailTypes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `emailTypes` WRITE;
/*!40000 ALTER TABLE `emailTypes` DISABLE KEYS */;

INSERT INTO `emailTypes` (`id`, `name`, `description`, `createdAt`, `updatedAt`)
VALUES
	(1,'Client Welcome Email','Introductory email when a new client account is created','2018-07-16 22:05:10','2018-07-16 22:05:15'),
	(2,'Verify Email','Contains validation link to verify user email (Can be sent multiple times)','2018-08-01 21:41:23','2018-08-01 21:41:26'),
	(3,'Forgot Account Details','Email with workspace url and reset account links for all users associated with an email address','2018-08-04 08:34:34','2018-08-04 08:34:38'),
	(4,'Forgot Password','Email with link to reset account password','2018-08-05 19:48:26','2018-08-05 19:48:26'),
	(5,'Reset Password Success','When a users password is reset, send an email notifying the user','2018-08-11 18:27:44','2018-08-11 18:27:46');

/*!40000 ALTER TABLE `emailTypes` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `emailVerificationCode`;

CREATE TABLE `emailVerificationCode` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `verificationCode` varchar(255) NOT NULL DEFAULT '',
  `activated` tinyint(1) NOT NULL,
  `userId` int(11) unsigned NOT NULL,
  `clientId` int(11) unsigned NOT NULL,
  `gracePeriod` int(2) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_evc_userId` (`userId`),
  KEY `FK_evc_clientId` (`clientId`),
  CONSTRAINT `FK_evc_clientId` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `FK_evc_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `executedScripts`;

CREATE TABLE `executedScripts` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `createdDate` datetime NOT NULL,
  `executedDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `executedScripts` WRITE;
/*!40000 ALTER TABLE `executedScripts` DISABLE KEYS */;

INSERT INTO `executedScripts` (`name`, `description`, `createdDate`, `executedDate`)
VALUES
	('180420_01','Create and populate executed_scripts table','2018-11-24 12:42:16','2018-11-24 12:42:16'),
	('180517_01','Create new client and subscription tables','2018-11-24 12:42:16','2018-11-24 12:42:16'),
	('180523_01','Create new user table','2018-11-24 12:42:17','2018-11-24 12:42:17'),
	('180524_01','Create new role tables and foreign keys','2018-11-24 12:42:17','2018-11-24 12:42:17'),
	('180601_01','Create new client styling table','2018-11-24 12:42:17','2018-11-24 12:42:17'),
	('180601_02','Create new features table','2018-11-24 12:42:18','2018-11-24 12:42:18'),
	('180601_03','Link features to subscriptionFeatures table','2018-11-24 12:42:18','2018-11-24 12:42:18'),
	('180602_01','Clean up client table and organize subscriptions','2018-11-24 12:42:18','2018-11-24 12:42:18'),
	('180603_01','Set subscription id as required','2018-11-24 12:42:19','2018-11-24 12:42:19'),
	('180708_01','Add createdAt and updatedAt columns','2018-11-24 12:42:19','2018-11-24 12:42:19'),
	('180708_01','Added createdAt and updatedAt columns to subscriptionFeatures','2018-11-24 12:42:19','2018-11-24 12:42:19'),
	('180716_01','New Email and Languages tables','2018-11-24 12:42:20','2018-11-24 12:42:20'),
	('180716_02','Added language column to client and user tables','2018-11-24 12:42:20','2018-11-24 12:42:20'),
	('180716_03','Updated created at table columns','2018-11-24 12:42:20','2018-11-24 12:42:20'),
	('180720_01','Created Client Welcome Email template','2018-11-24 12:42:20','2018-11-24 12:42:20'),
	('180720_02','Created email verification code table','2018-11-24 12:42:21','2018-11-24 12:42:21'),
	('180722_01','Added emailVerified column to user table','2018-11-24 12:42:21','2018-11-24 12:42:21'),
	('180801_01','Verify email template','2018-11-24 12:42:21','2018-11-24 12:42:21'),
	('180804_01','Forgot Account Details Email','2018-11-24 12:42:22','2018-11-24 12:42:22'),
	('180804_02','Create password reset table and add null to clientId, UserId in sentEmail table','2018-11-24 12:42:22','2018-11-24 12:42:22'),
	('180805_01','Email with link to reset user password','2018-11-24 12:42:22','2018-11-24 12:42:22'),
	('180811_01','Reset password success notification email','2018-11-24 12:42:22','2018-11-24 12:42:22'),
	('180816_01','Profile photo table column','2018-11-24 12:42:23','2018-11-24 12:42:23'),
	('180821_01','New billing features and subscriptions','2018-11-24 12:42:23','2018-11-24 12:42:23'),
	('180825_01','Swap subscription start and end dates to dateTime','2018-11-24 12:42:23','2018-11-24 12:42:23'),
	('181003_01','Add italian language to default language set','2018-11-24 12:42:24','2018-11-24 12:42:24'),
	('181006_01','Translate emails to italian','2018-11-24 12:42:24','2018-11-24 12:42:24');

/*!40000 ALTER TABLE `executedScripts` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `failedEmails`;

CREATE TABLE `failedEmails` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clientId` int(11) unsigned DEFAULT NULL,
  `userId` int(11) unsigned DEFAULT NULL,
  `emailType` int(11) unsigned NOT NULL,
  `emailLanguage` int(11) unsigned NOT NULL,
  `to` varchar(255) NOT NULL DEFAULT '',
  `from` varchar(255) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `contents` text NOT NULL,
  `reason` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_fe_userId` (`userId`),
  KEY `FK_fe_clientId` (`clientId`),
  KEY `FK_fe_emailType` (`emailType`),
  KEY `FK_fe_language` (`emailLanguage`),
  CONSTRAINT `FK_fe_clientId` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `FK_fe_emailType` FOREIGN KEY (`emailType`) REFERENCES `emailTypes` (`id`),
  CONSTRAINT `FK_fe_language` FOREIGN KEY (`emailLanguage`) REFERENCES `languages` (`id`),
  CONSTRAINT `FK_fe_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `features`;

CREATE TABLE `features` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;

INSERT INTO `features` (`id`, `name`, `description`, `createdAt`, `updatedAt`)
VALUES
	(1,'Styling','Client can specify their own unique styling, logo image, background, primary and secondary colors',NULL,NULL),
	(2,'Billing','Client can pay an ongoing fee and receive access to the platform',NULL,NULL);

/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `languages`;

CREATE TABLE `languages` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `language` varchar(11) NOT NULL DEFAULT '',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;

INSERT INTO `languages` (`id`, `language`, `createdAt`, `updatedAt`)
VALUES
	(1,'english','2018-08-04 08:35:59','2018-08-04 08:35:59'),
	(2,'italian','2018-10-03 05:46:52','2018-10-03 05:46:52');

/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `passwordReset`;

CREATE TABLE `passwordReset` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `resetCode` varchar(255) NOT NULL DEFAULT '',
  `activated` tinyint(1) NOT NULL,
  `userId` int(11) unsigned NOT NULL,
  `clientId` int(11) unsigned NOT NULL,
  `gracePeriod` int(2) unsigned NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_evc_userId` (`userId`),
  KEY `FK_evc_clientId` (`clientId`),
  CONSTRAINT `passwordreset_ibfk_1` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `passwordreset_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;

INSERT INTO `roles` (`id`, `name`, `description`, `createdAt`, `updatedAt`)
VALUES
	(1,'Owner','Highest level role with access to all subscription features','2018-05-24 00:00:00','2018-05-24 00:00:00'),
	(2,'Administrator','Access to secondary management functions throughout the app','2018-08-21 07:54:16','2018-08-21 07:54:16'),
	(3,'Finance','Finance and payment specific parts of the app','2018-08-21 07:54:37','2018-08-21 07:54:37');

/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `sentEmails`;

CREATE TABLE `sentEmails` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clientId` int(11) unsigned DEFAULT NULL,
  `userId` int(11) unsigned DEFAULT NULL,
  `emailType` int(11) unsigned NOT NULL,
  `emailLanguage` int(11) unsigned NOT NULL,
  `to` varchar(255) NOT NULL DEFAULT '',
  `from` varchar(255) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `contents` text NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_se_clientId` (`clientId`),
  KEY `FK_se_userId` (`userId`),
  KEY `FK_se_emailType` (`emailType`),
  KEY `FK_se_language` (`emailLanguage`),
  CONSTRAINT `FK_se_clientId` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `FK_se_emailType` FOREIGN KEY (`emailType`) REFERENCES `emailTypes` (`id`),
  CONSTRAINT `FK_se_language` FOREIGN KEY (`emailLanguage`) REFERENCES `languages` (`id`),
  CONSTRAINT `FK_se_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `subscriptionFeatures`;

CREATE TABLE `subscriptionFeatures` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `subscriptionId` int(3) unsigned NOT NULL,
  `featureId` int(11) unsigned NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_SubscriptionId` (`subscriptionId`),
  KEY `FK_featureId` (`featureId`),
  CONSTRAINT `FK_SubscriptionId` FOREIGN KEY (`subscriptionId`) REFERENCES `subscriptions` (`id`),
  CONSTRAINT `FK_featureId` FOREIGN KEY (`featureId`) REFERENCES `features` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `subscriptionFeatures` WRITE;
/*!40000 ALTER TABLE `subscriptionFeatures` DISABLE KEYS */;

INSERT INTO `subscriptionFeatures` (`id`, `subscriptionId`, `featureId`, `createdAt`, `updatedAt`)
VALUES
	(1,1,1,NULL,NULL),
	(2,1,2,'2018-08-21 08:04:30','2018-08-21 08:04:35'),
	(3,2,2,'2018-08-21 08:04:32','2018-08-21 08:04:37');

/*!40000 ALTER TABLE `subscriptionFeatures` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `subscriptions`;

CREATE TABLE `subscriptions` (
  `id` int(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;

INSERT INTO `subscriptions` (`id`, `name`, `description`, `active`, `createdAt`, `updatedAt`)
VALUES
	(1,'Trial','Default Trial account when a new client is created',1,NULL,NULL),
	(2,'Basic','Basic paying customer',1,NULL,NULL);

/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `firstName` varchar(255) NOT NULL DEFAULT '',
  `lastName` varchar(255) NOT NULL DEFAULT '',
  `profilePhoto` varchar(255) DEFAULT NULL,
  `clientId` int(11) unsigned NOT NULL,
  `emailAddress` varchar(255) NOT NULL DEFAULT '',
  `emailVerified` tinyint(1) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL DEFAULT '',
  `lastLoginDate` datetime DEFAULT NULL,
  `language` int(11) unsigned NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ClientId` (`clientId`),
  KEY `FK_language_id` (`language`),
  CONSTRAINT `FK_ClientId` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`),
  CONSTRAINT `FK_language_id` FOREIGN KEY (`language`) REFERENCES `languages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `userRoles`;

CREATE TABLE `userRoles` (
  `id` int(21) unsigned NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL,
  `roleId` int(11) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_userId` (`userId`),
  KEY `FK_roleId` (`roleId`),
  CONSTRAINT `FK_roleId` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`),
  CONSTRAINT `FK_userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `executedScripts` (`name`, `description`, `createdDate`, `executedDate`)
VALUES
	('181228_01', 'New stripe plans table', NOW(), NOW());

CREATE TABLE `plans` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `stripeProductId` varchar(128) DEFAULT NULL,
  `newSubscriptionsAllowed` tinyint(1) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `executedScripts` (`name`, `description`, `createdDate`, `executedDate`)
VALUES
	('190109_01', 'Removed redundant columns from database', NOW(), NOW());

ALTER TABLE `plans` DROP `monthlyPrice`;
ALTER TABLE `plans` DROP `yearlyPrice`;

ALTER TABLE `plans`
ADD COLUMN `billingInterval` TINYINT(16) UNSIGNED;

CREATE TABLE `billingIntervals` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

INSERT INTO `billingIntervals` (`id`, `name`, `description`, `createdAt`, `updatedAt`)
VALUES
	(1, 'month', 'Clients are billed on a monthly basis (on the same day of each month)', NOW(), NOW()),
	(2, 'year', 'Clients are billed on a yearly basis', NOW(), NOW());

ALTER TABLE `plans`
ADD COLUMN `price` decimal(6,2) NOT NULL DEFAULT '0.0';

INSERT INTO `executedScripts` (`name`, `description`, `createdDate`, `executedDate`)
VALUES
	('190109_02', 'Added 6 plans to plans table', NOW(), NOW());

INSERT INTO `plans` (`id`, `name`, `description`, `stripeProductId`, `billingInterval`, `currency`, `price`, `newSubscriptionsAllowed`, `active`, `createdAt`, `updatedAt`)
VALUES
	(1, 'Basic Plan Monthly', 'Description of stripe basic plan', 'xxxxxxxxx_stripe', 1, 'aud', 0.00, 1, 1, NOW(), NOW()),
	(2, 'Standard Plan Monthly', 'Description of stripe standard plan', 'xxxxxxxxx_stripe', 1, 'aud', 0.00, 1, 1, NOW(), NOW()),
	(3, 'Professional Plan Monthly', 'Description of stripe professional plan', 'xxxxxxxxx_stripe', 1, 'aud', 0.00, 1, 1, NOW(), NOW()),
	(4, 'Basic Plan Yearly', 'Description of stripe basic plan', 'xxxxxxxxx_stripe', 2, 'aud', 0.00, 1, 1, NOW(), NOW()),
	(5, 'Standard Plan Yearly', 'Description of stripe strandard plan', 'xxxxxxxxx_stripe', 2, 'aud', 0.00, 1, 1, NOW(), NOW()),
	(6, 'Professional Plan Yearly', 'Description of stripe professional plan', 'xxxxxxxxx_stripe', 2, 'aud', 0.00, 1, 1, NOW(), NOW());

INSERT INTO `executedScripts` (`name`, `description`, `createdDate`, `executedDate`)
VALUES
	('190110_01', 'Created currencies table', NOW(), NOW());

CREATE TABLE `currencies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` char(3) NOT NULL DEFAULT '',
  `description` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `currencies` (`id`, `identifier`, `description`, `createdAt`, `updatedAt`)
VALUES
	(1, 'aud', 'Australian Dollar', NOW(), NOW());

UPDATE `plans` SET `currency` = '1' WHERE `id` = 1;
UPDATE `plans` SET `currency` = '1' WHERE `id` = 2;
UPDATE `plans` SET `currency` = '1' WHERE `id` = 3;
UPDATE `plans` SET `currency` = '1' WHERE `id` = 4;
UPDATE `plans` SET `currency` = '1' WHERE `id` = 5;
UPDATE `plans` SET `currency` = '1' WHERE `id` = 6;

ALTER TABLE `plans` MODIFY `currency` int(11) unsigned NOT NULL DEFAULT 1;

INSERT INTO `executedScripts` (`name`, `description`, `createdDate`, `executedDate`)
VALUES
	('190201_01', 'Add new subscriptionID column to plans table', NOW(), NOW());

ALTER TABLE `plans`
ADD COLUMN `subscriptionId` INT(11) UNSIGNED;

INSERT INTO `subscriptions` (`id`, `name`, `description`, `active`, `createdAt`, `updatedAt`)
VALUES
	(2, 'Basic', 'Basic paying customer', 1, NOW(), NOW()),
	(3, 'Standard', 'Standard plan paying customer', 1, NOW(), NOW()),
	(4, 'Professional', 'Professional plan paying customer', 1, NOW(), NOW());

UPDATE `plans` SET `subscriptionId` = '2' WHERE `id` = 1;
UPDATE `plans` SET `subscriptionId` = '3' WHERE `id` = 2;
UPDATE `plans` SET `subscriptionId` = '4' WHERE `id` = 3;
UPDATE `plans` SET `subscriptionId` = '2' WHERE `id` = 4;
UPDATE `plans` SET `subscriptionId` = '3' WHERE `id` = 5;
UPDATE `plans` SET `subscriptionId` = '4' WHERE `id` = 6;
