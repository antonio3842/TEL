-- Table stock distributeurs alimentaires (persistance BDD)
CREATE TABLE IF NOT EXISTS `distributeur_alimentaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pos` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `stock` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
