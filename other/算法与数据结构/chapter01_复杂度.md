---
title: 第1章,数据结构与算法概述
date: 2023-02-09
categories: 
- 数据结构与算法
tags:
- 数据结构与算法
---
第1章,数据结构与算法概述

<!-- more -->

数据结构研究的内容数据元素？（构成）

1. 逻辑结构、
2. 存储结构、
3. 运算集合

### 四类基本数据结构

1. 集合:  数据元素都属于这个集合，但数据元素之间并没有什么关系

2. 线性结构( 分为2种 )

   > 线性结构, 元素具有一对一的关系。
   >
   > 线性结构分为 <font color="#ff6b81">顺序存储和链式存储</font>两种。
   > 顺序存储是由一段地址连续的空间来存储元素；
   > 链式存储是由分散的单元空间来存储元素，存储单元由指针相连接

   

3. 树形结构

   > 树形结构  数据元素之间存在一对多的层次关系

4. 图形结构

   > 图形结构  数据元素存在多对多的关系，每个结点的前驱和后继结点都可以是任意个

### 存储结构

1. 顺序存储结构

   > 顺序存储结构:  把逻辑上相邻的结点存储在地址***连续***的存储单元里，数据元素之间的关系由存储单元是否***相邻***来体现

2. 链式存储结构  

   > 链式存储结构:  在空间上是一些不连续的存储单元，这些存储单元的逻辑关系通过附加的***指针***字段来表示

3. 索引存储结构

   > 索引存储结构:  在存储结点信息的同时，还建立附加的索引表

4. 散列存储结构  

   > 散列存储结构:  又称为哈希（hash）存储，是一种力图将数据元素的存储位置与关键字之间建立确定对应关系的查找技术。

5. xxx

### 运算集合

loading...

### 算法介绍(Algorithm)

算法的5特性: 确定性、 有穷性、 可行性、 输出、 输入

### 算法的复杂度

时间复杂度——大O标记法

1. 用常数1取代运行中的所有加法常数。

2. 在修改后的运行次数函数中，只保留最高阶项。

3. 如果最高阶项存在，且不是1，则除去其常系数，得到的结果就是大O阶

   > ```c
   > // demo01
   > // 程序段的执行次数为1+n+1
   > // f(n) = n + 2，T(n) = O(n)
   > // 算法的时间复杂度为O(n)
   > 
   > 
   > void func()
   > {
   > 	int i, n=100,sum = 0;  	//执行一次
   > 	for (i = 0; i <= n; i++)
   > 	{
   > 		sum += i; 	//执行n次
   > 	}
   > 	printf("%d\n", sum); 	//执行一次
   > }
   > 
   > ```
   >
   > demo2
   >
   > ```c
   > //============== 
   > x=x+1 // 时间复杂度为O(1),称为常量阶
   >  
   > //==============
   > for(i=1;i<=n;i++) x=x+1;  // 时间复杂度为O(n),线性价
   > 
   > //==============
   > for(i=1;i<=n;i++)
   >     for(j=1;j<=n;j++)
   >          x=x+1;   // 时间复杂度为O(n^2),称为平方阶
   > 
   > ```

空间复杂度

loading...(研究这个意义不大)

### 底部

没有了























