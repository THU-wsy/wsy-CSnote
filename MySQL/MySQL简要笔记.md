# 1. 创建和管理数据库

**创建数据库**
```sql
CREATE DATABASE [IF NOT EXISTS] 数据库名 [CHARACTER SET 'utf8'];
```

**使用/切换数据库**

```sql
USE 数据库名;
```

**查看数据库的创建信息**

```sql
SHOW CREATE DATABASE 数据库名;
```

**删除数据库**

```sql
DROP DATABASE [IF EXISTS] 数据库名;
```

# 2. 创建和管理表

## 2.1 创建表

**方式1**

```sql
CREATE TABLE emp(
id INT [约束],
hobby VARCHAR(50) [约束],
[表约束条件]
);
```

**方式2**

```sql
CREATE TABLE emp1
AS
SELECT employee_id, last_name
FROM atguigudb.employees;
```

### 数据类型

- 整数：用INT，如果是非负的，后面再添加UNSIGNED
- 小数：用DECIMAL(M, D)
- 日期：用DATETIME
- 字符串：如果固定长度，用CHAR(len)；否则，用VARCHAR(len)。如果长度超过5000，则用TEXT

### 约束

- 非空约束：`NOT NULL`
- 唯一性约束：`UNIQUE`。若使用表级约束语法：`CONSTRAINT 别名 UNIQUE(字段名)`
- 主键约束：`PRIMARY KEY`。一般直接使用表级约束语法：`PRIMARY KEY(字段名)`
- 自增列：`AUTO_INCREMENT`
- 默认值约束：`DEFAULT 默认值`

## 2.2 查看表结构

```sql
DESC emp;
```

## 2.3 修改表结构

**添加一个列**

```sql
ALTER TABLE emp
ADD money INT [FIRST 或 AFTER 字段名];
```

**修改一个列**

```sql
ALTER TABLE emp
MODIFY money INT [约束] [FIRST 或 AFTER 字段名];
```

**重命名一个列**

```sql
ALTER TABLE emp
CHANGE money mon INT;
```

**删除一个列**

```sql
ALTER TABLE emp
DROP mon;
```

## 2.4 重命名表

```sql
RENAME TABLE emp
TO newemp;
```

## 2.5 删除表

```sql
DROP TABLE newemp;
```

# 3. 数据处理之增删改

## 3.1 插入数据

**方式1**

```sql
INSERT INTO emp(id, hobby)
VALUES
(1, 'cpp'),
(2, 'java');
```

**方式2**

```sql
INSERT INTO emp(id, hobby)
SELECT id2, hobby2 FROM emp2;
```

## 3.2 更新数据

```sql
UPDATE emp
SET hobby = 'python', id = 666
WHERE id = 2;
```

## 3.3 删除数据

```sql
DELETE FROM emp
WHERE id = 666;
```