# 数据库初始化
# @author <a href="https://github.com/liyupi">程序员鱼皮</a>
# @from <a href="https://yupi.icu">编程导航知识星球</a>

-- 创建库
create database if not exists mianshitong;

-- 切换库
use mianshitong;

-- 用户表
-- 用户表
create table if not exists user
(
    id            bigint auto_increment comment 'id' primary key,
    userAccount   varchar(256)                           not null comment '账号',
    userPassword  varchar(512)                           not null comment '密码',
    unionId       varchar(256)                           null comment '微信开放平台id',
    mpOpenId      varchar(256)                           null comment '公众号openId',
    userName      varchar(256)                           null comment '用户昵称',
    userAvatar    varchar(1024)                          null comment '用户头像',
    userProfile   varchar(512)                           null comment '用户简介',
    userRole      varchar(256) default 'user'            not null comment '用户角色：user/admin/ban',
    editTime      datetime     default CURRENT_TIMESTAMP not null comment '编辑时间',
    createTime    datetime     default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime    datetime     default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    isDelete      tinyint      default 0                 not null comment '是否删除',
    vipExpireTime datetime                               null comment '会员过期时间',
    vipCode       varchar(128)                           null comment '会员兑换码',
    vipNumber     bigint                                 null comment '会员编号',
    index idx_unionId (unionId)
) comment '用户' collate = utf8mb4_unicode_ci;

-- 题库表
CREATE TABLE
    IF
    NOT EXISTS question_bank
(
    id            BIGINT auto_increment COMMENT 'id' PRIMARY KEY,
    title         VARCHAR(256)                       NULL COMMENT '标题',
    description   text                               NULL COMMENT '描述',
    picture       VARCHAR(2048)                      NULL COMMENT '图片',
    userId        BIGINT                             NOT NULL COMMENT '创建用户 id',
    editTime      datetime DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '编辑时间',
    createTime    datetime DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    updateTime    datetime DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    isDelete      TINYINT  DEFAULT 0                 NOT NULL COMMENT '是否删除',
    reviewStatus  INT      DEFAULT 0                 NOT NULL COMMENT '状态：0-待审核, 1-通过, 2-拒绝',
    reviewMessage VARCHAR(512)                       NULL COMMENT '审核信息',
    reviewerId    BIGINT                             NULL COMMENT '审核人 id',
    reviewTime    datetime                           NULL COMMENT '审核时间',
    priority      int      default 0                 not null comment '优先级',
    viewNum       int      default 0                 not null comment '浏览量',
    INDEX idx_title (title)
) COMMENT '题库' COLLATE = utf8mb4_unicode_ci;

-- 题目表
CREATE TABLE
    IF
    NOT EXISTS question
(
    id            BIGINT auto_increment COMMENT 'id' PRIMARY KEY,
    title         VARCHAR(256)                       NULL COMMENT '标题',
    content       text                               NULL COMMENT '内容',
    tags          VARCHAR(1024)                      NULL COMMENT '标签列表（json 数组）',
    answer        text                               NULL COMMENT '推荐答案',
    userId        BIGINT                             NOT NULL COMMENT '创建用户 id',
    editTime      datetime DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '编辑时间',
    createTime    datetime DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '创建时间',
    updateTime    datetime DEFAULT CURRENT_TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    isDelete      TINYINT  DEFAULT 0                 NOT NULL COMMENT '是否删除',
    reviewStatus  INT      DEFAULT 0                 NOT NULL COMMENT '状态：0-待审核, 1-通过, 2-拒绝',
    reviewMessage VARCHAR(512)                       NULL COMMENT '审核信息',
    reviewerId    BIGINT                             NULL COMMENT '审核人 id',
    reviewTime    datetime                           NULL COMMENT '审核时间',
    viewNum       INT      DEFAULT 0                 NOT NULL COMMENT '浏览量',
    thumbNum      INT      DEFAULT 0                 NOT NULL COMMENT '点赞数',
    favourNum     INT      DEFAULT 0                 NOT NULL COMMENT '收藏数',
    priority      INT      DEFAULT 0                 NOT NULL COMMENT '优先级',
    source        VARCHAR(512)                       NULL COMMENT '题目来源',
    needVip       TINYINT  DEFAULT 0                 NOT NULL COMMENT '仅会员可见（1 表示仅会员可见）',
    INDEX idx_title (title),
    INDEX idx_userId (userId)
) COMMENT '题目' COLLATE = utf8mb4_unicode_ci;

-- 题库题目表（硬删除）
create table if not exists question_bank_question
(
    id             bigint auto_increment comment 'id' primary key,
    questionBankId bigint                             not null comment '题库 id',
    questionId     bigint                             not null comment '题目 id',
    userId         bigint                             not null comment '创建用户 id',
    createTime     datetime default CURRENT_TIMESTAMP not null comment '创建时间',
    updateTime     datetime default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    questionOrder  int      default 0                 not null comment '题目顺序（题号）',
    UNIQUE (questionBankId, questionId)
) comment '题库题目' collate = utf8mb4_unicode_ci;
