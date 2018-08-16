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
INSERT INTO `classifcontinguts` VALUES (1,'Aventura'),(2,'Comedia'),(3,'Drama'),(4,'Romance'),(5,'Ciencia ficción'),(6,'Torneo'),(7,'Acción'),(8,'Magia'),(9,'Psicológico'),(10,'Horror'),(11,'Misterio'),(12,'Sobrenatural'),(13,'Erótico'),(14,'Fantasía'),(15,'Recuentos de la vida'),(16,'Suspenso'),(17,'Seinen'),(18,'Ecchi'),(19,'Shoujo'),(20,'Harem'),(21,'Shounen'),(22,'Yaoi'),(23,'Yuri'),(24,'One Shot');
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
INSERT INTO `imatges` VALUES (1,'image/jpeg','����\0JFIF\0\0\0d\0d\0\0��\0Ducky\0\0\0\0\0<\0\0��\0Adobe\0d�\0\0\0��\0�\0		\n\n\n\n\r\r\Z\Z��\0^^\0��\0�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n\0\0\0!1AaQq�\"2�����BR#3br���CS�Tt5�$467G\0\0\0\0\0\0\0\0\0\0\0\0!��\0\0\0?\0�R\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�F��� �YQ�t�|?`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\r�<�V���\0�u*�9�϶O���tZ���n 1	�U��~��P\0\0�W������p���+���P&�Mr`\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0K�J�[\'\n�/�]�\r�����O�O����,�7��.K��Ȫ�_e++xk��a]�6��e9\\��{S+-���������*�\'�A�����)~���\\��]:�(û�\r��Q|[�JIphS��T����|��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0����{��j]����]N���	|1\\����[��f���Ǳ�,\r��_s�qo���j�2�%cR�D&�b��^#��\0���~�D2�^$�=�qB��Ug���\"C$�yo/�*�ߩ�51o���/�#�sQ�mO�xIw2��ƽ�a�)_x�j�m����I�\0u��,S��MsO�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�N1Yo\n�OP��\n{l��\r�Z�����v(��}�syo����m�������>5���Zz�)�d����j4�Gޔc�+��T�q�Y�驓�&���-�{��&��n⁩�����oӄ0ԑ�t��S����:\ryV���D�Er�_ \ZJ�,9��0��5�� h�=�\0i�0bJ5z{�Z�@�-S�(��P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\Z�q�\\����]v,W�c��`c[��KL��\09�����oЛ\"DWGO����e�/؀��Կ����J���㔧�o�U��g�1�x�����E_�lxv.?@����¥?R���2߿^�M1��S�c���[/���$G-^�_�(V�R|���\0\0�v���a�Y^��V�vq��~��P\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0c�7���`T��]n�8��2�W���kޱV�Y~���v�\"��8��ss��`b��A�X��Cu}�u�k�E�J��\0�W,�N�_�Ta��Ƙ�f������\\@�|g9K��b�7@n� 6L\r�d@��QgF���$��=����������\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\05���)<$:�%vm�n5�$�$��}슿��W����+�e�gS��D���(/�.,����7m�Q����p_1Q�y|_�\r� 7R\n�2�,\r���,�t��06�L�\0�\r��@�q�N��h��ނ6J�Z�Uq~��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�U��Vgc�a-��l�Jz���*�����M�p����I��\Z�ϊ�i��\0��S���K�K xs*\0\0ѐ�AR�AF@H�D�@l�&��@j��j��o�<p�_���M�y�+�p\'\0&\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�Y\n��6�W6���j5��U�k��U���a��W)ɨ�s�O���8����Z��s��5q笲�f�Ns�97�E{=�j���>�ʷ�h�+�N�8���V�\0\0h�\r� �c ���ŷ�6Q4*��az[HbkwG��q.\Zө?��~��Mb~=Mx��*Y�����b觕�Ȧ@Ð\Z��<�oV��~	�(D��~��&�����TL\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\n������1��]�X�<�v}�v��y-�Y��_uV��T�a_f=&Z�h\0=_�-��]^~2�t��%y�ޯs�ó���|H��\0��J�����̳����\\M\Zu��<O=��>�\\MMUjK8K��-���S*��K�ͷF�E6���Ig���pm��X���]ETܧ8uE&����0/[�C�Ta>����\\{=\0R���\Zƺ��6�J}�k�q��O��3Z������;>Y���%�<%vc�W5��{2���\0\0\0\0\0\0\0\0\0\0\0\0\0\0SQ9_o�x�^�������SMB�1WO����Lᭂ�/r�_c%X�PA��q��U�8)����bUo4�Ѻ�c�����X�\0���,J�IC�U���9��f�C\'8¨�rxM���x�����&�d�9��e4�vb�<U~-���o�\\e\'��Kʙ�/�����\r��K�$����Z��s��Z��(�j�DV:�u����;��5(��,+�ۈ���2����\0\0\0\0\0\0\0\0\0\0\0\0\0\0���G���U�p���r0�:=<�)p^��>m�X7vݭ�j�H����Wi����׻���;c�.��4�mS���5���d�ѕjO�v��zr�MJ?+\\\n�yƯMo�J�#�@\0ig�~�XU��\\_q������f_��ɧIv<{PꅖϦ��\n���>���r�,�i�:��7.��p��vu`1n��w	J�a���`ε������Y�\0&�����1�y��5v�Jѕ�%j!�2���}����&��*=��)U5�lY�<��+)�\0\0\0\0\0\0\0\0\0\0\0\0\0E��4����I.m�$�Z%���k9�\0{\"����=%��?̒���%jG���]����oܿ�;���³������ܷݳ��\'�G���k�_��}�#����WV���b#�Z���\05�fTK���m�a>��.�\0�	u6uTף�t�F5asϼ��v�kK���9]�^�<� <��]���kݗa�ܫZ%���e�P�,��Įŗt�ö+�̬�����b�g��i��aYVa�����#�]/o��Oى\Zef1OҀ�\0\0\0\0\0\0\0\0\0\0\0\0�@��uvn7<J?�ɾ��`�QV�l��W&���lU�e@6���dl���Ԣ���j��g�������\"Q�%(IbQmIw�+�@�tKU�Y$�:��|�EH�P\0k)��to����m�͝�\Z;�X`h�\\S�+lM4��@e_.)�}�k))<�\r|X��)`\r�o���CW�7�8ǵ�l���L�\0\0�g���P���Y���Z)uik|�JOւ&\0\0\0\0\0\0\0\0\0\0\0\0\0������G���4��C�s��~�1>S_h-�`��R�ic�;�d;b�+��5+�@��O_�l�sx������QbTh�x\Zũ����.鯴U�)����������o��ǰ�^%��N/�m?���\0\0b�V�.�)v\Z�,Il��%�wu~���#Lcœ�`߯�5yg��(����^O��x�\"i���7/[\Z��SZ�A�Ir@d\0\0\0\0��S��n�}�����bWKG�Yc��$���_3*,\0\0\0\0\0\0\0\0\0\0\0\0\0\0���F��p���\Z��O���x��\'�k���lNޫI���Z��븖5+�A%N��t>:䤾@=����]�0�dT�������M���\rw�+�yJޭ�u�\0���\0��,J�[�^㩯J�c���U�\0\r&���5TT��e�K\0d\0\0\0\0\0\0\0\0\0=����5zTg�%w��u���(����\0T��\0\0\0\0\0\0\0\0\0\0\0\0\0\0v�6�+�\\S\\��-t�/�����)����=;��K���Z��븖5+�A�|����S|xί�%P�.����l*��]��B�\\�}��SVy�3K��H�T��W��M�Y�����\0\0\0\0\0\0\0\0\0\0\0\0�ˈƋ���\'�xm{���Mf;㏤���v�Se��Ë�J���e�]��:��d����?���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\nZ�m�ib\\�\\�zt��k��G�|���.�\0�:�ZH�Ky���{�q,jWI���S^���V��]�����j�=���y�ĥ��¤y�\0+��ݣ^$%��?Jjߜ*��{q��Qo�����爠\0\0\0\0�hWd�!	I�&��Vͺ[�\r4��d�~�j�~W�e�F���.\Z�_�5O�/�}I���U�?N�SQ9wE%��5j�+�P�O���5<v햎���>������g���K�RB�����x��_`\Z����/J���\Z����\0/K&�����j�U����\\k�k\r��`�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0R�hclr�5�5� G��K�iu_��|���.��:�zH��ʗ��]ı�V����zI�5{��\0+��b%R�����M�?���5�a]7Uՠ���v/��H�DP	���o�*\'>��/S���9B5��k?1p��|�7�ڄ���щ��ySm���c�x_0�Vc�l�\\\']P�5��~r���Om�b�\'�\\_Ԃ4�����.�b?h\Z=~�/��Er�0������b<����q�ǩ��q� 1������\0�M�,\r�i��PGm�v $Z*W`�=K���TR��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0�����>{�u�������!7�k����k��6�d7-sT^n�v\'��U��L��j�S��quO�q���5:��c�-�jK��M�<���ͶN��_11uЫmڴ�8�\\1������U8�i����yGf���F��u���Q�u:�éW\\�l�$������b;n�ȵu�X��E����\\%�g�ǜP!��=�J��r@l��p�\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��]Ï`赲R�����\\�)�C�ƚ���Ǹ�����.k�`S���F�.�MWS�X\\QYQ�}]�7شt��}9�0��px�U��h��-�S��u�/�(ҝ��*�+��p����Av�I|�Ҥ������\\��[~��}&��Ns}VM�r|��\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)�I�\0���\0U�v缗�Ki���X�-��NV9EW\'�ir��Y~�<���\0�����7�6��M��r�Qê�R����NM��z���9�o3yy�i�+4ډ�\ZU�QS���.I>�w҆���\Z�/�~城<�_x�߲��-�z�g5=\r7[B�J-�){�O����|���l���v�m��\n�WT�7�u\'�1]�^�~�6Xn���V��J�T�Z���ZR�_IK��X�����AB����!��1�]ғ��J^�^\n�g�O/Q�NN��ԡ=T#J����q�r�ِ:�ϙ�ͦ�=׹[N]\n����rM������G�`���q������.+<z%9{��x��{��jzv����;�b����=���/�6��xZ�$�P�Zy��ac��wnݴ���3V�Jrn�E�BN2r�i/w��\0�&�]��#}�XŰ�T^Vxu���;�~��t�S��]Kn=K)����M?Xk�Tk�wi/Y��K�k<����|Wx:��6�k�6h�3ƞr�.�iG�\\j�����7��6�S��^i��+�h�I�N)t����2����.8��ݼ���uWU�]+����К����ٖ�p���m�qԭ4%eM��⢦�x\'%���`O�e�ټν�Q��L��3u�es������Ë�l�ޓx�OS����:��$��r���\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0)�I�\0���\0U�vG��\0�|��nT,괚:|\\�	�\Z���1o>����Z�N���;�6;n��ed��\n%���gE�\0�I~��jޏ�e�c���&\0y��\0�S�?�W�V|�������}=8�����|�9���-�r��p�Itk�5�}�@y�#h��m����(���a�\\%7�E��]���dT랣K�K)�\Z�M>i�i�@�i4��5驮�ޞ2p�*	����)q���.�C��\0����?_���B0�:1�����6��G�m{5\Zm=r�~ʻ!��*N��_G��\0��������/�*���յ[m����1S��Kq��\"��-s�,�y˵�5\\��R�x7\Z�I��]L>d�?�=�����=�_�>�]�y��\ro��\0���������:<Kq׎ξ�}�=�k��KK���֊���I��ri;1\\����^s����#m�m�p�Y��Q(��*������uf1JO���Ï`��J�P�:]n1|-�z�8�Q���g��=��@�QG���A~n�S��xϹ\'�)g	G<{[�k?}�\0�j_�^�SE���f: ��[}jK)tp�`����6�\0�n[���a�j:�T��������4�q�ԟ�����\0�`H\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��d�o\ZHi�3���ju4�Rq��\\=�-�4��t��m�Eq�\\ڂQY�8����vբݖ�D���S�i�K�M8����R��	7�)l���=�Z��+�j2��i)&���{��j�NǷjV����Ԫ��RPk<R���������z\r�4~�v�i��.+=x�z�/�G�/�w\Z,V�m3���%_C�RO�����k���uj#|l�Ȥ�n�(��r���6��-�x��S���Y\n�IU(��ܾ�e��m��z���Ֆ���}��^3�������\r�_�����#-q����p���Mv��v�E�\0Nv\rG��)&۟\\2���c��%�O�f���6�WD�:5*�ɩ%l`�l^1֔{���uul��\Zm�O��Ud���2��b�B�����>�����\r6�R�䫗�\\�k67)A��4��{��_�;�,�S���/�������^�Wd��ݳ�8hԜ�ǋl��)t��b+]�����M�I\r6�vB�X�N���N?yK���V�F٠�ED�*����r�����^�+o^[ڷ������a}o�ig8�Mz����?�{v�s��Eg5NqQyX��K���o�Y�7�Z�([W�SQ�O�m�&�Ǘ��&ɤ����i�d띎��i����Tx{�t\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0^�W?z)����EE.@l\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0��','width=\"350\" height=\"350\"','','no_image.jpg'),(2,'image/gif','GIF89a�\0�\0\0\0�#$�!�#�&\n�0\n�*,�AC�:�75�RP�RU�bd�BD�T�U	�JK�ru�NN�\\\r�b�g\0����j�aa{���|x����\0y���}�mk���l��e��m��f����}~h����U��c�������O���\n��S����C���������E��Q����<��L��N��7��&��9��)��;��,�����/��1�����G��H��J�����U��Y��Z��c�����d��p��r�����|��}��������������������������������������������������շ���������ֿ��������������������������������������������������������������������������������������������������������������������������������������6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��6��!�Created with The GIMP\0!�\n\0�\0,\0\0\0\0�\0\0�\0�	H����*\\Ȱ�Ç#J�H��ŋ3j�ȱ�Ǐ C�I��ɓ(S�\\ɲ�˗0cʜI��͛8s��ɳ�ϟ@�\nJ��ѣH�*]ʴ�ӧP�J�J��իX�j�ʵ�ׯ`��hYclسh�\"-˒�ڷp��t�A�r���{��Y�\0��/T��6̸�_��n�4��˔3c�;�#f�M/�V�4D�6�t���	�- ?��\0��;Ϟ;��̙�\Z.j���+�iys�˝t]��kׅd\'$m>������GO�:���>�9o��E\r��$D��秤_�}��%W�u�u�h�$BH!~l�Gm�����G|\07\\{{���}_�Y5��~���b����b�/�7AY��Ӂ�\"ȃ��� ?\n��my`x�zu�{���{p|�F#�Us�,���L\"Is�,�H��I��$d.��$3Ј��8�h� ��# z�Y��E�[���!�����o�G���\Zk0�\Z�1%��$�@b\"g�������)\"��*%��	�$~�	��2��!�qW�m����y�wǠ�w�m,ep4�F\Zq��\Zi����v���%�_��\"�j5�J�a�\n�*�*��Q[��-�X\"���l�����A!z�	*���J�h��.۬�h�QB�jc���*F*�0�Z�ǖ*gj$dn�����n��%�� ��+��Z�ou��$�����\"m�h�a��(�I�e!��-�ܦۢƥb*n�S������u\"n?�!��D^�G���!\\����@3�l\Zk�Q���ϞAH�K�ґ}<.���{�Ơ�J���%^�t��I`�Ikvz�f�m��6y�����^��a��m��(�e4�����w��Jxb��������qӓT��3�;$�X~9I`/�#��y�����ǅ��Q�{�6�!�@7��w�q�޹�>��ck���*%������\"���\'9�Ioz#�W�ju�����كr6A�))D�J���ؙZC�����0�����t�/��R� j�խS)�Eajj���Eb$�?��S+��i_x��o�p�%�\rTJ�5%���h\r#C�@�0x��aP!A7=�5Nr�Z���8�I\"r��\0#�$/D��$A���+��\0���֓�;<�g?c�>Bh��hf����E�q`�X�(��1N��y\0���sEB�΃^$\"�<�ĕ��h��!\r+DP� 7�,*9�\"<�/9�0�����&9�Lyaj�+���X&F3^���H&�0��Ց�k�����CQj�b�:�-�}�3a�N��0�Aa�2�Lf*G^o%��$*�< ��U�܅��&��|�y\r��M\n�� ;uƮ}h\0���0OK������R\"�[c���(��h�\\)B(g\Z�*g�����#3)B����t�:E���z����;J��g8C� |z�`C?�w�5t�rZ�@���ĠM1��N�\"�mZ\nM7l�I�٘��WKQ����D6��iX_�H������j�\0�1���\Z��d�n&G4��E[�E��ZS�����M�,�J�:�Ă�D1��\rs(�렸A4�!�#Ū<G��|���Be��ٔ�v+$���*S�\0�,r%-Bg \r��h��$\n�F31�Ts�e��9;eG6{χ��:�6�u�[,ߠ5�nU���K���	%���*�%rqS�dr��+Z��`*��B]���֐\0�\n�Kwbaso!�#y�hS���|���-\r\'�\"=���1��Ǔ�B��dM�c+2\\+H]3Y���mS\r�D�Rzl��$��fI�+�P��A/eg6�\Z�\"�\nL�J�o�,�V��U/X��fk2:ej�J����1��\'L�B+��*Y��x]��ę�\r����m�A+B��6���X�N�-*�hX��fUy�T�^�\"2�9d>?���e���x)H�4?Vv�\n�F3\Z�-B%�q�ܷ|9bs�v���AHH~��Ge�(�8�{��<-F�zQϓ0��<)�2{4J��g��°����4��\Z{ٮ��A\r�w#&.�2�!\Z�p2�yG�p�lpC3�d�@P<ؔ^�:Hݍ��}�I�� ��Y�a���\'mp?e�i:��j�JP5t��.�c��4Φ�\"\Z���FG����?@�tE��u��T��.�Z,\ZV��r�;�cP����s�E���\0��Sƕ?!��ε�*\n�=2��1]��)�t��̸\'A=�amHrM�4(�*�����Lxɮ~!ݳk�z�����d��j�d��s������\\��]C�{�f���kf��S���&�mC�Y$�Nm��\rw���VI�ʒ\\Ϝo}C~\'�}�m�7�\Z��,2�o4��z��E�a^D�\r� �L�\Z� hqވ\'g�Jφ�u>(�����>d�X$�U\'�|��Ob�rew�0�11u}3�d��8��z�7\Z;WwR~x���(�i���f+ړ�$�����:\"�q��H��cwc4�4y^�R?���C]\Z=]2h��<JH	�� �.��I�z���\n\'m�7RD��+�=��:L�TQ�T��A��,HR�c[DA�g�(2��f)�^cwT�r�!t����Yh\'E�bӶ#�!�!AE�g(X5CS4�;��sXpW��s�>TI�v��v�&E%Z��\Z$B-�0t�WDG+b�20cD��/�C!�qy\0�\"q�T�(�B��s���H��Xv�R@�h��<3h�Pv�7�/��[���f��V��^��2�53��3:z�!�a(�X�H�Z@�X��\\@\\pU���.W}�ce\0� �S��SS �H�������i�6!���qw�3�E( ��(�% �6�i��y�I�\r���SH��r��%���+�5%+$؎���wa�=��!4�+Ib[27��y�[��\\�Y�l)�W@X��U��T �F�hp��&�0�1+b^�\'Q�!+��)��`��d�i�8֖�~���+%��(��To`p�\\�8I�6�8�kI�8Y�q�y�\Z��F�\Z�	�֗x�qL�?i�*�2^8��i��	�	׎{ǅtB@bD*�/���#0��\"_k�,��O���)�V�6��W��ky����U@TPq�D�\Z�V&�3	��i�rb*v����4g�)�Bz$s��!+��)\rzp/��\'�/�!�d,r(��(m�\Z<x��O`�y^ �_`�����ȓWp�T@�9�����\\CTH�-|��o��*\Z�o\nE���P�&sw�W|����\rj� /,)�d>�S�S��0�d�dY�SY&`��\\�+����颯9���������1}�\'2(B5)��P\0/ w����X#sI�#�%2CZVSSV%�����)	�H8�����:���Tt8fU(�B�d`���EY]\0V_���I�j)�ry�\nY�sj�A	w\n�˱�kҊ	�Z\0&���5��&�曡r^mts�!���$�)\n׎.C1�:Xq�T\\�\ZHUW�7^�I�7`��r�I�`Ŧ	�U��\n)���1\Z�u9��;ѫ|�1|�?o����@���s\0*hb*넨5s �P�1	|񤚒�I�Z�i��.:q�K�:�H�&��E?hIa:�g�g`��Z �	ɖY�Ԙ��X�\\0�Z�u�9z#��M��1]��F^�����u��z~�\0\n%zWVe³��.��z��`��霋p�f/�.I�6sP: �T�s�䲣\nf@n6?֮ZЪ���y�+J��)�C���ʯS\0S��4df�k��v��]��\0&�s��\ZE�*\\�7c�����`��⠱W\nׅ�@-�\'(&�3�:��0��u[�R?�n���y������=��sy�	��J�D�[Q0����*\Z�*@	��\0����\0��\Z��&)��KG^�u<�B�rr��@	�p���p�و�2Ԃ$u@,�E,��(IUF~#\\�c��c,��`���I�����ɓ9˯��:�\Zu\Z.��?���Y&9\r������{@w��<���v��.�fJx5A���Ҡ_����D��n�^�bK��KcT��xkI�Jr�7?BF�e*d��]`�어��/�����D;T�Q�T�5<ʴiB*��\Z�\0b��3���/�����V{`��#��I�.�5	�)��5��Sh!������F���C�p�x]�f��+a�K�(��>҃�uY��IaWƩ���y�Zp�<�9�$|����P�U��\0��$�X&&��\"��N���b^�\n�6|{�Y��߼;�h����6J�%�ʡ<MS���[��w����o�b��Lt{7�Q�br�:rK_��N���e�T\\4�%gpy�d�����k���������s9�\"L�q�(C��\0�?NZ���iG������	��	3} 4Ԅ�Ƭ͊#��1;5��!��ܴN��ت�R���@��xE�*���[��(hp���v�R�V�F�gJ�9��ɳ�\n�)�t���\\�:U���-S�amt�\r���\"&�S�;}�?��&��H,<0U���+��r�-�=�p�KʘF�`��-��F����O�qS��[n�T�BfOe�[ d7ɼ�Y��<Y�1:�?��C\Z@�6�8WSWB��W�8�ؖrSț���?���F-���vM���#oG1٠7*����˜gʊ�w\nB+ \'����N�|��RЮѲ]4����;��k�i9ѨY��H��G{1��M�Z�\"o��#�8	�����j2�1f�����\"eJ�X�	��\"��8�\n�ꇈDw�M�p����aN��$��q��>k�ծAn��\Z���gɦ��UЀZ�@MhcReake�\'�d�e���`L6J�}8WSeM#]Ψ�����&�JT_��i��.C{��~| �s;>�*�[\Z�7�B�XULat ���	����g�%�..l�&<��0\Z�yV��n�?�R�`~CaK�Tco���5��.��ɋ��̜�\n�b� �q ���:޻�q��-\Z}�_0}���G�k�\rC�.+�\Z�*�C�a�݌C�5�o}\r2�o�M�+����f<�����<�\"��g����D׈�Y+Nڣ��-���H�A\"e7B~��Ŵ��-w�QP��bN*�#�G-�Ao�lgN���=�;z���HJo�%��u<L�ء���2����?��S�|�@�N��[8{�Mf^Xpױ��q��TS�mw#\Z`dv&�OQ�\n�S�n<*B�3�)�}�k8ݞ�S.\Zs�����1o�\ZݢB�j�v%�#�������Hf�J��,�����Z�q��V k���/�PQ�q��7�ђ77�0�qU>FnЧO�;��&l�O�n��G�8.&lW���<s���弊I�*���@�v��~V��<�a׊�8-�	��B�_1�윰��꧈(ft�rf��9,p�\Z�Bc\r�E	��O��+Uk����юK��?�QP�\0�O�@�\rD�P�B�E��%��M�tQ\0�=~�1�É�,\"z���ȑ]RD�p�$��2�4����H1�Ir�ƐE=N�h��Õ#WR̉��D�F�Zm�U�V��R]��E� 5*k���E�*4�P!A%��*�;s�\ZM�&�`4eʜ!C��3a���1��x���oQ,W�T���3*S�|�Rz�(�Cv�[6C�-����ZwQ�,c6�yS(ˈ={VZ��gF��;^\n��E�/�N}��9��ݽ\'�(�R�I�IZ	R�F�-JT���Aq	�I�G�v���#.����1�L�0�`��˼��\nϰ��B�@��\n(��\"5Ҩ����F$�!�n[N\"�\"	1D���:�T��6����\"�h܎ƦX�\'�RZN&J&i����D�FB���:d�D�*�A�K.?�C���ܭ02�\0��[�M0 �˸���ݸ����>�0C>����(��IC�̮$��C�$2]4.Q���\'�|\Z2�E��7L+=�6��;�GE<4խ��D���kD���[+C�\"��D�k�S�;3��;p���#1.�39�t�N*��bZҮ�pO*8��\'\nU5\\�j/��L���M�]7v���M2�7^{�u��y3�$�$ݥ�_v��v��w�G�e���&�D�IY���h�ϭ�����?�%S�a3�X���B2˶�����\n	?�b��S{�f�k�g�(�eɤ��CW��@`E��6�&� az�_����w��9k�p�d,Yim�V�\nٸ�S�c��x��S֌eI�����-�؍Z<����mIK-�)�Yk�J�)�b�9��N7&�/�<s̷��*�?W���G�	��`E��D�b��=��k�=�@�\r��1Ȑ�B1L#Δ������-���\r7m\n�F�~ �V�nӋ��)��~�(|���t���s!t�AgW��G�<I����S�5�G�����ހ�9��L�!�c�(�,�A�^޸��ݜ4�V.�!�}+q�[\\K�ӛ� Ir��	�Ĵ�,�94�ch�Dj4�JԤ6=*N&Ok��nE&?�.{�C�\0���!mo؃�����C��2g�	oZ�S߰�A�152��>�C�!�\'A�T���(\"I�Jx��G��o��!�n�c�;ZEs(Y#��*D�G=ey \0�J������4�=0q�-� cȘ�A����.��xtM��A�}�4ݪ�v���$K�Q���s�$Q�%1:��Ü�8G/�Q�b�D��g(1O{\"�I�N{8\"��D&�q��Z42�$k��C����U�eat�/��8�[�ѥn���c:i\"��uB��$D=�HD!���0�\'�	DN�$�u�F��$隁��H�TO�\0a@Xy���D��o(g?��)�w�ʾ`7��i�{�n��A\r�	P�	�k�PҬ)�H4*�n2R��ݦE�r#�sђ�(��!�0K%M��u/ơ���4�5b;b� ,��I�wH��E��A���OE�/<���Lʄw�	\Z��S5뼨:\'�=�h����ݤ��*��W��K�d�]�&�����q�l]��>����uv�M^����x�\0�6&.�j;�N��&2��n�=e1C<����Ս�F�ϝ�j��NP�D�NQb\'2\n�[]�B��rE�c	vZ��R��!d���rޞULj9$ز�\"���d�9δ�Nmjé�й�)�d�S��p���mF��e]SK�y���*�N.*��%\n��\n�\"r���W��!�P[GD|�h�Uڋ����o-ja�n� I��A����r1E�3��(c�,��n��J�],��o-ƚ�KD�&�SN*r��0w�h^���\0�g���Q��������]rWX�F+[9\'�{��+;&�(_�C�J���oA�g+K\\Y�&�I�4�&Gg�n�{mU$��h����;կ;�a�:U�J��?K��|���^���dJ�P\'[Y��B����c:\"���*�Xn�����}�^߯7�kqJVd�X]\rAC8��߼�CR�dE ~�0S���N`���;��%(����ŧZ�:�hoI�x#˅h��Z��mwϛ}_��\rq��.�qN$n��$�c`Q�JOWz�F�������[Nx�V3\'T��VW̿#���pHf��cC��d�J;�]l���ؠ�:��s�E�jٷ:��v�;���2���yϽua�m悄\\F��O��PwB0��\r=��JP��ޝ��$�D+hO`	��2,��\\iqh���WY�\r7���1�V�R�|��wPb�M��X9b�����_���s�AU�	rz�$��g��J@��g�Wr�t/��Y��N%|;���v?s��L�k4���ܾ-�����{\0HW7>=�������\'/81��0��ی���h�Á�AYAy\'�8��@��@$�?؈����2�ÈZ�����Z��=���Q���	��\"����HAٰ��������4@�����T��:y�ӂ�k�@jQ�����o��9�Հ:A��\r��,\rԾ̊7���؄G�\0V!�\'Y�݈�c�/��#�1�y�?��Zbr�BD6�\r��CPE8�\\8 )������r\'�X�1�k��\"�S<<�½�la�烂��(p�)�(�:�˼%�:\\AE�\n+�\"�\r\"��r����P1��H�?���H&���7\Z���:^�sě���ĳY��/{�KL�� %�`�3s�2��c�L1�;ūhAљAٖ\n�¨�E��Ū����>��Ɔ(�fl��R�3&Z?ۈyA��Fث�zC��8�3����ʈ��\n+!$B�э#,,�0�\Z�q�/K�6��hq,ቬ�s3��Bji@Y��X����A�<X��X�8��>�s�]I�H9����F;$��\n��*����-����ӂ�2݈��l�ZQ��$�D_�����Y�� O�ɘ�D$��3�:89Y�UJ�⡓-@�xl�<I�X�oY�ni�(��}�E��Ǫ�:����8��J�}���\r\\ˣb����QٞC�I8�zY9�0\0`��̣�(�T��H����\\��s\r?Ȥ��6�˿�2���r��Q{�ȸ� ,H>:��ӈ%�G{\\�����\r�<�D�C��$N�P�9���HF�(=!�/:b/�{p5���S�L�	9ל	ϺσBȽ������B\"���x�6x\"��230�6h3�D�Үf�(l�	Z��j��K�<�<q\r�Ӡ0�/�:3���\\$�\r�P��5TK���9��dL&����\n��Y���]JR�x�������\"�,��ة��68�N�0��`�3*�1:�s3:��L�	Y1�8J�s:�l�)�8�$ͩ�����0�Ґ\0\n� 7��1��͵K�x4Ac4,�7}q����Gh��j\"κ;N��A�A�ƿ�����\",s\"Q�����<�\\��\"U�.��,�*T<\n��x*/ܐ�yE\'X��R��>�þľ0�9�	��89Α7�C��C��aU�<�H<I3�սشN��6��.��sB��IQ�\"�KL�T{��Q��Y��=���CEmJ\'R������W������x=N}7vmW8|��W�|�9�?�\r��,s\"Mr�9���S9�\r�e��i�-\0#,H>}�l�E�j����:X���֨�8]D�HY%��현���\Z&���Q��}Ww}٫���Կ���]���\0,\0*�\n�F�J\"*�kL-ťՂgJ	�h݌nQO�����%HԌ���ϩ�V���`\"�|��I���ۗ]ݸe��EM݋U��1�[ٙ���W��̐\'$�)t��Sē?\r��é��B�	����ҜO$���#[�pÏ�C�`��m;�mݷ}+����3�Y���!�̻2���ī�H�r�?8k,ȰR���VB�{V㥂��[�Vd�1�^˫Ōs8���pG�M�\rֲu�,e+h�������{��I���\\�˸ؕ����?��	<�d��#�-x�����k�%Üi�%�?��5_���Ȕ02��O��\Z0�s\r��&���5\n���M�0��?�XBTC3�B��a��ӿ��ʓ���[��Z㎨��(U_KOu�Ս�{���5(V��A1^��!��	���<�b�UD��K�xaA\0�?��c�.���3��5�Ϩ���\0Rn�XS�A~Yq�0Pu]�a?��b���CMޣ<z&�ر/u^�˛�K<������(:] �<m+�8�ɟ�Q�Z�Ļ[�`%k�{q��뚲KߨI�s���sy�\'Af� �������:k��i�Ij1�@��8�3(�m���x*�-Pe`?����?)#R�گ%��&�w�Hp]�эfΣ�y?�1��i���#bD+��R�r����]���_y�5@��ӆN�2@�3��(V&t#�*��i��5>Ҹ��蓝�Z�ļ\"(���,���>��--���F�������[�-jL/�|	7L��@\n�I��?=`���2��4�I�p�F�\0	�18�5�.�S��ɦ���J:�y�����%\0[��*�^�����!���΃��=�L��xF���-��0�e�K}i1ތ�_>�+���)2,t�Ι$��2%Q*��l��o>��3��V	�嚩o�>Ͻ<�������mv���n�@C4x9�����\n����Jᢨd����@Df��\"��[�<��$�R���nȎ]j��3�l�96Aq��g�J����\n��?��}ʖG���[�\"��Lê�֎�V�F�mr�zV��\"I��c*ۯ�CI�Ȝ8��\"���b�T���Q��v�9<p�� .�n��)&�2�TQE�4\0	�j2@�0 �S�Z��\0E�O��,�%�#2\n���\\$R�Ӹ[�V֞OI�Z�.�p�-�3�I����s�Pe�L�\0���N\Z����T,/�`��=�ka��q}5�>�J�n���I95���j9	� �z�,�\"��������f�љ��ɠ�EAQ`ʋE�KCIo�\" ��oL�+�\0�)�/����`����L��	��#��P/�P�!�������K��z�$0q���©�8@�8��b/�������,1@��<�⽠���Po�q��J���H����8�6����tH�Z\Z7����#��b?�\Z���X��J+~�\nӵ��J�cj�D\n;8���5Q�? .=hxK�YP3Q3�H;7�h\'6y,9��/���\\��&O\n�᧝�k�>Q��HJW�Ů�`��>�ϯU�\"��!Ow���\"�Hc�[K��H��{�N�\n�1��/��a�0A\ZXO��H�г��;H���Jҹ��׵�6G�6p��G6���KX��\0��x4>,̓Cϖa\ri���:��:5�@���7���L_P�R?�#�Xd��w�Q��s\nߎ�<,+s��C�u����#Jص�Xb�z�/��\0�7o��)h���8	�0D���2#�h�\"�1a�%��^������Z�\\�r�*\\�\\�ɒK*4u�R#ЋN�Lq�d�(K�(i�ĉ��H�i:�I�������5(װbǒ-k��ٯ@�JB�k���&Q�;)n�V6�ݤV��H��F\n\\�.\"J��V�T�R]�n#J9��˘+����]ȉ+-l����.������E��gӖ��>w�~gN���L��!�e��Y��˘�_<���%%�-ZLbᒅ�ᱼ��\'�+=�P���\'N�\Z����H�,A�_�THl`�v ���v�[��W_FX�E�Qvab�P�Zi�A��`x��iq)�V�&Z(�[�5��cx��\Zk�Qx�W�	��V���z�ћo\r�qI���i�A�g�1��}!I\\\\7x��tSL+�$L9��^{>���QF-��Q ��T���UET�\'�8�#�	.H��~�V�~�x�e�I�ى�9jZ]�I_��u	_���(Zd�~	�5��\'���Y�푇��QP�%d\Zq0��DQ>I�OV�ZH[p��vXp�E2�G�Mf�g&�S�_�W]�TTMM�\'J�_�}�+�6��V������~Hbj��ře�H��R��]�%���p�i&\n7��	L	^��&/��j�cy�a����P�ʡ�ܰc4�Ǻօ#��ex�9Sw4���2�tm�9��|P(�S��ן��>U��H�{��Uo�\Zm�b<���H�/�v�\Z%�E�V�\'\n��\Z����ŒZham[gl5���q�k��PǙa\Z\'/���=�2��m7��6c�sϗ��3�>Ua�Ol��-�J{Rxf�����\"�7l��Z� �V�h-\nFIڈ�*#���&�isQ\\7$��u�/d�����	ޑ���p%�k��NY,�aPyc^��L/��3���^{P��О���Q�W����!�++Zኟ�Ǯ��Hk���xw\"}I�2#2��а�\r/\Z�ۍBd*�-w+\"��H5&��b���%�!�H rCcQI#a�����,̬&�1�L<���Q�~Q�kF7�) �)�\n�ꤺ!p],T�5;z�4�I��<t6��Mm�h���W<�E\nw��^�>�!D������B�� ��կ����!f �F��C �g1��N�S���=ښB�<�=*�j������RjWK  cY�1��\"���`��L}�T�4��I�4!��\\##�ԑ_�h�eɮ�y�Hi�Ch�8��Ig����2 ~�\nA�z6y���	\nA�I�Hg�ةt�����:�H���e-�5��^�iLeC��n�Q&��#i&��\"tIr����\n�8�$)X���F|��e�;8q�Kz��s��I|�0��ɔ�ʷƅ�V\Z���+�(R�����Q!r��8s�ѥ2,�.D����4��BE���<3�f��k�$Æ \'\r��a��u��&&�IL}����\'�{�N�Ϣ�\'\\\0\nT��\"��^<kG�Z�-f1e��W��(<ꑙ&2�$pT��Š#��-#���*��:H[�z2��dx�xr��)�\'izBN��*��/o�T�T+fŀ�c]������!�e�x����0�,f��r��MƘ7��\n#I�(1�}�^s���oI��Ұ�g�ٌ%�;Iy�ۓ�EA\':��P��z�I	H�S�*]��Ӎ*TQz+e���Z���z��N���:���\n��b�)$6��`=�X�yI(D&��\'�5�����B�參�Z�Rh��p��)Yڕ��u���<LJ�M��!Xgpt�\nV��g�0��沤5�$��[#r[+]IY���z�D�t�s�;F�`;اޒ��,�)o�^.J��9�P���m���ě��͑Bj$^xw���(��OVK�ꫜB	6!��Å�\nz����u�Μ\ZU80SUhjZxk�#UF/�٩.*�buX����қE��13lS�暅�aD��$���JW���\0[τ<�����\\`�h\n�N����FC��r�l�<���-^�*�:��A�RS5�j��n3$d�3��P /p��XR��o�N�l.Mč�\0J(�[��ؾ�=��F{w-*s��eJ�+�UmՈ(hP����ͷU}#0P��^��v�\0r׈g��m��\n����5:�bΪ�Nf2g�rx)ݻ�J�w����ʋLKOp2`W3ō��4���y:IJ����es4e�O�E\\��\Z�^�����J�A̢V6B�������K�pb����v;����\r��SG�0��pA$Q��R&��i~�4t�?*>�뫗�&,�KI4�\r�č���ǀ�����3�y�f&��*Xd�J)h����-�\ZZ��d��C�����x�z]b���r*�t�Ň���$A�@�E�Pl�ۊXU�݉L%`�����5�X�������H������I�l�ॄg���)���\0ׯٛ޴R��ˁ��<��i���e��ی��4����g]����EYƣPNW�1��uh�G�����x�yd�1�;\r��	���T\0�*AX\n=V�H`�	�\\�X��K�I�i���iB]� �4b	�P���V�qD�D�Dnv��\nvGE_�ޯ� q����\r\"X��R)��\\D#�Ke\rj9`�!��X�i��iU��\n�ݢ[X�T�	\"�0��Y�A�GD��y����G�8Ki\"Lp\"��{��6��p\rٍXEr\r��4�1���X��9\n$\\j�16��ȣ\0��0�c�	#>�9BS��|�t�<x���O��O�\\D�\'n�p}R��|PH)݉��?�cU����!0�c?��J�d��HJ~$@֒F�A	�^�q���J@��Lx�������6����N�h$\n�*1\"L�����TUB#Kf�V��K�cT�ilĹ1�ǥ\n6��X���ИO�U�mc\0���_|���T�R�A�WF���B�@b�t\0l%c6&\"�H?&RՒ�����GDb�u��_Jt�%��K�G�����QZ]�6��NA����R��K�,�d*��ϴ�#�V:�pr%_�cn�S@��Fp��\rd�=��X\"���xT��]�o��q����GF�F)��q*�i����b�dP��PBp�JRH<�y�e�S}��IlA�|!vxGO�$M��Md]�^�Z��!l ��g��޴��e��ݣ�<�e�@	����@��(	����h��@	�(\r��s\rcq6��~Qɓ\\&Yf���ČGğt��]�������S_Q���\'�Rl���y����V�x����c�_YUuT�P�����\0>Vh��xi,	���d$v�읛IH�� ̈́��Ę�X���\0Vk�\r�l��Ұ��\'�FY��g	��[�-����V�ч-�)S�ą��T�\0\rl�,�NX�A�~���AhILN��KQz���i�}��Q�e���GT���F��*:��ob���A�zqX 2-2��b���@X�4�\rW��F��ttĹ��g���UK�G���LuG�^{��Z�͠�b$�	ְ��5��ܕYF\rS�����a��p���\\8l���X�ker��9��\\�tB]��L\\����`K�h]}#����SH�P4,ɖ�b�i�pl�]H!�����E\n^F1a�]xF�\"\'��EtP\"�N�3��ukz|�h��yX�aq�����YQ�&T��R(��n��yX�9���K�x�gI���iH�A-ܨ��Ӡ�:�(�}�9AK��k���5n��@��m]�=����P�ǡ��㢧\0\n�J&\"1���*�>J�<���#�Q�l�vA��_��LJ�����j�����_,���p����9n��mbD@*�\'�f%�~o��b����R�౏h2�̒\nM�(]d^Jћ�)y/�\Z��/g�\ro\0G�I<O6dw�D���^�ϵ��фb��&(E�R���� \r�F��$���	�#t�0	�_���h��[��v�`�6*�n~����-�����0�Y���w|�xM��;�`V��m�ƇU\r��Kl$����`\n.d��%�DMpRo����Y�qF���P̆\n��K[�!%0c(�\r\rk{��9��,n��q�]F�F�A1���(\n�@�B��zN:1^�q���m�=���	\'������d\0	Ѐ\r\0�&;W*�2.�.�2/��/�20�031� 132\'�2/337�3?34G�4O35W�5_36�F@\0\0;','width=\"515\" height=\"184\"','','prueba.gif');
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
