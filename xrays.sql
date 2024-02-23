-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Φιλοξενητής: 127.0.0.1
-- Χρόνος δημιουργίας: 19 Φεβ 2024 στις 21:21:45
-- Έκδοση διακομιστή: 5.6.24
-- Έκδοση PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Βάση δεδομένων: `xrays`
--

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `command`
--

CREATE TABLE IF NOT EXISTS `command` (
  `idCommand` int(11) NOT NULL,
  `description` varchar(45) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `command`
--

INSERT INTO `command` (`idCommand`, `description`) VALUES
(6, 'X-ray chest'),
(8, 'MRI shoulder L'),
(9, 'MRI knee L'),
(10, 'X-ray hand L'),
(11, 'X-ray chest'),
(12, 'MRI knee R'),
(13, 'X-ray chest'),
(14, 'X-ray hand R');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `doctor`
--

CREATE TABLE IF NOT EXISTS `doctor` (
  `idDoctor` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `adt` varchar(45) NOT NULL,
  `telephone` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `doctor`
--

INSERT INTO `doctor` (`idDoctor`, `name`, `surname`, `adt`, `telephone`) VALUES
(1, 'Γεώργιος', 'Παπακώστας', 'Α00012321', '6976557894'),
(2, 'Ελένη', 'Σχοινά', 'Α66675445', '6977988451');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `doctor_issues_command`
--

CREATE TABLE IF NOT EXISTS `doctor_issues_command` (
  `id` int(11) NOT NULL,
  `Doctor_idDoctor` int(11) NOT NULL,
  `Command_idCommand` int(11) NOT NULL,
  `Patient_idPatient` int(11) NOT NULL,
  `issue_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `doctor_issues_command`
--

INSERT INTO `doctor_issues_command` (`id`, `Doctor_idDoctor`, `Command_idCommand`, `Patient_idPatient`, `issue_date`) VALUES
(3, 1, 6, 3, '2024-02-05 08:26:07'),
(4, 1, 8, 3, '2024-02-11 16:03:17'),
(5, 1, 9, 3, '2024-02-11 16:40:48'),
(6, 1, 10, 4, '2024-02-11 19:33:36'),
(7, 1, 11, 1, '2024-02-12 21:45:45'),
(8, 1, 12, 2, '2024-02-17 17:50:56'),
(9, 1, 13, 2, '2024-02-17 20:11:35'),
(10, 1, 14, 2, '2024-02-19 22:16:34');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `executes`
--

CREATE TABLE IF NOT EXISTS `executes` (
  `id` int(11) NOT NULL,
  `radiologist_idRadiologist` int(11) NOT NULL,
  `command_idCommand` int(11) NOT NULL,
  `patient_idPatient` int(11) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `executes`
--

INSERT INTO `executes` (`id`, `radiologist_idRadiologist`, `command_idCommand`, `patient_idPatient`, `date`) VALUES
(1, 1, 11, 1, '2024-02-12 22:54:15');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `folder`
--

CREATE TABLE IF NOT EXISTS `folder` (
  `idFolder` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `Patient_idPatient` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `folder`
--

INSERT INTO `folder` (`idFolder`, `created`, `Patient_idPatient`) VALUES
(1, '2024-01-01 00:00:00', 1),
(2, '2024-01-11 00:00:00', 2),
(3, '2024-01-21 00:00:00', 3),
(4, '2024-01-12 00:00:00', 4),
(5, '2024-01-14 00:00:00', 5);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `folder_has_command`
--

CREATE TABLE IF NOT EXISTS `folder_has_command` (
  `id` int(11) NOT NULL,
  `Folder_idFolder` int(11) NOT NULL,
  `Command_idCommand` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `folder_has_command`
--

INSERT INTO `folder_has_command` (`id`, `Folder_idFolder`, `Command_idCommand`) VALUES
(1, 3, 6),
(3, 3, 8),
(4, 3, 9),
(5, 4, 10),
(6, 1, 11),
(7, 2, 12),
(8, 2, 13),
(9, 2, 14);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `folder_has_report`
--

CREATE TABLE IF NOT EXISTS `folder_has_report` (
  `id` int(11) NOT NULL,
  `Folder_idFolder` int(11) NOT NULL,
  `Report_idReport` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `folder_has_report`
--

INSERT INTO `folder_has_report` (`id`, `Folder_idFolder`, `Report_idReport`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `patient`
--

CREATE TABLE IF NOT EXISTS `patient` (
  `idPatient` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `adt` varchar(45) NOT NULL,
  `birthday` date NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telephone` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `patient`
--

INSERT INTO `patient` (`idPatient`, `name`, `surname`, `adt`, `birthday`, `address`, `email`, `telephone`) VALUES
(1, 'Δημήτρης', 'Δήμου', 'Α00001324', '2000-05-11', 'Λεωφόρος Κηφισίας 56, Μαρούσι', 'ddimou@unipei.gr', '6974551227'),
(2, 'Μαρία', 'Σχοινά', 'Α001236666', '1999-06-21', 'Τροίας 5, Χαλάνδρι', 'mschoina@papei.gr', '6977789887'),
(3, 'Γεωργία', 'Σωτηρίου', 'Α001234444', '1996-03-23', 'Μενελάου 2, Πατήσια', 'gsot@papei.gr', '6942355712'),
(4, 'Γεώργιος', 'Πάγκος', 'Α001232312', '1997-08-21', 'Μενεξέδων 11, Μαρούσι', 'gpagkos@papei.gr', '6930554597'),
(5, 'Μάριος', 'Ιωάννου', 'Α12321235', '2000-07-17', 'Σίνα 5, Παγκράτι', 'miannou@papei.gr', '6933457880');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `patient_has_doctor`
--

CREATE TABLE IF NOT EXISTS `patient_has_doctor` (
  `id` int(11) NOT NULL,
  `Patient_idPatient` int(11) NOT NULL,
  `Doctor_idDoctor` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `patient_has_doctor`
--

INSERT INTO `patient_has_doctor` (`id`, `Patient_idPatient`, `Doctor_idDoctor`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `radiologist`
--

CREATE TABLE IF NOT EXISTS `radiologist` (
  `idRadiologist` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `adt` varchar(45) NOT NULL,
  `telephone` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `radiologist`
--

INSERT INTO `radiologist` (`idRadiologist`, `name`, `surname`, `adt`, `telephone`) VALUES
(1, 'Καλλίτσα', 'Τζιουρτζιώτη', 'Α00004889', '6979778845'),
(2, 'Ευάγγελος', 'Τσιμίχας', 'Α00493583', '6977557898');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `radiologist_issues_report`
--

CREATE TABLE IF NOT EXISTS `radiologist_issues_report` (
  `id` int(11) NOT NULL,
  `Radiologist_idRadiologist` int(11) NOT NULL,
  `Report_idReport` int(11) NOT NULL,
  `Command_idCommand` int(11) NOT NULL,
  `Patient_idPatient` int(11) NOT NULL,
  `issue_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `radiologist_issues_report`
--

INSERT INTO `radiologist_issues_report` (`id`, `Radiologist_idRadiologist`, `Report_idReport`, `Command_idCommand`, `Patient_idPatient`, `issue_date`) VALUES
(1, 1, 1, 11, 1, '2024-02-12 22:53:20');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `idReport` int(11) NOT NULL,
  `description` varchar(1500) NOT NULL DEFAULT ''
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `report`
--

INSERT INTO `report` (`idReport`, `description`) VALUES
(1, 'Simple muscle injury.');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `idUser` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `Doctor_idDoctor` int(11) DEFAULT NULL,
  `Patient_idPatient` int(11) DEFAULT NULL,
  `Radiologist_idRadiologist` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

--
-- Άδειασμα δεδομένων του πίνακα `user`
--

INSERT INTO `user` (`idUser`, `username`, `password`, `type`, `Doctor_idDoctor`, `Patient_idPatient`, `Radiologist_idRadiologist`) VALUES
(1, 'dimou', 'dimou', 'patient', NULL, 1, NULL),
(2, 'gpapa', 'gpapa', 'doctor', 1, NULL, NULL),
(3, 'kallitsa', 'kallitsa', 'radiologist', NULL, NULL, 1),
(4, 'schoina', 'schoina', 'patient', NULL, 2, NULL),
(5, 'gsot', 'gsot', 'patient', NULL, 3, NULL),
(6, 'pagkos', 'pagkos', 'patient', NULL, 4, NULL),
(7, 'ioannou', 'ioannou', 'patient', NULL, 5, NULL),
(8, 'esch', 'esch', 'doctor', 2, NULL, NULL),
(9, 'tsim', 'tsim', 'radiologist', NULL, NULL, 2);

--
-- Ευρετήρια για άχρηστους πίνακες
--

--
-- Ευρετήρια για πίνακα `command`
--
ALTER TABLE `command`
  ADD PRIMARY KEY (`idCommand`);

--
-- Ευρετήρια για πίνακα `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`idDoctor`);

--
-- Ευρετήρια για πίνακα `doctor_issues_command`
--
ALTER TABLE `doctor_issues_command`
  ADD PRIMARY KEY (`id`,`Doctor_idDoctor`,`Command_idCommand`,`Patient_idPatient`), ADD KEY `fk_Doctor_has_Command_Command1_idx` (`Command_idCommand`), ADD KEY `fk_Doctor_has_Command_Doctor1_idx` (`Doctor_idDoctor`), ADD KEY `fk_Doctor_has_Command_Patient1_idx` (`Patient_idPatient`);

--
-- Ευρετήρια για πίνακα `executes`
--
ALTER TABLE `executes`
  ADD PRIMARY KEY (`id`,`radiologist_idRadiologist`,`command_idCommand`,`patient_idPatient`), ADD KEY `fk_radiologist_has_command_command1_idx` (`command_idCommand`), ADD KEY `fk_radiologist_has_command_radiologist1_idx` (`radiologist_idRadiologist`), ADD KEY `fk_radiologist_has_command_patient1_idx` (`patient_idPatient`);

--
-- Ευρετήρια για πίνακα `folder`
--
ALTER TABLE `folder`
  ADD PRIMARY KEY (`idFolder`), ADD KEY `fk_Folder_Patient1_idx` (`Patient_idPatient`);

--
-- Ευρετήρια για πίνακα `folder_has_command`
--
ALTER TABLE `folder_has_command`
  ADD PRIMARY KEY (`id`,`Folder_idFolder`,`Command_idCommand`), ADD KEY `fk_Folder_has_Command_Command1_idx` (`Command_idCommand`), ADD KEY `fk_Folder_has_Command_Folder1_idx` (`Folder_idFolder`);

--
-- Ευρετήρια για πίνακα `folder_has_report`
--
ALTER TABLE `folder_has_report`
  ADD PRIMARY KEY (`id`,`Folder_idFolder`,`Report_idReport`), ADD KEY `fk_Folder_has_Report_Report1_idx` (`Report_idReport`), ADD KEY `fk_Folder_has_Report_Folder_idx` (`Folder_idFolder`);

--
-- Ευρετήρια για πίνακα `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`idPatient`), ADD UNIQUE KEY `adt_UNIQUE` (`adt`);

--
-- Ευρετήρια για πίνακα `patient_has_doctor`
--
ALTER TABLE `patient_has_doctor`
  ADD PRIMARY KEY (`id`,`Patient_idPatient`,`Doctor_idDoctor`), ADD KEY `fk_Patient_has_Doctor_Doctor1_idx` (`Doctor_idDoctor`), ADD KEY `fk_Patient_has_Doctor_Patient1_idx` (`Patient_idPatient`);

--
-- Ευρετήρια για πίνακα `radiologist`
--
ALTER TABLE `radiologist`
  ADD PRIMARY KEY (`idRadiologist`);

--
-- Ευρετήρια για πίνακα `radiologist_issues_report`
--
ALTER TABLE `radiologist_issues_report`
  ADD PRIMARY KEY (`id`,`Radiologist_idRadiologist`,`Report_idReport`,`Command_idCommand`,`Patient_idPatient`), ADD KEY `fk_Radiologist_has_Report_Report1_idx` (`Report_idReport`), ADD KEY `fk_Radiologist_has_Report_Radiologist1_idx` (`Radiologist_idRadiologist`), ADD KEY `fk_Radiologist_has_Report_Command1_idx` (`Command_idCommand`), ADD KEY `fk_Radiologist_has_Report_Patient1_idx` (`Patient_idPatient`);

--
-- Ευρετήρια για πίνακα `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`idReport`);

--
-- Ευρετήρια για πίνακα `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`), ADD KEY `fk_User_Doctor1_idx` (`Doctor_idDoctor`), ADD KEY `fk_User_Patient1_idx` (`Patient_idPatient`), ADD KEY `fk_User_Radiologist1_idx` (`Radiologist_idRadiologist`);

--
-- AUTO_INCREMENT για άχρηστους πίνακες
--

--
-- AUTO_INCREMENT για πίνακα `command`
--
ALTER TABLE `command`
  MODIFY `idCommand` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT για πίνακα `doctor`
--
ALTER TABLE `doctor`
  MODIFY `idDoctor` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT για πίνακα `doctor_issues_command`
--
ALTER TABLE `doctor_issues_command`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT για πίνακα `executes`
--
ALTER TABLE `executes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT για πίνακα `folder`
--
ALTER TABLE `folder`
  MODIFY `idFolder` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT για πίνακα `folder_has_command`
--
ALTER TABLE `folder_has_command`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT για πίνακα `folder_has_report`
--
ALTER TABLE `folder_has_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT για πίνακα `patient`
--
ALTER TABLE `patient`
  MODIFY `idPatient` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT για πίνακα `patient_has_doctor`
--
ALTER TABLE `patient_has_doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT για πίνακα `radiologist`
--
ALTER TABLE `radiologist`
  MODIFY `idRadiologist` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT για πίνακα `radiologist_issues_report`
--
ALTER TABLE `radiologist_issues_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT για πίνακα `report`
--
ALTER TABLE `report`
  MODIFY `idReport` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT για πίνακα `user`
--
ALTER TABLE `user`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- Περιορισμοί για άχρηστους πίνακες
--

--
-- Περιορισμοί για πίνακα `doctor_issues_command`
--
ALTER TABLE `doctor_issues_command`
ADD CONSTRAINT `fk_Doctor_has_Command_Command1` FOREIGN KEY (`Command_idCommand`) REFERENCES `command` (`idCommand`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Doctor_has_Command_Doctor1` FOREIGN KEY (`Doctor_idDoctor`) REFERENCES `doctor` (`idDoctor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Doctor_has_Command_Patient1` FOREIGN KEY (`Patient_idPatient`) REFERENCES `patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Περιορισμοί για πίνακα `executes`
--
ALTER TABLE `executes`
ADD CONSTRAINT `fk_radiologist_has_command_command1` FOREIGN KEY (`command_idCommand`) REFERENCES `command` (`idCommand`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_radiologist_has_command_patient1` FOREIGN KEY (`patient_idPatient`) REFERENCES `patient` (`idPatient`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `fk_radiologist_has_command_radiologist1` FOREIGN KEY (`radiologist_idRadiologist`) REFERENCES `radiologist` (`idRadiologist`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Περιορισμοί για πίνακα `folder`
--
ALTER TABLE `folder`
ADD CONSTRAINT `fk_Folder_Patient1` FOREIGN KEY (`Patient_idPatient`) REFERENCES `patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Περιορισμοί για πίνακα `folder_has_command`
--
ALTER TABLE `folder_has_command`
ADD CONSTRAINT `fk_Folder_has_Command_Command1` FOREIGN KEY (`Command_idCommand`) REFERENCES `command` (`idCommand`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Folder_has_Command_Folder1` FOREIGN KEY (`Folder_idFolder`) REFERENCES `folder` (`idFolder`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Περιορισμοί για πίνακα `folder_has_report`
--
ALTER TABLE `folder_has_report`
ADD CONSTRAINT `fk_Folder_has_Report_Folder` FOREIGN KEY (`Folder_idFolder`) REFERENCES `folder` (`idFolder`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Folder_has_Report_Report1` FOREIGN KEY (`Report_idReport`) REFERENCES `report` (`idReport`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Περιορισμοί για πίνακα `patient_has_doctor`
--
ALTER TABLE `patient_has_doctor`
ADD CONSTRAINT `fk_Patient_has_Doctor_Doctor1` FOREIGN KEY (`Doctor_idDoctor`) REFERENCES `doctor` (`idDoctor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Patient_has_Doctor_Patient1` FOREIGN KEY (`Patient_idPatient`) REFERENCES `patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Περιορισμοί για πίνακα `radiologist_issues_report`
--
ALTER TABLE `radiologist_issues_report`
ADD CONSTRAINT `fk_Radiologist_has_Report_Command1` FOREIGN KEY (`Command_idCommand`) REFERENCES `command` (`idCommand`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Radiologist_has_Report_Patient1` FOREIGN KEY (`Patient_idPatient`) REFERENCES `patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Radiologist_has_Report_Radiologist1` FOREIGN KEY (`Radiologist_idRadiologist`) REFERENCES `radiologist` (`idRadiologist`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_Radiologist_has_Report_Report1` FOREIGN KEY (`Report_idReport`) REFERENCES `report` (`idReport`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Περιορισμοί για πίνακα `user`
--
ALTER TABLE `user`
ADD CONSTRAINT `fk_User_Doctor1` FOREIGN KEY (`Doctor_idDoctor`) REFERENCES `doctor` (`idDoctor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_User_Patient1` FOREIGN KEY (`Patient_idPatient`) REFERENCES `patient` (`idPatient`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_User_Radiologist1` FOREIGN KEY (`Radiologist_idRadiologist`) REFERENCES `radiologist` (`idRadiologist`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
