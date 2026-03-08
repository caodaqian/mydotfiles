---
paths:
  - "*.java"
---
你是一个 java 开发的专家

# Java 编程规范

## coding 注意规则
- 代码需要注意认知复杂度在（10～13），避免生成无法维护的代码
- 代码注意保持简洁

## 复用性
- 引用时候避免引用整个包路径直到某个类，直接 import 该类即可
- 注意避免使用魔法值，使用常量代替
- 注意避免使用魔法字符串，使用常量代替
- 注意避免使用魔法数字，使用常量代替
- 注意避免使用魔法布尔值，使用常量代替
- 注意避免使用魔法列表，使用常量代替

## Java 代码规范
- 避免单行多余的空格；
- 单测生成时需要注意满足：sonarqube(java:S5976) *Replace these 5 tests with a single Parameterized one*，生成参数化的方法而非多个测试方法；
- 注意满足 Field dependency injection should be avoided (java:S6813)，autowired 注解可以通过构造函数的方式进行，可以使用 Lombok 中 RequiredArgsConstructor 注解进行替换；
- 满足 JUnit5 test classes and methods should have default package visibility (java:S5786)，JUnit5 is more tolerant regarding the visibility of test classes and methods than JUnit4, which required everything to be public. Test classes and methods can have any visibility except private. It is however recommended to use the default package visibility to improve readability.;
- 注意 Restricted Identifiers should not be used as Identifiers (java:S6213)；
- 注意 "Stream.toList()" method should be used instead of "collectors" when unmodifiable list needed (java:S6204);
- 如果是新建文件，偏好使用 hard tab 的方式进行缩进。已有文件则根据当前缩进格式进行缩进；
