-- 租户表
CREATE TABLE sys_tenant (
                        tenant_id bigint NOT NULL AUTO_INCREMENT COMMENT '租户ID',
                        tenant_name varchar(100) NOT NULL COMMENT '租户名称',
                        status tinyint NOT NULL DEFAULT 1 COMMENT '状态（0停用，1正常）',
                        create_time datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                        PRIMARY KEY (tenant_id),
                        UNIQUE KEY uk_tenant_name (tenant_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='租户表';
-- 部门表
CREATE TABLE sys_dept (
                      dept_id bigint NOT NULL AUTO_INCREMENT COMMENT '部门ID',
                      tenant_id bigint NOT NULL COMMENT '租户ID，关联tenant表',
                      parent_id bigint DEFAULT 0 COMMENT '父部门ID，0表示顶级部门',
                      dept_name varchar(100) NOT NULL COMMENT '部门名称',
                      order_num int DEFAULT 0 COMMENT '显示顺序',
                      status tinyint NOT NULL DEFAULT 1 COMMENT '部门状态（0停用，1正常）',
                      create_time datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                      PRIMARY KEY (dept_id),
                      KEY idx_tenant_id (tenant_id),
                      KEY idx_parent_id (parent_id),
                      CONSTRAINT fk_dept_tenant FOREIGN KEY (tenant_id) REFERENCES tenant (tenant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门表';
-- 用户表
CREATE TABLE sys_user (
                      user_id bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
                      tenant_id bigint NOT NULL COMMENT '租户ID',
                      dept_id bigint DEFAULT NULL COMMENT '所属部门ID',
                      username varchar(50) NOT NULL COMMENT '登录用户名',
                      password varchar(255) NOT NULL COMMENT '密码（加密存储）',
                      nick_name varchar(50) DEFAULT NULL COMMENT '昵称',
                      email varchar(100) DEFAULT NULL COMMENT '邮箱',
                      phone varchar(20) DEFAULT NULL COMMENT '手机号',
                      status tinyint NOT NULL DEFAULT 1 COMMENT '状态（0停用，1正常）',
                      create_time datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                      PRIMARY KEY (user_id),
                      UNIQUE KEY uk_username_tenant (tenant_id, username),
                      KEY idx_tenant_id (tenant_id),
                      CONSTRAINT fk_user_tenant FOREIGN KEY (tenant_id) REFERENCES tenant (tenant_id),
                      CONSTRAINT fk_user_dept FOREIGN KEY (dept_id) REFERENCES dept (dept_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';
-- 角色表
CREATE TABLE sys_role (
                      role_id bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
                      tenant_id bigint NOT NULL COMMENT '租户ID',
                      role_name varchar(50) NOT NULL COMMENT '角色名称',
                      role_key varchar(50) NOT NULL COMMENT '角色权限字符串',
                      status tinyint NOT NULL DEFAULT 1 COMMENT '状态（0停用，1正常）',
                      create_time datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                      PRIMARY KEY (role_id),
                      UNIQUE KEY uk_role_key_tenant (tenant_id, role_key),
                      KEY idx_tenant_id (tenant_id),
                      CONSTRAINT fk_role_tenant FOREIGN KEY (tenant_id) REFERENCES tenant (tenant_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色表';
-- 用户角色关联关系表
CREATE TABLE sys_user_role (
                           user_id bigint NOT NULL COMMENT '用户ID',
                           role_id bigint NOT NULL COMMENT '角色ID',
                           PRIMARY KEY (user_id, role_id),
                           CONSTRAINT fk_ur_user FOREIGN KEY (user_id) REFERENCES user (user_id),
                           CONSTRAINT fk_ur_role FOREIGN KEY (role_id) REFERENCES role (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户角色关联表';
-- 角色菜单关联关系表
CREATE TABLE sys_role_menu (
                           role_id bigint NOT NULL COMMENT '角色ID',
                           menu_id bigint NOT NULL COMMENT '菜单ID',
                           PRIMARY KEY (role_id, menu_id),
                           CONSTRAINT fk_rm_role FOREIGN KEY (role_id) REFERENCES role (role_id),
                           CONSTRAINT fk_rm_menu FOREIGN KEY (menu_id) REFERENCES menu (menu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色菜单关联表';
-- 菜单表
drop table if exists sys_menu;
create table sys_menu (
      menu_id           bigint(20)      not null auto_increment    comment '菜单ID',
      parent_id         bigint(20)      default 0                  comment '父菜单ID',
      menu_name         varchar(50)     not null                   comment '菜单名称',
      icon              varchar(100)    default '#'                comment '菜单图标',
      path              varchar(200)    default ''                 comment '路由地址',
      menu_type         char(1)         default ''                 comment '菜单类型（M目录 C菜单 F按钮）',
      perms             varchar(100)    default null               comment '权限标识',
      create_by         varchar(64)     default ''                 comment '创建者',
      create_time       datetime                                   comment '创建时间',
      update_by         varchar(64)     default ''                 comment '更新者',
      update_time       datetime                                   comment '更新时间',
      primary key (menu_id)
) engine=innodb CHARACTER SET = utf8 COLLATE = utf8_general_ci auto_increment=2000 comment = '菜单权限表';

INSERT INTO sys_menu VALUES('1', '0', '系统管理', 'system', '', 'M', '', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('2', '0', '系统监控', 'monitor', '', 'M', '', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('3', '0', '系统工具', 'tool', '', 'M', '', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('4', '0', '若依官网', 'guide', 'http://ruoyi.vip', 'M', '', 'admin', sysdate(), '', null);

-- 二级菜单
INSERT INTO sys_menu VALUES('100', '1', '用户管理', 'user', 'user', 'C', 'system:user:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('101', '1', '角色管理', 'peoples', 'role', 'C', 'system:role:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('102', '1', '菜单管理', 'tree-table', 'menu', 'C', 'system:menu:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('103', '1', '部门管理', 'tree', 'dept', 'C', 'system:dept:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('104', '1', '岗位管理', 'post', 'post', 'C', 'system:post:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('105', '1', '字典管理', 'dict', 'dict', 'C', 'system:dict:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('106', '1', '参数设置', 'edit', 'config', 'C', 'system:config:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('107', '1', '通知公告', 'message', 'notice', 'C', 'system:notice:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('108', '1', '日志管理', 'log', '', 'M', '', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('109', '2', '在线用户', 'online', 'online', 'C', 'monitor:online:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('110', '2', '定时任务', 'job', 'job', 'C', 'monitor:job:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('111', '2', '数据监控', 'druid', 'druid', 'C', 'monitor:druid:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('112', '2', '服务监控', 'server', 'server', 'C', 'monitor:server:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('113', '2', '缓存监控', 'redis', 'cache', 'C', 'monitor:cache:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('114', '2', '缓存列表', 'redis-list', 'cacheList', 'C', 'monitor:cache:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('115', '3', '表单构建', 'build', 'build', 'C', 'tool:build:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('116', '3', '代码生成', 'code', 'gen', 'C', 'tool:gen:list', 'admin', sysdate(), '', null);
INSERT INTO sys_menu VALUES('117', '3', '系统接口', 'swagger', 'swagger', 'C', 'tool:swagger:list', 'admin', sysdate(), '', null);


-- 备件分类表
CREATE TABLE part_category (
                               category_id INT PRIMARY KEY AUTO_INCREMENT,
                               category_code VARCHAR(30) NOT NULL COMMENT '分类编码',
                               category_name VARCHAR(50) NOT NULL COMMENT '分类名称',
                               parent_id INT DEFAULT 0 COMMENT '父分类ID',
                               level TINYINT DEFAULT 1 COMMENT '层级',
                               sort_order INT DEFAULT 0 COMMENT '排序',
                               is_active TINYINT DEFAULT 1,
                               created_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                               UNIQUE KEY uk_category_code(category_code)
) COMMENT='备件分类表';

-- 备件表
CREATE TABLE spare_parts (
                             part_id BIGINT PRIMARY KEY AUTO_INCREMENT COMMENT '备件ID',
                             part_no VARCHAR(50) NOT NULL COMMENT '备件编码',
                             part_name VARCHAR(100) NOT NULL COMMENT '备件名称',
                             category VARCHAR(50) COMMENT '分类',
                             brand VARCHAR(50) COMMENT '品牌',
                             spec VARCHAR(200) COMMENT '规格',
                             unit VARCHAR(20) DEFAULT '个' COMMENT '单位',
                             cost_price DECIMAL(10,2) COMMENT '成本价',
                             sale_price DECIMAL(10,2) COMMENT '销售价',
                             safety_stock INT DEFAULT 0 COMMENT '安全库存',
                             max_stock INT COMMENT '最大库存',
                             location VARCHAR(100) COMMENT '存放位置',
                             supplier VARCHAR(100) COMMENT '供应商',
                             is_active TINYINT DEFAULT 1 COMMENT '是否启用',
                             remarks TEXT COMMENT '备注',
                             created_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                             updated_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             UNIQUE KEY uk_part_no(part_no),
                             INDEX idx_category(category),
                             INDEX idx_supplier(supplier)
) COMMENT='备件信息表';

-- 库存表
CREATE TABLE inventory (
                           inventory_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                           part_id BIGINT NOT NULL COMMENT '备件ID',
                           warehouse VARCHAR(50) DEFAULT '主仓库' COMMENT '仓库名称',
                           total_quantity INT NOT NULL DEFAULT 0 COMMENT '总数量',
                           available_quantity INT NOT NULL DEFAULT 0 COMMENT '可用数量',
                           locked_quantity INT DEFAULT 0 COMMENT '锁定数量',
                           last_in_date DATE COMMENT '最后入库日期',
                           last_out_date DATE COMMENT '最后出库日期',
                           stock_status TINYINT DEFAULT 1 COMMENT '库存状态：1-正常 2-不足 3-超储',
                           created_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                           updated_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           UNIQUE KEY uk_part_warehouse(part_id, warehouse),
                           INDEX idx_stock_status(stock_status),
                           INDEX idx_warehouse(warehouse)
) COMMENT='库存表';

-- 入库表
CREATE TABLE stock_in (
                          in_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          in_no VARCHAR(50) NOT NULL COMMENT '入库单号',
                          part_id BIGINT NOT NULL COMMENT '备件ID',
                          warehouse VARCHAR(50) DEFAULT '主仓库' COMMENT '入库仓库',
                          in_type TINYINT NOT NULL COMMENT '入库类型：1-采购 2-退货 3-调拨 4-盘盈 5-其它',
                          quantity INT NOT NULL COMMENT '入库数量',
                          unit_price DECIMAL(10,2) COMMENT '单价',
                          total_amount DECIMAL(10,2) COMMENT '总金额',
                          supplier VARCHAR(100) COMMENT '供应商',
                          batch_no VARCHAR(50) COMMENT '批次号',
                          in_date DATE NOT NULL COMMENT '入库日期',
                          operator VARCHAR(50) NOT NULL COMMENT '操作人',
                          related_order VARCHAR(50) COMMENT '关联单号',
                          remarks TEXT COMMENT '备注',
                          created_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                          UNIQUE KEY uk_in_no(in_no),
                          INDEX idx_in_date(in_date),
                          INDEX idx_part_id(part_id),
                          INDEX idx_batch_no(batch_no)
) COMMENT='入库记录表';
-- 出库表
CREATE TABLE stock_out (
                           out_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                           out_no VARCHAR(50) NOT NULL COMMENT '出库单号',
                           part_id BIGINT NOT NULL COMMENT '备件ID',
                           warehouse VARCHAR(50) DEFAULT '主仓库' COMMENT '出库仓库',
                           out_type TINYINT NOT NULL COMMENT '出库类型：1-售后 2-内部 3-调拨 4-报废 5-盘亏',
                           quantity INT NOT NULL COMMENT '出库数量',
                           recipient VARCHAR(50) COMMENT '领用人',
                           department VARCHAR(50) COMMENT '部门',
                           service_order_no VARCHAR(50) COMMENT '售后单号',
                           out_date DATE NOT NULL COMMENT '出库日期',
                           operator VARCHAR(50) NOT NULL COMMENT '操作人',
                           reason VARCHAR(200) COMMENT '出库原因',
                           remarks TEXT COMMENT '备注',
                           created_time DATETIME DEFAULT CURRENT_TIMESTAMP,
                           UNIQUE KEY uk_out_no(out_no),
                           INDEX idx_out_date(out_date),
                           INDEX idx_part_id(part_id),
                           INDEX idx_service_order(service_order_no)
) COMMENT='出库记录表';
