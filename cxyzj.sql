/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : cxyzj

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 11/10/2018 16:46:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `article_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章表的ID',
  `user_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章作者的用户名',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章的标题',
  `update_time` bigint(100) NULL DEFAULT NULL COMMENT '最近更新时间',
  `article_sum` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章简介\n',
  `label_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签',
  `views` int(11) NULL DEFAULT NULL COMMENT '浏览量',
  `comments` int(11) NULL DEFAULT NULL COMMENT '评论数',
  `collections` int(11) NULL DEFAULT NULL COMMENT '收藏数',
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '文章markdown元数据',
  `thumbnail` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '缩略图',
  `status_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '表示文章状态\n0表示草稿\n1表示已发布\n2表示待审核\n3表示封禁',
  `levels` int(10) NULL DEFAULT NULL COMMENT '文章楼层数',
  PRIMARY KEY (`article_id`) USING BTREE,
  INDEX `fk_user_article_user1_idx`(`user_id`) USING BTREE,
  INDEX `fk_status`(`status_id`) USING BTREE,
  INDEX `fk_label`(`label_id`) USING BTREE,
  CONSTRAINT `fk_label` FOREIGN KEY (`label_id`) REFERENCES `article_label` (`label_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('495628181437415424', '495292298867769344', '2018年全国多校算法寒假训练营练习比赛（第五场）', 1538208566781, '3', '2', 0, 0, 0, '\r\n![asd](/img/login/1.jpg)\r\n\r\n## A 逆序数\r\n\r\n水题，使用个归并或是树状数组都可以，这里我用了归并。\r\n\r\n``` c++\r\n#include <bits/stdc++.h>\r\n\r\nusing namespace std;\r\n\r\n/**\r\n *  Created with IntelliJ Clion.\r\n *  @author  wanyu\r\n *  @Date: 2018-02-26\r\n *  @Time: 21:57\r\n *  To change this template use File | Settings | File Templates.\r\n * \r\n */\r\n\r\n#define maxn 100010\r\nint n;\r\nint nums[maxn];\r\nlong long ans;\r\n\r\nvoid sort(int l, int mid, int r) {\r\n    int len = r - l + 1;\r\n    int temp[len];\r\n    for (int i = 0; i < len; i++) {\r\n        temp[i] = nums[l + i];//复制数组\r\n    }\r\n    int i = 0;\r\n    int j = mid - l + 1;\r\n    for (int k = l; k <= r; k++) {\r\n        if (i > mid - l) {\r\n            nums[k] = temp[j++];\r\n        } else if (j > r - l) {\r\n            nums[k] = temp[i++];\r\n        } else if (temp[i] > temp[j]) {\r\n            ans += (mid - (i + l) + 1);//逆序数\r\n            nums[k] = temp[j++];\r\n        } else {\r\n            nums[k] = temp[i++];\r\n        }\r\n    }\r\n}\r\n\r\nvoid merge(int l, int r) {\r\n    if (l >= r) {\r\n        return;\r\n    }\r\n    int mid = l + (r - l) / 2;\r\n    merge(l, mid);\r\n    merge(mid + 1, r);\r\n    sort(l, mid, r);\r\n}\r\nint main() {\r\n    scanf(\"%d\", &n);\r\n    for (int i = 0; i < n; i++) {\r\n        scanf(\"%d\", &nums[i]);\r\n    }\r\n    ans = 0;\r\n    merge(0, n - 1);\r\n    printf(\"%lli\\n\", ans);\r\n    return 0;\r\n}\r\n```\r\n\r\n## B Big Water Problem\r\n\r\n名字说明了一切，超大水题。。\r\n![asd](/img/login/2.jpg)\r\n直接上树状数组模板，都不带改的。\r\n\r\n```c++\r\n#include <bits/stdc++.h>\r\n\r\nusing namespace std;\r\n\r\n/**\r\n *  Created with IntelliJ Clion.\r\n *  @author  wanyu\r\n *  @Date: 2018-03-01\r\n *  @Time: 18:59\r\n *  To change this template use File | Settings | File Templates.\r\n * \r\n */\r\ntypedef long long int lli;\r\n#define maxn 100010\r\nlli num[maxn] = {0};\r\nint n;\r\n\r\nint lowbit(int x) {\r\n    return x & (-x);\r\n}\r\n\r\nvoid update(int x, lli add) {\r\n    while (x <= n) {\r\n        num[x] += add;\r\n        x += lowbit(x);\r\n    }\r\n}\r\n\r\nlli query(int x) {\r\n    lli ans(0);\r\n    while (x > 0) {\r\n        ans += num[x];\r\n        x -= lowbit(x);\r\n    }\r\n    return ans;\r\n}\r\n\r\nint main() {\r\n    int q;\r\n    scanf(\"%d%d\", &n, &q);\r\n    for (int i = 1; i <= n; i++) {\r\n        lli temp;\r\n        scanf(\"%lli\", &temp);\r\n        update(i, temp);\r\n    }\r\n    int f, x, y;\r\n    while (q--) {\r\n        scanf(\"%d%d%d\", &f, &x, &y);\r\n        if (f == 1) {\r\n            //更新\r\n            update(x, y);\r\n        } else {\r\n            //查询\r\n            lli temp = query(y) - query(x - 1);\r\n            printf(\"%lli\\n\", temp);\r\n        }\r\n    }\r\n    return 0;\r\n}\r\n```\r\n\r\n## C 字符串问题\r\n\r\n## D 集合问题\r\n\r\n**以上两题先跳过，等复习到字符串和并查集的时候再回来补**\r\n![asd](/img/login/3.jpg)\r\n## E 情人节的电灯泡\r\n\r\n二维树状数组，也没什么难的\r\n\r\n```c++\r\n#include <bits/stdc++.h>\r\n\r\nusing namespace std;\r\n\r\n/**\r\n *  Created with IntelliJ Clion.\r\n *  @author  wanyu\r\n *  @Date: 2018-03-01\r\n *  @Time: 21:50\r\n *  To change this template use File | Settings | File Templates.\r\n * \r\n */\r\n\r\ntypedef long long int lli;\r\n#define maxn 1010\r\nlli nums[maxn][maxn] = {0};\r\nint n;\r\nbool lamp[maxn][maxn] = {false};\r\n\r\nint lowbit(int x) {\r\n    return x & (-x);\r\n}\r\n\r\nvoid update(int x, int y, int add) {\r\n    for (int i = x; i <= n; i += lowbit(i)) {\r\n        for (int j = y; j <= n; j += lowbit(j)) {\r\n            nums[i][j] += add;\r\n        }\r\n    }\r\n}\r\n\r\nlli query(int x, int y) {\r\n    lli ans(0);\r\n    for (int i = x; i > 0; i -= lowbit(i)) {\r\n        for (int j = y; j > 0; j -= lowbit(j)) {\r\n            ans += nums[i][j];\r\n        }\r\n    }\r\n    return ans;\r\n}\r\n\r\nint main() {\r\n    int q;\r\n    scanf(\"%d%d\", &n, &q);\r\n    int temp(0);\r\n    for (int i = 1; i <= n; i++) {\r\n        for (int j = 1; j <= n; j++) {\r\n            scanf(\"%d\", &temp);\r\n            lamp[i][j] = temp != 0;\r\n            update(i, j, temp);\r\n        }\r\n    }\r\n    int f, x1, y1, x2, y2;\r\n    while (q--) {\r\n        scanf(\"%d\", &f);\r\n        if (f == 1) {\r\n            //更新\r\n            scanf(\"%d%d\", &x1, &y1);\r\n            if (lamp[x1][y1]) {\r\n                //亮\r\n                update(x1, y1, -1);\r\n                lamp[x1][y1] = false;\r\n            } else {\r\n                update(x1, y1, 1);\r\n                lamp[x1][y1] = true;\r\n            }\r\n        } else {\r\n            scanf(\"%d%d%d%d\", &x1, &y1, &x2, &y2);\r\n            lli ans = query(x2, y2) - query(x2, y1 - 1) - query(x1 - 1, y2) + query(x1 - 1, y1 - 1);\r\n            printf(\"%lli\\n\", ans);\r\n        }\r\n    }\r\n    return 0;\r\n}\r\n```\r\n\r\n## F The Biggest Water Problem\r\n\r\n最大的水题。。O__O \"…，话说这次比赛好水。。\r\n\r\n一个同余定理搞定，不了解同余定理的可以看[这里](http://www.cnblogs.com/zhixingqiezhixing/archive/2012/04/03/2430676.html)。\r\n\r\n至于为什么使用同余定理，我来简单说明一下。\r\n\r\n题目要求将一个数每一位相加后，如果小于10，则符合要求，否则继续操作。\r\n\r\n至于为什么这个数每一位相加后与9同余，我们可以假设这个数是ab\r\n\r\n`ab=a*10+b=9*a+a+b`，则将结果`9*a+a+b`mod 9等于a+b，原题得证。\r\n\r\n```c++\r\n#include <bits/stdc++.h>\r\n\r\nusing namespace std;\r\n\r\n/**\r\n *  Created with IntelliJ Clion.\r\n *  @author  wanyu\r\n *  @Date: 2018-02-25\r\n *  @Time: 23:08\r\n *  To change this template use File | Settings | File Templates.\r\n * \r\n */\r\n\r\nint main() {\r\n    int n;\r\n    while (~scanf(\"%d\", &n)) {\r\n        int ans = n % 9;//同余定理\r\n        if (ans == 0) {\r\n            ans = 9;\r\n        }\r\n        printf(\"%d\", ans);\r\n    }\r\n    return 0;\r\n}\r\n\r\n```\r\n\r\n## G 送分啦-QAQ\r\n\r\n斐波那契博弈，不了解的看[这里](http://blog.csdn.net/dgq8211/article/details/7602807)\r\n![asd](/img/login/5.jpg)\r\n\r\n```c++\r\n#include <bits/stdc++.h>\r\n\r\nusing namespace std;\r\n\r\n/**\r\n *  Created with IntelliJ Clion.\r\n *  @author  wanyu\r\n *  @Date: 2018-03-01\r\n *  @Time: 20:40\r\n *  To change this template use File | Settings | File Templates.\r\n * \r\n */\r\n//斐波那契博弈\r\n//如果n是斐波那契数，则先手必败，否则胜\r\nint main() {\r\n	int n;\r\n    scanf(\"%d\", &n);\r\n    int last(1);\r\n    int now(1);\r\n    bool flag = false;\r\n    for (int i = 0; i <= n; i++) {\r\n        int temp = last + now;\r\n        if (temp == n) {\r\n            flag = true;\r\n            break;\r\n        }\r\n        last = now;\r\n        now = temp;\r\n    }\r\n    puts(flag ? \"Sha\\n\" : \"Xian\\n\");\r\n    return 0;\r\n}\r\n```\r\n\r\n## H Tree Recovery\r\n\r\n有一道树状数组，当然也可以用线段树来做，但本着能少写一行绝不多写一步的信念，还是用了树状数组，使用树状数组的区间修改区间查询模板,同时需要用到差分数组的概念，鉴于树状数组关于区间修改查询的博客还没写，就先看这位大佬的吧，[这里](https://www.cnblogs.com/lcf-2000/p/5866170.html)。\r\n\r\n```c++\r\n#include <bits/stdc++.h>\r\n\r\nusing namespace std;\r\n\r\n/**\r\n *  Created with IntelliJ Clion.\r\n *  @author  wanyu\r\n *  @Date: 2018-03-01\r\n *  @Time: 18:49\r\n *  To change this template use File | Settings | File Templates.\r\n * \r\n */\r\n#define maxn 100010\r\ntypedef long long int lli;\r\n\r\nint n, q;\r\nlli c[2][maxn];// 0存差分数组 1存i*Ci\r\n\r\nint lowbit(int x) {\r\n    return x & (-x);\r\n}\r\n\r\nvoid update(int x, lli add, int t) {\r\n    while (x <= n) {\r\n        c[t][x] += add;\r\n        x += lowbit(x);\r\n    }\r\n}\r\n\r\nlli query(int x, int t) {\r\n    lli ans(0);\r\n    while (x > 0) {\r\n        ans += c[t][x];\r\n        x -= lowbit(x);\r\n    }\r\n    return ans;\r\n}\r\n\r\nlli ask(int pos) {\r\n    lli ans(0);\r\n    ans = (pos + 1) * query(pos, 0) - query(pos, 1);\r\n    return ans;\r\n}\r\n\r\nint main() {\r\n    scanf(\"%d%d\", &n, &q);\r\n    memset(c, 0, sizeof(c));\r\n    int last(0);\r\n    for (int i = 1; i <= n; i++) {\r\n        int temp;\r\n        scanf(\"%d\", &temp);\r\n        update(i, temp - last, 0);\r\n        update(i, i * (temp - last), 1);\r\n        last = temp;\r\n    }\r\n    char o;\r\n    int a, b, c;\r\n    while (q--) {\r\n        getchar();\r\n        scanf(\"%c\", &o);\r\n        if (o == \'Q\') {\r\n            scanf(\"%d%d\", &a, &b);\r\n            printf(\"%lli\\n\", ask(b) - ask(a - 1));\r\n        } else {\r\n            scanf(\"%d%d%d\", &a, &b, &c);\r\n            update(a, c, 0);\r\n            update(b + 1, -c, 0);\r\n            update(a, a * c, 1);\r\n            update(b + 1, -c * (b + 1), 1);\r\n        }\r\n    }\r\n    return 0;\r\n}\r\n```', 'd', '100', 0);
INSERT INTO `article` VALUES ('495628813443530752', '495292298867769344', '1', 1538208717451, '3', '2', 0, 0, 0, '2', 'd', '100', 0);
INSERT INTO `article` VALUES ('495631402566418432', '495292298867769344', '1', 1538209334747, '3', '2', 0, 0, 0, '2', 'd', '100', 0);
INSERT INTO `article` VALUES ('495632076188418048', '495292298867769344', '1', 1538209495351, '3', '2', 0, 0, 0, '2', 'd', '101', 0);
INSERT INTO `article` VALUES ('495636754963890176', '495292298867769344', '1', 1538210610857, '3', '2', 0, 0, 0, '2', 'd', '101', 0);
INSERT INTO `article` VALUES ('495636932529750016', '495292298867769344', '1', 1538210653191, '3', '2', 0, 0, 0, '2', 'd', '101', 0);
INSERT INTO `article` VALUES ('495637766067978240', '495292298867769344', '1', 1538210851922, '3', '2', 0, 0, 0, '2', 'd', '101', 0);
INSERT INTO `article` VALUES ('495638209397522432', '495292298867769344', '1', 1538210957621, '3', '2', 0, 0, 0, '2', 'd', '100', 0);

-- ----------------------------
-- Table structure for article_collection
-- ----------------------------
DROP TABLE IF EXISTS `article_collection`;
CREATE TABLE `article_collection`  (
  `id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '索引ID',
  `article_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章id',
  `user_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_collect_article1_idx`(`article_id`) USING BTREE,
  INDEX `fk_userid`(`user_id`) USING BTREE,
  CONSTRAINT `fk_article` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_userid` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for article_label
-- ----------------------------
DROP TABLE IF EXISTS `article_label`;
CREATE TABLE `article_label`  (
  `label_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签ID',
  `label_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名',
  `quantity` int(11) NULL DEFAULT NULL COMMENT '该标签下文章的数量',
  `link` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签图标',
  `collections` int(11) NULL DEFAULT NULL COMMENT '有多少个用户选择了该标签',
  `introduce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签介绍',
  PRIMARY KEY (`label_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_label
-- ----------------------------
INSERT INTO `article_label` VALUES ('1', '前端', 0, '1', 1, '1');
INSERT INTO `article_label` VALUES ('2', '操作系统', 0, '#icon-os', 1, '1');
INSERT INTO `article_label` VALUES ('3', 'Android', 0, '1', 1, '1');
INSERT INTO `article_label` VALUES ('4', '运维', 0, '1', 1, '1');

-- ----------------------------
-- Table structure for attention
-- ----------------------------
DROP TABLE IF EXISTS `attention`;
CREATE TABLE `attention`  (
  `attention_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '关注表的编号',
  `user_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户',
  `target_user` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标用户',
  `status_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态信息:\n\n当目标对象为关注者，标示为1；\n\n当目标对象为被关注者，标示为2；\n\n当双方互相关注，标示为3；\n\n也就是说，当status为1时user为被关注的，status为2时，user时关注着，status为3时，user既是关注者也是被关注者\n',
  PRIMARY KEY (`attention_id`) USING BTREE,
  INDEX `fk_attention_user1_idx`(`user_id`) USING BTREE,
  INDEX `fk_attention_user2_idx`(`target_user`) USING BTREE,
  INDEX `fk_att_status`(`status_id`) USING BTREE,
  CONSTRAINT `fk_att_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_att_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `comment_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论编号',
  `discusser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发出评论的用户名',
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '评论正文500字',
  `create_time` bigint(20) NULL DEFAULT NULL COMMENT '评论的创建时间',
  `support` int(11) NULL DEFAULT NULL COMMENT '支持数',
  `object` int(11) NULL DEFAULT NULL COMMENT '反对数',
  `target_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标对象id，目标对象可以是文章也可是教程',
  `mode` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论类型，值分为article和course',
  `level` int(10) NULL DEFAULT NULL COMMENT '楼层',
  `children` int(10) NULL DEFAULT NULL COMMENT '子评论数',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `fk_com_article`(`target_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment_vote
-- ----------------------------
DROP TABLE IF EXISTS `comment_vote`;
CREATE TABLE `comment_vote`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `target_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标评论id',
  `status_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态id',
  `comment_vote_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  INDEX `fk_vote_status`(`status_id`) USING BTREE,
  CONSTRAINT `fk_vote_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_vote_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for reply
-- ----------------------------
DROP TABLE IF EXISTS `reply`;
CREATE TABLE `reply`  (
  `reply_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '	回复的编号',
  `comment_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复所依附的主评论id',
  `replier` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '发出回复的用户',
  `user_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '被回复的用户',
  `create_time` bigint(45) NULL DEFAULT NULL COMMENT '回复时间',
  `text` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回复内容500字',
  `support` int(11) NULL DEFAULT NULL COMMENT '支持数',
  `object` int(11) NULL DEFAULT NULL COMMENT '反对数',
  `target_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标id',
  `mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目标类型',
  `re_time` bigint(45) NULL DEFAULT NULL COMMENT '回复时间',
  PRIMARY KEY (`reply_id`) USING BTREE,
  INDEX `fk_reply_comment1_idx`(`comment_id`) USING BTREE,
  INDEX `fk_rep_user`(`user_id`) USING BTREE,
  CONSTRAINT `fk_comm` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`comment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role_id` int(10) NOT NULL,
  `role` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (0, 'ROLE_ANONYMITY', '匿名用户');
INSERT INTO `role` VALUES (1, 'ROLE_USER', '普通用户');
INSERT INTO `role` VALUES (2, 'ROLE_ADMIN', '管理员');
INSERT INTO `role` VALUES (3, 'ROLE_ADMINISTRATORS', '超级管理员');

-- ----------------------------
-- Table structure for status
-- ----------------------------
DROP TABLE IF EXISTS `status`;
CREATE TABLE `status`  (
  `status_id` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '状态id',
  `status` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态信息',
  `status_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`status_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of status
-- ----------------------------
INSERT INTO `status` VALUES ('0', 'object', '反对');
INSERT INTO `status` VALUES ('1', 'support', '支持');
INSERT INTO `status` VALUES ('100', 'draft', '草稿');
INSERT INTO `status` VALUES ('101', 'publish', '已发布');
INSERT INTO `status` VALUES ('102', 'checking', '审核中');
INSERT INTO `status` VALUES ('103', 'banned', '封禁');
INSERT INTO `status` VALUES ('104', 'normal', '正常');
INSERT INTO `status` VALUES ('201', 'focus', '关注');
INSERT INTO `status` VALUES ('202', 'followed', '被关注');
INSERT INTO `status` VALUES ('203', 'each', '互相关注');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `gender` int(3) NULL DEFAULT NULL COMMENT '性别\n0:男\n1:女\n2:保密',
  `email` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `bg_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主页背景图片路径',
  `introduce` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个人简介\n',
  `regist_date` bigint(20) UNSIGNED ZEROFILL NULL DEFAULT NULL COMMENT '注册日期',
  `phone` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `theme_color` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主题颜色',
  `head_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像路径',
  `attentions` int(10) NULL DEFAULT NULL COMMENT '关注数量',
  `fans` int(10) NULL DEFAULT NULL COMMENT '粉丝数量',
  `articles` int(10) NULL DEFAULT NULL COMMENT '文章数',
  `discussions` int(10) NULL DEFAULT NULL COMMENT '讨论数',
  `comments` int(10) NULL DEFAULT NULL COMMENT '评论数',
  `role_id` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色id',
  `login_date` bigint(255) NULL DEFAULT NULL COMMENT '用户登陆的时间',
  `status_id` int(5) NULL DEFAULT NULL COMMENT '状态id',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('487005383798292482', '0', 'ANONYMITY', 0, '0', '0', '0', 00000000000000000000, '0', '0', '0', 0, 0, 0, 0, 0, '0', 0, 0);
INSERT INTO `user` VALUES ('495292298867769344', '15250823423wyX', 'yaser', 0, '335767798@qq.com', '/img/Background/5552e291-ab21-4729-b8a3-54f4d3cdc80a.jpg', '北美码工，微信公众号ninechapter。互联网时代，科技界界的一切也在随着浪潮加速改变，Google的崛起，Facebook的逆袭……在这样飞速改变和发展的环境下，昔日的业界霸主，如果不谙世事，用不了多久，就会被后来者所取代。', 00000001538128486113, '17602545735', 'rgba(235, 230, 230, 0.7)', '/img/Avatar/a4bbe879-bf7b-4c22-ac6f-10f456cb539e.jpeg', 0, 0, 6, 0, 0, '1', 1539246851867, 104);
INSERT INTO `user` VALUES ('495310323302006784', '895f9385ed57c4dac97f518607fa3fad', 'Yaser1', 1, 'gylxx51w@126.com', '/img/Background/default.jpg', '这个人很懒，连介绍都没有(￢︿̫̿￢☆)', 00000001538132783483, '15161662065', 'rgba(255,255,255,1)', '/img/Avatar/a4bbe879-bf7b-4c22-ac6f-10f456cb539e.jpeg', 0, 0, 0, 0, 0, '1', 1538132783491, 104);
INSERT INTO `user` VALUES ('495312881244438528', '72ec6ef58e8a8573178df013c97cc9bf', 'wyx', 2, '1805079589@qq.com', '/img/Background/default.jpg', '这个人很懒，连介绍都没有(￢︿̫̿￢☆)', 00000001538133393353, '13915395445', 'rgba(255,255,255,1)', '/img/Avatar/31563f73-c681-4de4-a737-8361fff25bc3.jpeg', 0, 0, 0, 0, 0, '1', 1538133393357, 104);
INSERT INTO `user` VALUES ('498231514031456256', '3d525ca20430a162fba9558b6c7966c3', 'wa1n', 1, '3357677@qq.com', '/img/Background/37309caa-999d-4d8b-9228-dd1b4a1c5694.jpg', '这个人很懒，连介绍都没有(￢︿̫̿￢☆)111', 00000001538829249622, '13771373389', 'rgba(255,255,255,.9)', '/img/Avatar/e579b49e-be59-4ad7-bd5c-139902c0fa9b.jpeg', 0, 0, 0, 0, 0, '1', 1538832469468, 104);

-- ----------------------------
-- Table structure for user_label
-- ----------------------------
DROP TABLE IF EXISTS `user_label`;
CREATE TABLE `user_label`  (
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `labels` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户标签组',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_label
-- ----------------------------
INSERT INTO `user_label` VALUES ('0', '0', '12,15,44');

SET FOREIGN_KEY_CHECKS = 1;
