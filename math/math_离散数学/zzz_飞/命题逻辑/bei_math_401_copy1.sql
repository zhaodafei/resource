SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bei_math_401_copy1
-- ----------------------------
DROP TABLE IF EXISTS `bei_math_401_copy1`;
CREATE TABLE `bei_math_401_copy1`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fields_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fields_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fields_3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fields_4` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `compute_1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `compute_2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `compute_3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `other_sql` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bei_math_401_copy1
-- ----------------------------
INSERT INTO `bei_math_401_copy1` VALUES ('序号', 'p', 'q', 'r', 's', NULL, NULL, NULL, 'SELECT fields_1,fields_2,fields_3,fields_4 FROM bei_math_401 GROUP BY fields_1,fields_2,fields_3,fields_4;');
INSERT INTO `bei_math_401_copy1` VALUES ('1', '0', '0', '0', '0', NULL, NULL, NULL, '这是校验是否有写错的值-fei');
INSERT INTO `bei_math_401_copy1` VALUES ('2', '0', '0', '0', '1', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('3', '0', '0', '1', '0', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('4', '0', '0', '1', '1', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('5', '0', '1', '0', '0', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('6', '0', '1', '0', '1', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('7', '0', '1', '1', '0', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('8', '0', '1', '1', '1', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('9', '1', '0', '0', '0', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('10', '1', '0', '0', '1', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('11', '1', '0', '1', '0', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('12', '1', '0', '1', '1', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('13', '1', '1', '0', '0', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('14', '1', '1', '0', '1', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('15', '1', '1', '1', '0', NULL, NULL, NULL, NULL);
INSERT INTO `bei_math_401_copy1` VALUES ('16', '1', '1', '1', '1', NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
