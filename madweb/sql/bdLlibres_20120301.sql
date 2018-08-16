-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: bdlibros
-- ------------------------------------------------------
-- Server version	5.5.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `autor`
--

DROP TABLE IF EXISTS `autor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `autor` (
  `idAutor` int(11) NOT NULL AUTO_INCREMENT,
  `nomAutor` varchar(50) DEFAULT NULL,
  `cognomAutor` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idAutor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autor`
--

LOCK TABLES `autor` WRITE;
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` VALUES (1,'Toriyama','Akira'),(2,'Miguel','Bose'),(3,'Victoria','Abril');
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classifcontinguts`
--

DROP TABLE IF EXISTS `classifcontinguts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classifcontinguts` (
  `idClassificacio` int(11) NOT NULL AUTO_INCREMENT,
  `classificacio` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idClassificacio`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classifcontinguts`
--

LOCK TABLES `classifcontinguts` WRITE;
/*!40000 ALTER TABLE `classifcontinguts` DISABLE KEYS */;
INSERT INTO `classifcontinguts` VALUES (1,'Aventura'),(2,'Comedia'),(3,'Drama'),(4,'Romance'),(5,'Ciencia ficciÃ³n'),(6,'Torneo'),(7,'AcciÃ³n'),(8,'Magia'),(9,'PsicolÃ³gico'),(10,'Horror'),(11,'Misterio'),(12,'Sobrenatural'),(13,'ErÃ³tico'),(14,'FantasÃ­a'),(15,'Recuentos de la vida'),(16,'Suspenso'),(17,'Seinen'),(18,'Ecchi'),(19,'Shoujo'),(20,'Harem'),(21,'Shounen'),(22,'Yaoi'),(23,'Yuri'),(24,'One Shot');
/*!40000 ALTER TABLE `classifcontinguts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classificacions`
--

DROP TABLE IF EXISTS `classificacions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classificacions` (
  `idElement` int(11) NOT NULL DEFAULT '0',
  `idClassificacio` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idElement`,`idClassificacio`),
  KEY `FKClass` (`idClassificacio`),
  CONSTRAINT `FKElement` FOREIGN KEY (`idElement`) REFERENCES `element` (`idElement`),
  CONSTRAINT `FKClass` FOREIGN KEY (`idClassificacio`) REFERENCES `classifcontinguts` (`idClassificacio`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classificacions`
--

LOCK TABLES `classificacions` WRITE;
/*!40000 ALTER TABLE `classificacions` DISABLE KEYS */;
INSERT INTO `classificacions` VALUES (1,1),(1,2),(2,2),(1,6),(2,8),(1,14),(2,14);
/*!40000 ALTER TABLE `classificacions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `element`
--

DROP TABLE IF EXISTS `element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `element` (
  `idElement` int(11) NOT NULL AUTO_INCREMENT,
  `titol` varchar(150) DEFAULT NULL,
  `idAutor` int(11) DEFAULT NULL,
  `idImatge` int(11) DEFAULT NULL,
  `anyPublicacio` int(11) DEFAULT NULL,
  PRIMARY KEY (`idElement`),
  KEY `FKAutor` (`idAutor`),
  KEY `FKImatgeLlibre` (`idImatge`),
  CONSTRAINT `FKAutor` FOREIGN KEY (`idAutor`) REFERENCES `autor` (`idAutor`),
  CONSTRAINT `FKImatgeLlibre` FOREIGN KEY (`idImatge`) REFERENCES `imatges` (`idImatge`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `element`
--

LOCK TABLES `element` WRITE;
/*!40000 ALTER TABLE `element` DISABLE KEYS */;
INSERT INTO `element` VALUES (1,'Bola de Drac',1,1,1984),(2,'Dr. Slump',1,2,1986);
/*!40000 ALTER TABLE `element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imatges`
--

DROP TABLE IF EXISTS `imatges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imatges` (
  `idImatge` int(11) NOT NULL AUTO_INCREMENT,
  `tipusImatge` varchar(25) NOT NULL,
  `imatge` longblob NOT NULL,
  `tamanyImatge` varchar(25) NOT NULL,
  `image_ctgy` varchar(25) NOT NULL,
  `nomImatge` varchar(50) NOT NULL,
  PRIMARY KEY (`idImatge`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imatges`
--

LOCK TABLES `imatges` WRITE;
/*!40000 ALTER TABLE `imatges` DISABLE KEYS */;
INSERT INTO `imatges` VALUES (1,'image/jpeg','ÿØÿà\0JFIF\0\0\0d\0d\0\0ÿì\0Ducky\0\0\0\0\0<\0\0ÿî\0Adobe\0dÀ\0\0\0ÿÛ\0„\0		\n\n\n\n\r\r\Z\ZÿÀ\0^^\0ÿÄ\0Œ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0!1AaQq‘\"2¡±ÁÑBR#3brá‚ğ’¢ÂCS³Tt5ñ$467G\0\0\0\0\0\0\0\0\0\0\0\0!ÿÚ\0\0\0?\0ıR\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0·F¾öù ¶YQ±t¹|?`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r—<ôVº¦û\0Íu*ó9¼Ï¶O°©ÑtZŒ”×n 1	ÊUØóŸ†~ŸíP\0\0ÒW×ŒåúÛpåáâ+‹ËãP&šMr`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0K˜JÙ[\'\n¹/Š]ˆ\rŸƒ§­ÊO¶O›­Ü,Ô7ûµ.KµúÈªô_e++xkšìa]İ6¦e9\\şô{S+-•Şè±çğËÓëï*Û\'ğA¥ø¥À)~¤Ûî\\•º]:ã(Ã»´\r©ÔQ|[®JIphS˜¹TşïÃê|€”\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0’ŠËç{àúj]½¯Ô×]N–œ¾	|1\\Û‡ªÕ[¨fıÕğÇ±¤,\réÓ_sÅqo¼¦‹j•2ñ%cRôD&¯bšÖ^#Şÿ\0´¨©~íD2«^$½=qBíÏUg®ˆú\"C$Ûyo/¼*Æß©ğ51oà—»/”#µsQ”mOŒxIw2£¯Æ½ aê)_xîjìmú“ã®ÈIÿ\0u´,SÊÃMsO€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0‰N1Yo\néOPúŸ\n{l¿°\rµZº´Õåñv(÷Ù}syo’ô¤´mú›¸¨ôÇñ>5ÒÓíZzñ)şd»ùÔöj4ÔGŞ”cü+Ÿ±T³qÔYîé©“ş&ˆ¸¯-ã{ê³Ù&ÑÙnâ©£²×÷¬oÓ„0Ô‘Út‹ŸSõ²š–:\ryVŸ¯ˆD½ErŠ_ \ZJí,9Ê 0õÚ5şÖ h÷=ÿ\0ió0bJ5z{ò«–Zæ»@Ï-Sş(§ìP\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\ZÎq„\\¤ğÆ¾]v,W÷céï`c[®«KLßÃ\09…ú«æÛoĞ›\"DWGO¤ğğë¥eó/Ø€²«Ô¿ŠÅèŠûJŒşÚã”§ëoÄU¦©g¦1ïxúÀÒÍÃE_Ålxv.?@§¾è×Â¥?RÀÕÄ2ß¿^ÖM1·½Søcóƒ½Ï[/ö˜õ$G-^¦_’(VR|äßÊ\0\0ÈvÉôëaüY^Ô»Vğº©vq‹ú~¢¢P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0î¾ºcÕ7…Ëå`TŒî¾]n™8¯†2÷W­äªkŞ±V½Y~×ö¬ví\"—‰8ø–ss›ê`bıÇA¦X²ØCu}ˆuşkÑEâ˜JŞÿ\0…W,óNª_§TaŞòÆ˜­f÷¸ÛÎçè\\@ï¶|g9KÖÙbÊ7@n˜ 6L\r€d@†ĞQgF¢¹ú$¾=§àŒ¿“ú¾²²•\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\05²È×)<$:Ë%vmén5µ$ù$“Ë}ìŠ¿©ÔW§ÓÎû+­e•gSæíD²´õ(/Å.,š¸åê7mÇQú·Ë…p_1Qñy|_¤\r£ 7R\n’2–,\râÀ’,£tÀİ06ÈLõ\0ê\r®@ÆqÄNåâhº—Ş‚6JÊZßUq~”À\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0µUÖúVgcøa-íl¾Jz—ˆ®*˜òşóíMÇpĞèôò²I¸µ\ZãÏŠôi¬ÿ\0İìS’âì¥KåK xs*\0\0ÑÆARÆAF@H™DŠ@l˜&Ù@jØ—jš³o¯<pœ_ÈÊÍM¤y¢+µp\'\0&\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¶Y\nâå6”W6À¯âj5¦U¼k‹şUõ¼a¦ÒW)É¨®s²O‹õ°8Ÿš›ÍZÇsú‘5qç¬²Ëfì²Ns—97–E{=‚jı’¸>ÈÊ·íh±+ÆN”8¶½V \0\0hÈ\rã ©c ÔĞÅ·É6Q4*µöaz[HbkwGâº¹q.\ZÓ©?ƒª~¨ŒMb~=Mx•Ê*YéÊÃáÌbè§•”È¦@Ã\Z¹è<»oV–È~	ı(D«ú~¶Î&ßùŞ÷ÖTL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\nÚúÜè’ô 1¶ê]úX¹<Ùv}ívü y-÷Yª¿_uV¶¡Tœa_f=&Zh\0=_”-êÑ]^~2—t—ö%yıŞ¯sÔÃ³­µê|Hª€\0†ÒJ©ºÙÆŠÌ³Œ´—ö\\M\ZuØá<O=×Ã>´\\MMUjK8K±®-üåÃS*ğóŒ¿KÂÍ·F¼E6åÁËIg’ô°pmûİXàğº]ETÜ§8uE&±Áú¸0/[¿CTa>¤²ñÂ\\{=\0RÕëõ\ZÆº¢¸6×J}«kêŠq’ÃO“ï3Zº‚±Ôˆ;>Y·ó®¯Ó%ò<%vcÃW5ø£{2Š‰À\0\0\0\0\0\0\0\0\0\0\0\0\0\0SQ9_oí«xí¶^ˆı¬ÏÂÒÛSMB»1WOİ…æİLá­‚á/rß_c%Xó¤PAäûq©ÔUÙ8)šñş±bUo4ÕÑº¹c…Œ½œXä\0«™ò,JèICÂU¸§Æ9æ³èf™C\'8Â¨ârxMñÍúxé¥Á¶¤³&ûd˜9£„e4ñ™vb½<U~-²ğëo‚\\e\'ÜïKÊ™Â/“”’—°\r¨¯Kœ$¥Şù¯ZÖà¸sõ¸ZŒş(ıjÄDV:€uÑòıİ;œå5(üÙ,+ÒÛˆêêŠ2³¬§\0\0\0\0\0\0\0\0\0\0\0\0\0\0¾ªùG¦ª—UÖpŠúßr0…:=<¥)p^õ–>múX7vİ­×jüH¾š«“Wi–¢™×»ìş÷;cÓ.é¯í4mSªÙÕ5‰ÖÜd»Ñ•jOËvª÷zrøMJ?+\\\nèyÆ¯Mo¥Jé#Î@\0igİ~†XUôó\\_q¦Ñã÷Ïf_ÌÉ§Iv<{Pê…–Ï¦Öû\n´”×>ı’Ärù,úií¦:Ëõ7.ªôpü¸vu`1níªÜw	JËa—ÓÁ`Îµ‹²Ÿí®‚Yÿ\0&Š£Ôæ1–y¬•5võJÑ•í%j!ë2ÑÔ¨}şº‰ú&³í*=«)U5÷lYõ<Çë+)À\0\0\0\0\0\0\0\0\0\0\0\0\0E¨¾4Öäø¾I.mö$šZ%«®ık9ÿ\0{\"šóòõ=%üˆ?Ì’ûÏì%jGƒ»å]…ª––oÜ¿Œ;¤¾ÒÂ³æÍ‡¨†®Ü·İ³ù—\'òŠG‚Æßk«_§±}Û#ó¼éüÙWVÛö×b#àZ‘ä \05±fTKª…Üm†a>‹£.ÿ\0¤	u6uT×£Øt·F5asÏ¼±Ôv®kKÔ–Í9]ş^¦<ñ <ô]¦½ğkİ—ašÜ«Z%¨ºÕe™P,ö²Ä®Å—t¨Ã¶+×Ì¬ ²ÖÒîb¬g­˜i°aYVa¦¹¦Ÿ°#Ş]/oñÁOÙ‰\Zef1OÒ€È\0\0\0\0\0\0\0\0\0\0\0\0Ş@ç×uvn7<J?¡É¾×ë`·QV×l¨ÏW&¹¨¾lUe@6®É×dlƒÄàÔ¢ûĞÚj­ãgáÎØå×ö•\"Q”%(IbQmIw¢+Ç@ßtKU±Y$¾:•‰|ŠEHñP\0k) ©toòÚôèmŠÍ¡\Z;›X`h›\\SÀ+lM4ø®@e_.)ò}€k))<à\r|XÁç)`\rğo›“îCWå7Œ8Çµ¾l–¬‰L¨\0\0çgŸ³P›çıY‰¤«Z)uik|ßJOÖ‚&\0\0\0\0\0\0\0\0\0\0\0\0\0£®ĞÆØõG„—×4À×C­sµÕ~®1>S_h-û`–šRÕic;ãd;bı+¸–5+†@ĞùO_ÓlôsxŒıú³ø»QbThĞx\ZÅ©‚ü»ş.é¯´U)·Ùåû¨·–ë•oäÊÇ°©^%ÅÆN/šm?ŠÀ\0\0b›Vµ.—)v\Z•,Ilà—%ò••wu~œ¾î#LcÅ“ø`ß¯5ygóß(¨úø^O×Îxõ\"i‡ñ7/[\Z¸ÙSZåA²Ir@d\0\0\0\0õşS·«n•}µØı‰bWKGÁYc¢É$»›ê_3*,\0\0\0\0\0\0\0\0\0\0\0\0\0\0£¯ĞFØåp’âšæ˜\ZèµÎOöº¬xœ£\'Êkí‡¿lNŞ«IĞøÙZû½ë¸–5+„A%N‹át>:ä¤¾@=¶ª÷]Ÿ0çdTëî’ìúŠÓM§Á®\rw¢+×yJŞ­¾uÿ\0»±ÿ\0¤“,Jó[^ã©¯JÉcÔø‘U€\0\r&°ø 5TT¾êe®K\0d\0\0\0\0\0\0\0\0\0=“­÷õ5zTgõ%wª÷u—Çñ(Ïæéÿ\0T¨°\0\0\0\0\0\0\0\0\0\0\0\0\0\0v‚6Ç+ƒ\\S\\òº-t¥/Úêñâò„Ÿ)¯´ı°=;–«KĞøÙZû½ë¸–5+„Aé|¥¯øôS|xÎ¯­%Pó.ƒöÚ÷l*¿Ş]ÒíB¬\\ò}¸·SVyÆ3KÔÚH‰T¼ÍW‡»MöYËæÀ«¢\0\0\0\0\0\0\0\0\0\0\0\0çËˆÆ‹åğ×\'ê‹xm{”øÇMf;ã¤ï–öv›Se÷ÃÃ‹J‹æÛe‰]©æ:Úßdà×ù­?¬¨°\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\nZím‹ib\\Ó\\òztœ¿k«ıGÂ|¦½¼.ÿ\0°:µZH·Ky²µ÷{×q,jWI©›S^¢·ïVóë]¨ƒØîÚj÷=«®ŸyãÄ¥÷®Â¤yÿ\0+Úëİ£^$%î?Jjßœ*ÅÚ{qÁÆQoÔóõŠ‘çˆ \0\0\0\0ÊhWdŞ!	I÷&ÀµVÍº[‡\r4ğûdº~jÕ~WİeñFõËì.\Z³_”5Oõ/„}I±‰«Uù?N¿SQ9wE%öŒ5j¿+íPçOù¥ö5<ví–º¢×>¦¾²Œşçg«‚•KùRBÏø¶ß“xáˆÂ_`\Z½æŒğ¦Ù/JŠúØ\Z½Úæÿ\0/K&»¤—ÑÔj·U¨¾¹Ù\\kŒk\r·Å`€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0R×hclr¸5Å5Ï G¡×K©iu_©Ê|¦½¼.ı°:µzHæ§ÆÊ—İï]Ä±©Vü§¯ë¢zI¾5{Õÿ\0+çìb%RÖé¿ÃüÅM‰?Ûãò¼5ía]7UÕ ®Ï÷v/ô–HòDP	éĞëoı*\'>õ€/SåÖÌ9B5¯âk?1pÕê|Ÿ7úÚ„»¢¾Ñ‰«µySm‡Æçcïx_0ÃVc·lº\\\']P—5ÖÖ~ršßüOm­b¹\'İ\\_Ô‚4–ïŸÒÓÙ.ùb?h\Z=~ã/‚ˆErú0»¼›÷¡ùb<½¬şÛqŸÇ©Ÿ÷q¡ 1şçú³œÿ\0šMı,\rá³iÓøPGm¡v $Z*W`­=Kî²ªµØTRä€È\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0¥®ĞÂè>{èu²êı¦«ãÆ!7ÊkĞûÀçkö»6íd7-sT^n¥v\'ÏÄUİïLµ›jÔSÆÊquO¹q‹š5:ı…c÷-ŠjKšíMº<¥¡ƒÍ¶NŞî_11uĞ«mÚ´‰8Ó\\1÷¥Œüå­U8ÅiÏ‹úyGfªèá¸F´ùu¶äıQˆu:­Ã©W\\Ôl—$¢²—¥§œb;n¢ÈµuöX¥ñEÉáöò\\%¯gÓÇœP!¡¢=€J©­r@l£Øp€\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0µÚ]Ã`èµ²Rı®¯ãå\\ß)¯CïÆš¸Ôç¥Ç¸½êÓåÓ.kä`S²ıâ˜F.‰MWSŠX\\QYQæ}]7Ø´töø}9ù0äşpxèU¡Ğhªñ-—SÅuÏ/ç(ÒÅë§*ô+¦ˆp¥®ôAvI|«Ò¤«‰©³„\\¸¿[~‚£}&“ÃNs}VMær|ÛĞ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)ıIÿ\0±Ñÿ\0Uøvç¼—¿Ki×şÏXü-¯¦NV9EW\'ÂirÄÓY~Œ<áÓÿ\0ú‡ùÊè7Ÿ6ìûM¾¢r·QÃªŠR”¢¤›NM¸Åz³à9úo3yy¹i¡+4Ú‰µ\ZUÑQS“ÏÊ.I>­wÒ†²Úç\Zµ/óª~åŸ<œ_xüß²è÷-²z»g5=\r7[BƒJ-¸){ÙO‡¸¹ã|£·èlıÎåªvçmÕ\nœWT¥7ñu\'Ã1]¡^ƒ~Ş6Xn’ĞîVêüJÜT¥Z¯À‡ZRÊ_IKXÛüíåªí¯AB²ªºœ!¨²1]Ò“êêJ^—^\ngçO/Q¸NNëçÔ¡=T#JôôñêqrãÙ:ÛÏ™¶Í¦=×¹[N]\n”§Õ“rM¸Çòíí›Gõ`²ØÂq¾˜¼æÙÂ.+<z%9{½ÃxÛô{×ßjzv“­Á©;–b¡øœ»=¼€á/ê6Ãá¹xZ…$ÒPè†Zyâ½üacÓÚwnİ´ší²Œ3VšJrnÜEÅBN2rÃi/wÒÿ\0ê&Á]²„#}ÑXÅ°„T^VxuÊö ;Û~å¡ÜtËS£µ]Kn=K)¦¹¦šM?Xk´Tk´wi/Yªè¸K“k<¤²šÊ|Wx:Øõ6ùkÍ6hµ3Ærğ.“iG¦\\jµ®®•Í7—Á6ıS·Í^i+¯hĞI©N)t¸ıìÎ2ãâÊ.8æ¨İ¼Á³ìuWUï¦]+ÁÒÓåĞšŠÂá¥Ù–¹p¶ÕçmqÔ­4%eM¨Õâ¢¦Şx\'%¸Ï`OÎeÕÙ¼Î½§Q¦¯LÂ3u§es’”’„¸§Ã‹İl›Ş“xÒOS¦…®:šµ$ò’—İráïĞ\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)ıIÿ\0±Ñÿ\0UøvGòÿ\0ï|¯·nT,ê´š:|\\Ë	Ñ\ZúŸÃ1o>¬óàÊZ½N¯Íú;õ6;n’œed¹µ\n%—Úğ¹gEÿ\0ìI~÷şjŞùeàc«û½&\0y÷ÿ\0³Sû?şW…V|ÔñºåÑğûİ}=8íä¼×è¡|Ç9º¯Ş-‹r…ùp¯ItkŸ5á¾}¹@y#hìÖmû¾š¹(ÎÏÛa¾\\%7õE¾×]ŸÔ×dTë£KÂK)§\ZÓM>i„iı@Òi4»Í5é©®ŠŞ2pª*	¾¹¬â)qàÏê.ƒC¤ÿ\0ı®­?_×áB0Î:1”³Œ6ïæG¶m{5\Zm=r×~Ê»!ª²*N¨Ù_Gåÿ\0éãÙÜûæİ/˜*ıÛÕµ[m±’¯¢1SŠKq›„\"½-sïœ,±yËµ©5\\´êR†x7\ZëIµé]L>dğ?ğ=£Àéèê§=Ç_…>¾]½yêï\roÿ\0ã‡ÕÑãËÇéÎ:<Kq×Î¾}¸=‹kóá²KK¡ÖèÖŠÌøúI¨»ri;1\\¤›éÌ^sË€ïù#m»m³pÒY¬§Q(ºå*¨œ¦«—¿uf1JO§ŠçÃ`¤ıJÑPô:]n1|-ğz–8ÂQ”°øgƒ=¬Ş@ÑQG—ëÔA~nªS²xÏ¹\'Ç)g	G<{[Çk?}ÿ\0™j_^›SE’ªıf: £—[}jK)tpô`óå­ş6ÿ\0Šn[–›aŒj:¥Tœ œ£Š¢å4—qàÔŸûåô°ÿ\0‰`H\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ıïdÒo\ZHiµ3²ÂÅju4RqûÊ\\=à-é4Õét”é«m×Eqª\\Ú‚QYÆ8ğ¢òvÕ¢İ–çD­ªSœiÌKÄM8¨¨¦’RáÄ	7Ÿ)lûµ¾=ğ•Z‡…+éj2’Ši)&¥ëÆ{À‹jòNÇ·jV¦²û Ôª•òRPk<RŠŠÏÜã°ğûËz\râ4~êvÁiúú.+=xÎz£/ÂGå/éw\Z,Vê£m3µ»%_C”ROîü¼¹µk÷•¼uj#|l®È¤à«n¬(ğérÃèô6÷å-·xÕÃS©²èY\nÕIU(¥„Ü¾ôeÇŞm÷ËzëÀıÕ–Ãöı}ŠÏ^3¨Ëğãå\r£_¤Òéîñ#-qª«àâ¬p‚ÂŒ›‹MvòõvEÿ\0Nv\rGÅÔ)&ÛŸ\\2ÓÇîcĞ%óOøfİåí6“WDµ:5*´É©%l`ñl^1Ö”{“õáuul·Æ\Zm“O¬¿Ud²İİ2’ŒbóB¤óœå·Ë°>•åı©è¶\r6ƒR”ä«—\\’k67)A¬É4ºº{Àæ_ı;Ø,¶S„¯¦/ª‹ŠÂÇ¸Î^ÖWdòşİ³Õ8hÔœ­Ç‹låÕ)t¶ãœb+]‰ÒŸ½ìšMãI\r6¦vB¸X­N¦“ÊN?yK‡¼»VÛFÙ «ED¥*ªêé”Úr÷¤äó…Î^€+o^[Ú·…«­« ºa}o¦ig8íMzÓíÀÊ?§{vÆs•÷Eg5NqQyXãÑKØÀéoYÛ7ŸZ¥([WİSQŸOám©&³Ç—Ö»&É¤Ùô“Ói§dëÖíi¼´£÷Tx{ t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0^ıW?z)®ÔÕ×EE.@l\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0ÿÙ','width=\"350\" height=\"350\"','','no_image.jpg'),(2,'image/gif','GIF89a¸\0çœ\0\0\0×#$ì!í#ğ&\nî0\nñ*,ÁACí:ñ75´RP³RU§bdòBDïTñU	ğJKšruôNNñ\\\rğbïg\0“€‚ñjöaa{šñ|xŸ ğ\0y ¡ó}ômkğ†ñ‡l³¶e·¸m´·f¸¹ñ’ó}~hº»ó”ò™UÅÉcÀ¿óšø‚òOÍĞóŸ\nğ¢ó¤SÑÓõ¦Cßßğ–—ù”Œ÷•’EáàQÜİõø<êèLææNçç7ñõ&ùû9òö)úü;ó÷,ûşú¥£/üÿ1ıÿø¬­GúşHûÿJüÿù´²UûùYùşZúÿcøøö¹»dùùp÷ørøùü¿À|öø}÷ù‡ôøˆõù‰öúõóöô’ôù—ôó˜õô òó¡óô¢õõ©òôªóõ±ğô¯óï¶ñï²òõúÔÕ·òğ³ó÷¾ğïüÖÖ¿ñğÆïñÀòòşØÙÇğòúÛÚÑîìûÜÛÎïòÔíòÏğóØíìÒğíÕîóıŞİÙîíßìíÚïîúâßàíîáîïêìéçíïíëïğëéıæâëîêéîğñìê÷êëóíìøëìşéìúìíÿêíûíîüîïığğÿóôşø÷ÿùøÿúùÿüúüÿûşÿü6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ6ıÿ!şCreated with The GIMP\0!ù\n\0ÿ\0,\0\0\0\0¸\0\0ş\0ÿ	H° Áƒ*\\È°¡Ã‡#JœH±¢Å‹3jÜÈ±£Ç CŠI²¤É“(Sª\\É²¥Ë—0cÊœI³¦Í›8sêÜÉ³§ÏŸ@ƒ\nJ´¨Ñ£H“*]Ê´©Ó§P£JJµªÕ«X³jİÊµ«×¯`“ÖhYclØ³hÓ\"-Ë’­Ú·pãâtÀAºróêİ{²¬Y\0ˆ—/TÁˆ6Ì¸¯_‘ŠnÌ4²åË”3cô;™#fÍM/‹Vº4DÎ6t´ëÁ	š- ?¸ı\0ÚÃ;Ï;ÀïÌ™Ã\Z.j‚‘’+iysæËt]¼èk×…d\'$m>à÷şğÁÃGO:è÷Ô>œ9oªƒE\râù$Døóç§¤_ÿ}ıÏ%WÃuòuhƒ$BH!~l÷Gm€ğñ‡âá¶G|\07\\{{÷Æğ}_Y5‚Ú~”¤¨bŠˆ¬¸b‹/ê7AY’ØÓ–\"Èƒ…ü‘ ?\n’›my`xŞzu·{€èŞ{p|ØF#ÚUsˆ,‚Ú”L\"Is“,‡H˜ÉI¢Ü$d.§â$3Ğˆ£•8áhÙ …¢# zàYÛàEˆ[¼ÍÑ! î½Á›ˆoÄGŠ¦ñ\Zk0ô\Zœ1%×â$”@b\"gûÙâ§üñ÷)\"‘à*%‘˜	‰$~É	¥ş2¹š!²qW«múÁ‡®ywÇ í¹wÇm,ep4úF\Zq¤\Zi¤‘¬vÁúµ%÷_©¥\"’j5 Jê§a†\nã¥**ªœQ[­µ-¹X\"ƒ¢ãlÎ®»ÕA!z¾	*¨“ÉJ©h³Š.Û¬³hœQBò¾jcÄïŠ*F*¸0¢ZªÇ–*gj$dn®¼ğÆën½³%² ‰ì+¶íZäouøÆ$“çŞÁ\"m´h”aô´(ÃIñe!“û-¸Ü¦Û¢Æ¥b*n˜S³®§¬’¼u\"n?ê!¶D^èG‘ëÍ!\\¡í›è¢@3ël\Zk¤Q†şŞÏAH»KéÒ‘}<.Éà†{¸Æ ŠJõ¥ø%^tíõI`×IkvzÌfÛm·éº6y¸ä’úì^ÉÆa†ëm˜Á(³e4¬÷Ş—ñwà²ÂJxb•ÊâÓàò÷qÓ“Tµã3‚;$ˆX~9I`/¨#­´y·ã®à™ÇÇ…èÍQÇ{Å6ù!²@7ÚÑw§q†Ş¹ë>Æückíï‚*%’§›âãç\"•Æø\'9ÊIoz#‘W‚ju¶ìÑì·Ùƒr6Añ))DÆJ£õºØ™ZC‹–ÑÈĞ0İıóÃtì/üÀR” j¸Õ­S)‡Eajj½ˆEb$ş?¼á¶S+Ïíi_xğÍoîpº%¹\rTJß5%†¹h\r#CÆ@†0x±‹aP!A7=Â5Nr Z©‚Ç8I\"r’«\0#Ğ$/D˜‰$A¼Ÿ€+İà\0åÑéÖ“Á;<ég?c£>BhùÍhfÈİüÖE†q`°Xï(¥1N†¨y\0Œª–sEB‡Îƒ^$\"æ¸<†Ä•Ûãh”Ø!\r+DPÔ 7è,*9Ì\"<á/9¿0†á˜ìä&9©Lyaj’+ËÈÔX&F3^ªœ»H&ª0•–Õ‘åkòÀÄÔªCQj²bç:Ù-Œ}ï3aîNøÅ0€Aaş2¹Lf*G^o%ÔÆ$*ş< šœUôÜ…Ÿâ&¨|Äy\r©ŠM\n²à ;uÆ®}h\0¦ûĞ0OK†á˜£¼ R\"°[cú§¬(±©hï\\)B(g\Z*g²ˆ›¤º#3)BÑ±†Ñté:E™áƒĞz–³´¨;J¢g8CÈ |zÑ`C?§w©5t•rZ„@Á•‚Ä M1Nı\"®mZ\nM7l¨IÀÙ˜ÌîWKQ“ö°¨D6«ŠiX_´H¿¿ÍŒÆìj¼\0†1ØÓ®\Zê¥Ìdµn&G4ëE[–Eô”ZS«¡©øãMŒ,ÆJò:şÄ‚êD1÷¬\rs(¬ë ¸A4´!ª#Åª<GèØ|š—üBe™Ù”¼v+$ƒ©š*S×\0¢,r%-Bg \r”åh••$\nÚF31TsåeŠ“9;eG6{Ï‡ÒÙ:6õuì[,ß 5ÂnUŸøüKÁğË	%¢¹Š*Ø%rqS¡dr´+ZîÊ`*¨ÁB]ÅàÔÖ\0í\n›Kwbaso!¸#y©hS¢¢ë|­÷é-\r\'Ô\"=ç×Õ1°ÔÇ“õBßdMåc+2\\+H]3Y†ÂÚmS\rÚD­RzlµÖ$í—fI¸+†P„A/eg6î\Zş\"™\nLÅJ•oò,îV»ØU/X™”fk2:ejãJ­ÇÌå1«å\'LìB+”İ*Yİçx]ôµÄ™—\r»Ê‰mA+Bø¨6£ÖX§NØ-*±hXØŠfUy¢T¥^õ\"29d>?¤¨ëeÊãÔx)HÇ4?Vvœ\nF3\Zµ-B%”qıÜ·|9bsØv”ˆÎAHH~•Ge¬(â8¤{»Û<-F®zQÏ“0÷<)õ2{4J‹şgª²Â°³”¦Æ4€ì\Z{Ù®šÄA\rˆw#&.î2„!\Z¡p2yG…pÙlpC3Ûdû@P<Ø”^÷:Hİ¿Ã}¬IşÇ †ÚYÈaı‚‘\'mp?e€i:•ñjØJP5t¸ğ¿.§c·œ4Î¦Ö\"\Z‘ÍÉFGèòä?@tEÊÃuÖÙT§º.¿Z,\ZVıæ·r›;ÖcP®ØÙısƒEµÆà\0©ùSÆ•?!òÎµë*\n—=2§¦1]ôÑ)ât¢ÍÌ¸\'A=èamHrM²4(»*öŠ¬ÎñLxÉ®~!İ³kÄz÷–¥¬¦d‘ºjˆd‡ŠsçùæÚù\\ÃÅ]Cß{fŸåkfƒğS„Àã&ºmC–Y$İNm·÷\rw’·¬VIÆÊ’\\Ïœo}C~\'¿}ímœ7ş\Z¦œ,2©o4×z×ËEèa^D˜\r± ÁLé\Z„ hqŞˆ\'g€JÏ†‚u>(¾®¿Õ>d°X$…U\'¤|ù„Ob rewÔ0Ô11u}3§dİÂ8€zâ7\Z;WwR~xÇè×(–iÖÃf+Ú“‚$àëñ£–:\"’q±Hˆ…cwc4ò4y^ÔR?ç„C]\Z=]2h€¦<JH	’À à.‹‚I£z×Š \n\'m³7RDù²+ò=ö—:L„TQ²T…¢A‰ñ,HR“c[DAØgô(2¥„f)ç^cwT¸r¬!t×ş‡°Yh\'E·bÓ¶#Ÿ!¶!AEög(X5CS4î£;ºósXpW€Ôs‡>TIØv¥ävÙ&E%Zƒ¸\Z$B-0têWDG+bÃ20cDÈ/¤C!çqy\0Ç\"q°Tí¡(–Bïós¥ˆÔHŠ¤XvèR@ñh£²<3h”Pv¬7‹/¤Í[®Ò‡f‹ V†à^öÒ2´53‰ß3:z !Âa(èXÎHZ@XÀÉ\\@\\pU€Øø.W}ÿce\0¤ ¨Så—ÒSS ¶H‚‡…… ¸iœ6!‰€Şqw‚3€E( Âş(ó% ¨6©iÉyI\rÙÚÈSHÙrĞñ%ÿÁ‡+‚5%+$Ø§ê×waƒ=¢ô!4Ó+Ib[27Òy©[“\\€Yl)W@X€U°T ”Fãhpáç&²0…1+b^¤\'Q¦!+ )‡è‘`ödæi¼8Ö–’~òßó+%ÃÁ(¹µTo`pÖ\\à8I6‰8™kI8YŠqéšy—\Z‘—F\ZÌ	ÊÖ—xËqLù?i’*–2^8…†i…®	‰	×{Ç…tB@bD*É/»‡à#0ş\"_k˜,¸¶OÊå£)Vš6¹–W šky£¸–U@TPq™DÖ\ZÌV&Ğ3	ºi›rb*v„‘½É4gÒ)ŸBz$s ¥!+‹ )\rzp/ÚÃ\'ô/’!äd,r(…’(mğ\Z<xû´O`¥y^ š_`¥¹“ÓÈ“WpT@Š9—±é€íæ\\CTH©-|ˆàoºé*\Z³o\nE‘®ÑPó&sw•W|¥ˆ™˜\rj‹ /,)†d>ªSƒS×Ñ0dÅdYóSY&`–¢\\+Š“£è–é¢¯9ŠğŸ²©£´È‰1}\'2(B5)òŒP\0/ wşá÷ŸX#sI†#Ñ%2CZVSSV%–œÀÊ)	íH8¾¡˜‰:ı¨†Tt8fU(”Bäd`µ€”EY]\0V_“¥Ij)ry\nY—sj«A	w\nä¨Ë±”kÒŠ	€Z\0&¤ŠŠ5Á©&–æ›¡r^mtsÉ!‚’Š$¨)\n×.C1ê±:XqÃT\\ú\ZHUWõ7^„I—7`¬ŠrâI`Å¦	”U°\n)—¹–1\ZŸu9‘§;Ñ«|Š1|ª?o”ÀŒ@¨ÿÖs\0*hb*ë„¨5s ãPø1	|ñ¤š’°I‚Zˆi³ç.Â‘:q®KÅ:ÿH®&ÄşE?hIa:¢gšg`¥–Z š	É–Y¯Ô˜³£X—\\0µZ—ué9z#§M‰Ñ1]Â„F^£Ÿİu¬¸z~ñ\0\n%zWVeÂ³‡â’.Çùz‡‹`©Íéœ‹pĞf/â.IÒ6sP: ²TésÂä²£\nf@n6?Ö®ZĞª£©ây“+Jí)—Cû¶Ê¯S\0S±£4dfòkÏúv¶À]„à\0& sªç\ZEé*\\Ë7c’®¢”`­«â ±W\n×……@-¾\'(&û3è³:×á0¹Óu[ÅR?˜nø«ºyƒû®°º=û“sy	—ûJ§Dş[Q0¹âô«*\ZÏ*@	Ñä\0êÈÀ\0¥û\Z¡„&)â¾ïKG^˜u<¤B¶rr°@	†p‹¸¨pÏÙˆõ2Ô‚$u@,ƒE,«Ó(IUF~#\\åc÷äc,¥ª`–©Iš¦¹«É“9Ë¯—¸:¶\Zu\Z.ä‡û?£Á´Y&9\r¨€ŒÀ¶{@w¢˜<õºà«vûá.†fJx5A§¨—Ò _’°‹™D§ˆnë^²bKÀ“KcTô¡xkIèJrÌ7?BF¢e*dö®]`ì–´ª“/úğéÆD;TğQà¯TÑ5<Ê´iB*÷ñ\Z‘\0bş‰3’ /ÒÍÁ V{`µ…#£ Iˆ.«5	Õ)§‚5ÑõSh!¤÷¡ŸĞóFˆ¨˜CÇpŠx]ˆf®ò+aùK¢(¥¶>Òƒ‘uY“…IaWÆ©ÊÁ¤y³Zp½<Š9Š$|½ÕëÆPğU€Ì\0«Â$öX&&æÒ\"ãÇNŒ„©b^\n¬6|{°YõÍß¼;üh•¹€6JÕ%¤Ê¡<MSÎØÉ[¶ÌwüŸ£¢ošbœ£Lt{7’QÜbr’:rK_¤¦NŸù»eğT\\4Ç%gpyÈd¦©Š³Íkš©©“«ù¢¤è¢s9§\"LÔq„(Cª‡\0º?NZ„ş­iGÒõ„‹™°	ˆ	3} 4Ô„€Æ¬ÍŠ#øÖ1;5¦Ï!øêÜ´N˜˜ØªR©@»îxEç*¿×Â[éÓ(hpşõƒv¶RÍVéF¢gJÑ9‰ÑÉ³´\nŸ)ŸtêÑÍ\\»:U±ûÃ-SÃamt¨\rö¬˜\"&SÒ;}¤?º&«ˆH,<0Uûó¨«+Ôæ—rÒ-ö=Œp¶KÊ˜F•`öÔ-ãÏF¥º«†O¢qS”¿[n“TªBfOeú[ d7É¼©YàË<Y1:?ùC\Z@—6ç8WSWBú½WÆ8åØ–rSÈ›“¤?ş¼ØF-ÉÍÎvMØËÍ#oG1Ù 7*±ËÄşËœgÊŠàw\nB+ \'¿ÂÊ•N®|ÚÍRĞ®Ñ²]4–‘ªÈ;¸„k“i9Ñ¨Y×HŠåG{1§¹M›Z²\"o†­#Ó8	Î¯‘±j2ï«1f¶í¬şã\"eJæX´	õÙ\"„É8“\n»ê‡ˆDwŞMíp½ˆÊ×aNÂâ$¤¦q·>kÕ®AnÄô\Z¤ÉÁgÉ¦¥è¼UĞ€Zá@MhcReake¦\'‘d‚eìâ‰ñ`L6JÄ}8WSeM#]Î¨ÑÙõÉ¶&ÒJT_ÒÊi–ê.C{³ç~| şs;>é*«[\Z‡7ÑB®XULat ¦‰š	™³¨ gâ©%Í..lô‡»&<ç¼•0\Z‰yV¶nç?¥R±`~CaK¤Tco®„Š5Ò¡.äòÉ‹ÀƒÌœÀ\n’b Ûq €¢»:Ş»¤q‹ä¨-\Z}û_0}½úÖG¶kÙ\rC¥.+Â\Z‘*ÁCœa‚İŒC 5´o}\r2¶oÙMå˜+›şáf<Íäê¼úÑ<™\"‹€gœêø±D×ˆY+NÚ£±ï-ƒğH´A\"e7B~éêÅ´æÚ-w½QPñƒbN*å# G-ÿAo¨lgNá§şÑ=›;z£”ºHJo¨%áÒu<LêØ¡òîğ®2‘æõ?ĞÃSƒ|Œ@‚Nœ…[8{éMf^Xp×±û—q¯üTSâmw#\Z`dv&¦OQü\nŸS¹n<*Bï3×)ˆ}ßk8İÊS.\ZséúÁÂı1o\Zİ¢Bïj”v%#ãÕíˆÀ„şöHfîJ¸Ü,÷ÛñÜ¡ZÛqçí¨V k‚˜/‰PQêq‰Á7èÑ’77æ0–qU>FnĞ§Oø;Ç&l«OğnıG¶8.&lWöµç<sÊÃÎå¼ŠI†*ú´@üvîÖ~VŒ£<ûa×Ší8-ş	°èB‰_1áŠìœ°ºïê§ˆ(ftörf‚€9,pğ\Z‹Bc\r‡E	º£OÆä+Uk£ÔÈÑK´®?ÇQP…\0ñOà@‚\rD˜PáB†Eš‰%‰•M¤tQ\0=~É1ÒÃ‰‘,\"zˆ²ÒÈ‘]RDùp’$ˆ“2’4‰ÈâÍH1¢IrâÆE=Nºh“çÃ•#WRÌ‰’âD F­Zm˜UëV®¡R]„¢E 5*k¨‘¡EŠ*4ˆP!A%„÷*€;sö\ZM³&Í`4eÊœ!CÆã3aÂŒóÅË1’Áx‘ŒùoQ,WªTşñÚ3*S¨|RzÊ(›Cv…[6C—-¦¼éZwQª,c6½yS(Ëˆ={VZú´gF–»;^\nıéE˜/™N}¸Ü9ÖÙİ½\'¼(•R£IIZ	RÙF-JTˆĞÜAq	ıI¤GĞvşƒı#.ƒÃÈãŒ1„L²0À`°²Ë¼Øî\nÏ° BÒ@û¬\n(  \"5Ò¨à£ïF$‘!‰n[N\"ã\"	1DŠ€£:êTŒÑ6ª²“î\"‹hÜÆ¦XÚ\'˜RZN&J&iñ£—ìîDˆFBµØ:dÊDÚ*äA‘K.?ñCı’Ü­02Ò\0²Ç[“M0 óÂ‹Ë¸àşÂİ¸¨¢³Ó>»0C>Ÿèğ‰(¢‘IC—Ì®$äÂC®$2]4.Qãâé\'|\Z2¨EÜ7L+=±6ŸÂ;‘GE<4Õ­Š¤D’‡ÔkD’µÚ[+CŞ\"¤ËD‰kÌS;3ÀÄ;pŒÇÎ#1.‹39ëtN*°àbZÒ®øpO*8¤â‰\'\nU5\\Ùj/»èLı•¿MÖ]7vÛİä’M2¡7^{Ûu÷İy3¹$“$İ¥—_vî·ßvåÍwİGÅe˜¡ğ&D’IY„‘³h…Ï­øàš«?Ò%SÀa3ÖXËäüB2Ë¶ø‚çöä“\n	?¬bŠšS{Âf·k¸g­(şeÉ¤’CW·@`E¥—6&õ azÅ_õ¥ºêwÉô9kƒp”d,YimïVø\nÙ¸Sç€c´áxôŒÇSÖŒeI•íÖâ-´ØZ<ñÌö´mIK-Š)åYkÅJé)á’bÑ9 N7&Ë/Ç<sÌ·ÛÄ*«?W¸ÅÅG÷	©³`E«¬DĞbëÑ=îèk=ö@û\rÛÉ1ÈõB1L#Î”»Ğ³¼¿Ø-ÃÿŠ\r7m\nşF§~ ˜VÊnÓ‹œ³)¦â~Å(|ñÅÿtü‰¶s!tÏAgWôêGê<I™„‘ŠS·5‘GóÈöÙë¨Ş€¶9¼L!Ğcş(É,‹A˜^Ş¸°·İœ4ÃV.ä!Ã}+qï[\\K‚Ó›‘ Ir˜Š	å’Ä´â,94‰chçDj4´JÔ¤6=*N&OkÏÅnE&?Ì.{¨Cî\0‡´Õ!moØƒí˜¤ˆ¾Cœƒ2gÅ	oZ Sß° A™152ó>ØC­!Å\'AÁT¹ˆÜ(\"I’Jx‚£GèÄoÁ!ŠnÎc¹;ZEs(Y#³Ö*D˜G=ey \0ÁJúıƒì4Å=0qŠ-‚ cÈ˜ŒA±ºà.´¬xtMª•Aš}Æ4İªâv£È­$KéQ¹–şs£$QÅ%1:æ­ÃœŒ8G/¹QäŒb¾DòÒg(1O{\"é‡IÎN{8\"’ˆD&–q°ÛZ42Ê$k‹¿Cœäù…U¯eatÍ/³Ó8¯[¦Ñ¥n¬éÃc:i\"…¤uB›Ğ$D=‰HD!ú¤â0§\'æ²	DNø$¨u¡F¡‰$éšîHÏTO’\0a@Xyàƒò DÊŠo(g?É’)ëwÊ¾`7ËĞi‚{£n”§A\rí	P¥	¨k–PÒ¬)…H4*šn2RÑîİ¦Eår#ƒsÑ’Ô(«›!«0K%M£œu/Æ¡ªâñ4Š5b;b„ ,şÓI‘wHâÈE´µAŠêäOEé»/<æÁ»LÊ„w¼	\ZºÑS5ë¼¨:\'®=ƒhø€ÒÌİ¤õ¢*‚ÊWùKÜd¤]&§¶Ã’ôq«l]¡÷>›µ¹uvÕM^óêâ¶¦xğ\0›6&.§j;çN£&2˜¡n=e1C<½íí¨ŞÕÌFÓÏıj·áNPD‘NQb\'2\n•[]ÓB˜ørE“c	vZôËRÕö!d‚¥¨rŞULj9$Ø²ç\"¦”¼dÁ9Î´ÑNmjÃ©íĞ¹Î)«d‚SÊÀp¼¼åmFåÂe]SK¤y„À‡*N.*şî%\nš\n©\"r¤øòW´Ì!ĞP[GD|ÔhêUÚ‹¶®Ùo-jağnş IâæA¦˜œÃr1E3‘Û(c¬,ÆÓn”ËJÜ],€‘o-Æš’KD×&ªSN*r¬0w…h^ğÊÀ\0ıgƒõùQş³ ¯¦ªÉë]rWXÀF+[9\'¦{ÅÃ+;&î¡(_CˆJ¶ÀàoA”g+K\\Y£&ÎI‚4‰&GgÜn¦{mU$ô¼hç°Ï×í;Õ¯;÷aÇ:U±JÆ‘?K‘¸|èËì^í‘ş´dJÙP\'[Y¤îBÓ—±½c:\"²†‰*—Xn¨Âİş›}í^ß¯7ókqJVd¡X]\rAC8§¥ß¼¸CRÊdE ~Ğ0S§–éN`´¬À;²„%(â¯¸Å§Zï:”hoIÜx#Ë…h×î¦Z»‡mwÏ›}_’‚\rqŠ­.ñqN$n”Ä$ë±c`Q‡JOWzŒFŸ „²âÊ[Nx‚V3\'TİêVWÌ¿#•µÖpHføøcCõôdİJ;û]l–·œØ Ó:‰ÚsàEÜjÙ·:„Ùv;ÇüÔ2ËêyÏ½ua‚mæ‚„\\F¦©OıéPwB0¾¡\r=âJP‚âŞúú$˜D+hO`	şş2,„Ì\\iqh¢İWYÚ\r7ÿ¯1‚V·R„|ô¾wPb‘MñœŒÊX9b¤§ø¨‰_ú··s¸AUş	rzÎ$½«g¾êJ@ÂÆgşWrÏt/‘YòÙN%|;ù±øv?sòô‡L¡k4·ıîÜ¾-Š¸ùÆÁ{\0HW7>=¸‘“ ²Œ»\'/81¿¹0ºåÛŒçœÓh¼Ã‚AYAy\'Ğ8ŠÓ@ÌÓ@$ ?Øˆˆ¹³Ñ2‰ÃˆZû‹‰½üZ‘â=İ‹ğQÁĞ	óŸ\"«ÁŸHAÙ°¿º»¸€‰“¢4@ƒùàñTê¢±:y¸Ó‚¥kş@jQ±¿Ğ›‰o”š9œÕ€:A±º\r©¾,\rÔ¾ÌŠ7’¯½Ø„GÀ\0V!•\'Y½İˆ‰cò/áØ#£1—y«?Œ‘ZbrBD6„\r°¡CPE8„\\8 )ŠƒÁø²Är\'ÈX 1Ãkµ£\"ˆS<<ÉÂ½ğ§laçƒ‚Õğ–(p‚)ğ(¨:ÊË¼%°:\\AEÌ\n+­\"ë\r\"¡­ráû‰P1¦–H¨?ÚÁH&ËÑÃ7\Z©¿à:^äŠsÄ›ë˜ù˜Ä³Yœò¤/{ƒKLÂí %Ç`–3s–2‡cÀL1Ä;Å«hAÑ™AÙ–\nìÂ¨ƒE¨ÃÅªş“¼Ä>Œ³Æ†(¡fl«ôRó3&Z?ÛˆyA‰˜FØ«‹zC•8¢3Œô¾ùÊˆ‚Ô\n+!$BÑ#,,»0\Z qµ/Kƒ6µíhÂ”q,á‰¬âs3ˆ«Bji@Y’™XâÒÃ”A‰<X¤ÅX¼8‹³>Œs‚]IƒH9î±Ã÷ŠF;$½\n•Œ*—¯¤–-û‹œ”Ó‚È2İˆˆªlˆZQ‹“$„D_ù‹™¬ÙY¢Ù O‚É˜¼D$Ü 3–:89Y¥UJ™â¡“-@¼xl³<I¼XªoYniÅ(À¼}¤EËûÇª£:‹«ºì³8¸´Jş}é”áğ\r\\Ë£b´ˆ÷¡QÙC¿I8¹zY9«0\0`ËÖÌ£¶(ÔTˆ´H„÷ˆÄ\\á•ıs\r?È¤òË6ğË¿ô2™œÉrœ®Q{“È¸ã‘ ï¢“,H>:¡–Óˆ%ÉG{\\²º¤º\rÁ<©DÌC‚©$N‚PÍ9ú£¯HF(=!«/:b/ù{p5°š·S´L°	9×œ	ÏºÏƒBÈ½“ô¼¼Š™B\"Ø ¾xƒ6x\"šü230ƒ6h3¸DÒ®f‘(l¥	Zº£jÀÄK±<‘<q\rÇÓ 0„/„:3„¼¾\\$Í\rœPà5TKÆåÁ9şÈdL&„ü·»\nĞY—­Š]JR‚xÄü‹ú°Ë\"Ü,³°Ø©ÄÌ68ÅNİ0–É`Â3*â1:Âs3:¹ÉL¼	Y1Õ8Jæs:¥lÊ)¸8Î$Í©¤¸ú¤Ê0µÒ\0\nä 7°1İÜÍµK´x4Ac4,7}q´ª‘—Gh€j\"Îº;Nù˜A¸AèÆ¿ÀÀ‚ƒå\",s\"Q¥ÉõÂ<œ\\Éò\"Uó®. –,¨*T<\n¹×x*/ÜÃyE\'X‚÷R¬³>ÌÃ¾Ä¾0ˆ9Æ	»ì89Î‘7—C¹·C¹ªaUÔ<ÎH<I3­Õ½Ø´Nšƒ6ş€.ŠƒsBÑIQó\" KLÅT{ê®ã»QòÄYª‚=œCEmJ\'R‹õÀÌÈÌW¸³üò£®Âóx=N}7vmW8|×W‘|9Ó?À\rµŠ,s\"MrÉ9ˆÍÄS9µ\r¾eµ½i™-\0#,H>}šlñŒE£j­Àœ±:XÍÈÃÖ¨¼8]D‚HY%±Æí˜„Œº”\Z&ßÌÈQı•}Ww}Ù«”ĞûÔ¿»¬Ë]™²Í\0,\0* \nûFÄJ\"*…kL-Å¥Õ‚gJ	£hİŒnQO¥Œ‚­Ü%HÔŒóØ¬Ï©ôV’úÁ`\"•|şI‰•…Û—]İ¸e»¹EMİ‹U›­1Ñ[Ù™›ºW«ÓÌ\'$¼)tØğ¤SÄ“?\r×ÀÃ©ÚìBÃ	ÒĞÔÀÒœO$ˆ³Í#[èpÃËCê`¨µm;˜mİ·}+³“¡Ö3¨Y·®ä!¸Ì»2¥‹»Ä«ÍH¢rò?8k,È°R¥¬VBª{Vã¥‚‡£[Vd¾1œ^Ë«ÅŒs8ÃŞİpGÓMø\rÖ²uß,e+h€ÖÛø‹‰÷{œËIÙá„Ë\\©Ë¸Ø•ùıÙá?’Œ	<Çd¥£#ñ¬-xÜşŒŞækÅ%ÃœiÊ%à?˜ë5_ëşÈ”02–ÍO¶µ\Z0øs\rÄôƒ&ñéÔ5\n¸”‹M„0œå?«XBTC3‘Bïòa‡ıÓ¿¹ÑÊ“äİè[ÏÎZã¨·í(U_KOuöÕ“{İÔı5(VñÀA1^‘’!œ¨	¥¡‰<šbØUD²¹K»xaA\0„?şá±cí‚.¸§‡3¼Å5¾Ï¨ñÊÏ\0Rn±XS×A~Yqõ0Pu]¥a?›¡bîùÓCMŞ£<z& Ø±/u^¼Ë›»K<˜²¼’¸Á(:] ¢<m+8éÉŸ´QÎZ£Ä»[–`%kâ{qİÒëš²Kß¨I»sşäsyÆ\'Af¡ —ÕÒÃŒ¨­:k¤İiÆIj1Á@ƒÁ8ƒ3(ŒmşÇÀx*Ü-Pe`?­âı?)#RşÚ¯%ˆ‚&°wŞHp]õÑfÎ£Ëy?Ì1áği¡ä#bD+”‘RËr»á¼Ş“]Éıå_yƒ5@ÁÓ†Nƒ2@ƒ3«(V&t#¾*Ìá½iÀ¥5>Ò¸ Ğè“ëZÓÄ¼\"(ˆ ş,”¾„>Ğå–--°ÌÁF™ë¼¯©ˆš[“-jL/Ú|	7L¦Ú@\nˆI—„?=`©•ò2±4ˆIÿpè§F“\0	18ı5Ø.ÚSöÉ¦¥şÑJ:yµ²éÌé%\0[µ¦*”^—²çí€!¨€šÎƒšó=‘LèÛxF‹º¨-¦³0¿eæ£K}i1ŞŒ”_>È+Û¿ğ)2,t²Î™$Ê–2%Q*¥¾l£§o>ºâ3¾ó†V	åš©oµ>Ï½<ÏõÀ´†µó‚mv‘ƒÙnâ@C4x9ãşç¡\n­ÄÔøJá¢¨dœøÃë@DfÂë\"û‡[Ş<¢–$½Rè ²nÈ]jÂä3©l¸96Aqƒªg£JÜÅÅÂ\nùÓ?½}Ê–G¹¸ê[‚\"ˆï©LÃª‚ÖæµV¹FËmr½zVş»\"IÀ€c*Û¯´CI™Èœ8¦„\"ğüêbÃT—ˆ±Q™ğv†9<p°º .âŠnÛÑ)&ú2šTQEÂ4\0	‘j2@Œ0  S–ZÇË\0E£Oˆû,œ%Ğ#2\nˆå\\$R¨Ó¸[ÄVÖOIÿZ´.épÛ-Õ3»IÁœ¾ösÈPeŸLø\0íåºÁN\Z¡Á‡¹T,/•`¬­=ºka¢„q}5­>åJŠnâğ•I95ƒ††j9	Ã ™z¬,Ú\"¡Â¼ÑèÆıÓfÍÑ™±É EAQ`Ê‹E«KCIoÔ\" ÷ì³oL+\0Í)Ÿ/ÎÁƒâ`ö±ÃşL¡™	ãÎ#¢ˆP/ßP‘!¨¨­÷ª€€KŸ¶z“$0qî—ÚÂÂ©Ì8@ƒ8€êb/Š‘ñÃª”,1@çÈ<ªâ½ ĞÏPoæqJ¬ÓÜHßÀ¯½8’6ø˜å¥átHÑZ\Z7ÊëÓâ#¿çb?Ô\ZšÓ¨X‰ŒJ+~¿\nÓµ‘õJÛcj‰D\n;8÷ƒ5Q“? .=hxKüYP3Q3ÁH;7£h\'6y,9¡á/ÀèÆ\\åÏ&O\nñá§–k—>Qô¿HJW¤Å®…`ìË>¤Ï¯U‚\"ˆÔ!OwĞı‡\"ÓHcä£[K·ŒHŸÒ{éN—\nì1õş/¦‘aò0A\ZXO«HĞ³ƒØ;HûçŞJÒ¹¿à×µû6Gƒ6pêİG6ÖøŸKX‘ã\0ãx4>,Ì“CÏ–a\riõ–¬:‹½:5ô@êÏÄ7÷šÓL_î‚ˆP¬R?Ò#ªXd­ÒwòQõ¯s\nß‘<,+s•£C”u‰½¨÷#JØµ„XbãzØ/¢Í\0ˆ7oÚÄ)h¦™8	Ó0D“æ™2#¨hñ\"€1aÂ€ã%Œ^¾ÔÂå“Z®\\Ér–*\\¨\\™É’K*4uê¬R#Ğ‹NœLqòd‰(K(iºÄ‰’¡H¦i:ÔI‘©ÿ¶şşê5(×°bÇ’-kö¬Ù¯@ÉJBÉk¤¸ˆ&QŠ;)n¤V6ñİ¤V­¤H”îF\n\\ø.\"J‰ñVŠT‰R]¼n#J9ÒäË˜+ş‹‘³]È‰+-l¹²âÒ.ú¦õìúµE´²gÓ–ÍĞ>wğ¸~gN‚ÁƒLãĞ!†e’—YîÙË˜‘_<‚éâ%%—-ZLbá’…˜á±¼¬Ó\'Ë+=§P©ö“\'N \Z…¨’ûHœ,Aê_êTHl`Õv ‚²½v–[¹¥W_FXàE•Qvab“P–Zi–A¦™`xÕ™iq)öV&Z(—[˜5–šcx™¶\Zk­Qx£Wş	ê¸ãV€ğázäÑ›o\rœqIáĞiAÆg”1Æ®}!I\\\\7xà™tSL+Õ$L9ñÔ^{>½÷šQF-¡”Q ¥ÄTıõçUET…\'8À# 	.H–„~¹Vè„~xÚe•I¦Ù‰˜9jZ]ê•I_˜òu	_ò…©›™(Zd¤~	5å\'«úêY¸í‘‡®ÁQPÂ%d\Zq0ô«DQ>IÆOVéZH[p©ÒvXp§E2G…Mfªg&¶Sø_›W]õTTMM…\'JÑ_€}â+»6ş…V¡­¶ê‰£~Hbj§ÊÅ™e•H°¢Rˆş]Š%à‚™pªi&\n7¬†	L	^Ğ&/Æíjücyìa«‘Ã¤P¯Ê¡ÑÜ°c4±ÇºÖ…#™Ôexà9Sw4ÅÄÅ2étmš9­éš|P(…Süñ×Ÿ¸â>U®H¨{£ÆUoå\Zmñb<ğ‰ˆHÂ/‹vˆ\Z%¤EæVª\'\n›…\Zî‹ÅöåÅ’Zham[gl5 ´îq‡kÃ”PÇ™a\Z\'/çä“Ë=É2…Øm7¹˜6cñsÏ—ûô3š>UaôOlÊç-¸J{RxfÕßÔò­ñ»\"ª7l’ŒZ‹ ¢V¢h-\nFIÚˆ†*#Š°‰&ªisQ\\7$¨İuş/d‚ÒŞêë	Ş‘à¶Â‡p%ùk’ÃNY,ËaPyc^š”L/µß3üáå„^{P˜ÅĞÍ÷æQíW§öã„!œ++ZáŠŸªÇ®¯ğHkÓû‹xw\"}Iê2#2€èĞ°€\r/\ZºÛBd*İ-w+\"H5&Èœb¨Ã%î!‰H rCcQI#aÀ‘ºƒ…,Ì¬&à1¢L<‡¦ÎQÁ~QİkF7”) Í)â\nê¤º!p],T5;z¥4Iİ<t6ÔÈMm›h… W<¶E\nwƒ^¤>´!DŠŒüâğğBÏäŠ …ÔÕ¯‘å”ş!f ÃFˆõC Ög1¡–NÎSõœ©=ÚšBş<ó„£=*ßjŠ¸ô´ª¬RjWK  cY›1úñ\"ù²£`ÎÁL}áTÀ4ô¡IÆ4!ô\\##ÎÔ‘_“h×eÉ®ìyÆHiğChˆ8”ëIgØÈÌà2 ~ç\nAz6y¹˜	\nAëIHg§Ø©t«Ô”Ğ:ØH³Ÿğ¢e-ğ5½ˆ^¢iLeC‚¯n›Q&îƒ#i&Ú\"tIrÔü®\n’8‡$)XŒ‹ˆF|øŒeá;8qÖKz†ó˜©söóI|¦0…ÙÉ”áŠÊ·Æ…„V\Z°ş‹+ì(R·¢¶€àQ!rÔİ8sÆÑ¥2,á¤.Dª¸àˆ4½×BE•¯È<3©f­ÚkŒ$Ã† \'\rÁÂa±Œu½Õ&&‘IL}òÒöôŒ\'Ÿ{‚NâÏ¢ä\'\\\0\nTÊ•\"ğé•^<kG—ZË-f1e‹ÑW“Ç(<ê‘™&2Í$pT°ÚÅ #òà-#ÙÕÂ*­¸:H[İz2æ’dxàxr†÷)±\'izBNÀ*„ò/o’TèT+fÅ€â¢c]ÇÚÈ¬–©!eíxªİÕÅ0Ê,f¥êr—¯MÆ˜7Š£\n#IÉ(1Ó}ï^s¸†€oIŠƒÒ°Ìg¥ÙŒ%ş;IyüÛ“ÍEA\':¥ĞPÀÔzÖI	HÑS*]øúÓ*TQz+e·‰£ZİĞó¢z¼ĞN”½ü:©˜\n³øb®)$6÷È`=ÒXÎyI(D&\'‰5š´ÀâB†åƒ‡ZÏRh¨p‹¥)YÚ•†´uÑèï<LJM»…!XgptÙ\nVö©gÓ0£¬æ²¤5‘$­á[#r[+]IY¢Âåz–D˜tÎsö;F‰`;Ø§Ş’Š×,Ë)o^.JŠ9„PÇìÎm˜¡ïÄ›˜æÍ‘Bj$^xw·™Á(ºÔOVKáê«œB	6!Ã¬Ã…ñ¬\nzş¶õuâÎœ\ZU80SUhjZxk·#UF/ıÙ©.*ÔbuXùå‹ùÒ›EŠ13lSÃæš…«aDó$ØÀúJWƒ–´\0[Ï„<—œÉüü\\`h\nÁNô¶­æFCÉ£rùlï<ÖğÔ-^Í*¾:íé®AºRS5¨jó½æn3$d€3”ÌP /püÜXR÷ºo½Nšl.MÄ¢\0J(Ş[Ø×Ø¾ù=ÑìF{w-*s¾ÃeJï+™UmÕˆ(hP²•èåÍ·U}#0PÉÜ^€Ùv¾\0r×ˆg“ÿm¢ç\nÊø·å5:»bÎªïNf2g¼rx)İ»òJæwŞş¼Ê‹LKOp2`W3ÅóÈ4àÖÒy:IJ’’©ÿes4e¢O´E\\Ïı\ZØ^Ç÷İåÆJØAÌ¢V6B‘ìŒÎàK¥pb®¶êàv;±Šù¨\rÙôSGÄ0’pA$QŸá¿R&œœi~î4tŠ?*>şë«—ü&,ñKI4á\rÄªú¡Ç€ªûª££3Ãyîf&õò*Xd¼J)h§ùøğ-Ğ\ZZ¥èdöéC‰¤¾íxÏz]b¼ƒ«r*êt§Å‡¼ùñˆ$AÜ@´EóPlüÛŠXU–İ‰L%`—†õÜóŒŠ5«X¤œÙñàùİH„Äş€„ÓIlÇà¥„gôÕÈ)åÄ\0×¯Ù›Ş´R“í“Ëà<‚²i™Â…e‰ÈÛŒŸï4 ÃİËg]ê«˜EYÆ£PNWË1İˆuhG „—ØÌxüyd’1;\r™	—ãñT\0¡*AX\n=VîH`€	‘\\œXŠÑK¦IáiÅÈÍiB]ï «4b	•PéÓ®V°qDD’Dnv¤à\nvGE_õŞ¯Õ qéÚ¢\r\"X€´R)Ùë\\D#²Ke\rj9`ò!‡˜XİiÚæiU–‰\n÷İ¢[XÀTø	\"ã0¶âYÓA‡GDÇßy„ş–€Gú8Ki\"Lp\"Ÿõ{¸×6¢p\rÙXEr\r…¹4–1®ÙïXÕĞ9\n$\\já16¹È£\0Åã0Öc“	#>Ğ9BSùĞ|tá•<xÀßä¤O—¸Oû\\Dá™\'nÎp}Rğé”|PH)İ‰ê˜ã?¢cUÖíø!0êc?¦¤J®d€àHJ~$@Ö’FˆA	Ê^¹q‰¹ÍJ@ÎÔLx¤‡»•œæ6ªÜğNÅh$\nÈ*1\"L®ÙÍïTUB#Kf¥V¦¤KâcT£ilÄ¹1£Ç¥\n6ËÌXÎÎğĞ˜OôUÖmc\0×íş_|ÜÇÈT R’A×WF™ŒÆBİ@bÀt\0l%c6&\"ŞH?&RÕ’ùŒ€“GDbûu¬Å_Jt%âÌKŒG¼µÏåÌQZ]ß6’NAÁÖáÏRÂ†ƒ¡K¹,d*š´Ï´¥#èV:¦pr%_ÆcnöS@õĞFpœì\rdû=¨ X\"³¸ÔxT]’o¥îqõŸÊÍGFÂF)ãq*Úi¸ÜíbdPŸ¾PBpçJRH<æy²e‚S}„ßIlA–|!vxGOş$MÌïMd]Î^öZäÇ!l –äg©¥Ş´Šeˆ•İ£ş<Ïe@	 €‰¢@‰š(	 ÀŠ¶h‹²@	”(\rü€s\rcq6¸†~QÉ“\\&Yf¡Ğä•ÄŒGÄŸtª„]•‰´‡¥S_Q‘’\'Rlæå¨yš‹î¨š¡Vïx˜††ÍcŒ_YUuT™P©øà¥Æ°\0>Vh€Áxi,	±ˆŸd$vÄì›IHü­ Í„‡äÄ˜øXŸ˜ı\0Vkæ\r™lÎàÒ°Éà\'FY÷Ïg	†ş[³-Š‡˜VáÑ‡-Ô)SÅÄ…ºÆTğ\0\rlª,ÑNX„AŸ~„ôAhILNåKQz¼ÓÕi}§şQÖeÊáÈGTÀ¦¼F—Ò*:²—obÄÙá¿AšzqX 2-2“¶bµı°@X«4í\rWğéFŒàttÄ¹¡›gšÌØUKG— ÇLuG^{ÁòZÿÍ „b$À	Ö°«©5ÊñÜ•YF\rS½¤ˆî¢©†a†ÙpÖñ¸Æ\\8l»ÂÒXÀkerÜì9£Ì\\ÇtB]—àL\\ÎÄ„ç`Kšh]}#şÜÊÅSHëP4,É–šb”i©plÂ]H!›ê†ÀÈE\n^F1aÆ]xFÑ\"\'”‘EtP\" NÇ3ÎÌukz|ÉhâÙyXãaqåÔÁæşYQ¼&T¼‰R(Ön­©yXè9Š©ÖK£x™gI†ï€ÙiHßA-Ü¨ßúÓ È:§(¬}á9AKÌòk»•É5n§š@êâm]Ê=œÜÇPĞÇ¡ííã¢§\0\nŒJ&\"1Îîì*¢>JÅ<şïÚ#üQë–lÈvAÅ_¡ÂLJôäÎüÌjç€éÚæ¨á_,¥’pÍœ…ƒ9nğömbD@*Ò\'ùf%ğ~o­²b»üªËRçà±h2©Ì’\nMğ¡(]d^JÑ›š)y/ú\Zí”/g¥\ro\0GI<O6dw°D€±„^ÍÏµø„Ñ„b³º&(E¨Rş¢® \r´F—«$°©°	÷#t0	›_ºÄh¾”[‡vş`—6*™n~ô¬êÖ-ˆ¯°š0§Y¨¯ w|‰xMå;Å`V½ÉmÏÆ‡U\rÿ¸Kl$ñİıá`\n.d±§%ÑDMpRoõ„ıüYqFâ„ßPÌ†\n—ñK[Ú!%0c(ï™‡»\r\rk{ìŸğ9œ,nÈÿqä]FàF­A1ÀŒæ(\nó@B²ÃzN:1^Éq£ÊÉm =Á«ü	\'Ïá’¨ÆÅd\0	Ğ€\r\0&;W*ß2.ç².ï2/÷²/ÿ20³031³ 132\'³2/337³3?34G³4O35W³5_36ÓF@\0\0;','width=\"515\" height=\"184\"','','prueba.gif');
/*!40000 ALTER TABLE `imatges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `llibres`
--

DROP TABLE IF EXISTS `llibres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `llibres` (
  `idLlibre` int(11) NOT NULL DEFAULT '0',
  `titolAlternatiu` varchar(150) DEFAULT NULL,
  `numToms` int(11) DEFAULT NULL,
  `llegit` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idLlibre`),
  CONSTRAINT `FKLlibre` FOREIGN KEY (`idLlibre`) REFERENCES `element` (`idElement`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `llibres`
--

LOCK TABLES `llibres` WRITE;
/*!40000 ALTER TABLE `llibres` DISABLE KEYS */;
INSERT INTO `llibres` VALUES (1,'Doragon booru',50,0),(2,'Arare',120,0);
/*!40000 ALTER TABLE `llibres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serie`
--

DROP TABLE IF EXISTS `serie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serie` (
  `idSerie` int(11) NOT NULL DEFAULT '0',
  `totalTemporades` tinyint(4) DEFAULT NULL,
  `totalCapitols` int(11) DEFAULT NULL,
  `tipusSerie` int(11) DEFAULT NULL,
  PRIMARY KEY (`idSerie`),
  KEY `FKTipus` (`tipusSerie`),
  CONSTRAINT `FKSerie` FOREIGN KEY (`idSerie`) REFERENCES `element` (`idElement`),
  CONSTRAINT `FKTipus` FOREIGN KEY (`tipusSerie`) REFERENCES `tipus` (`idTipus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serie`
--

LOCK TABLES `serie` WRITE;
/*!40000 ALTER TABLE `serie` DISABLE KEYS */;
/*!40000 ALTER TABLE `serie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipus`
--

DROP TABLE IF EXISTS `tipus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipus` (
  `idTipus` int(11) NOT NULL AUTO_INCREMENT,
  `nomTipus` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idTipus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipus`
--

LOCK TABLES `tipus` WRITE;
/*!40000 ALTER TABLE `tipus` DISABLE KEYS */;
/*!40000 ALTER TABLE `tipus` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-01 12:43:03
