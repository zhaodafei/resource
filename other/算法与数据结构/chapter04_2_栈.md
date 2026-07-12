---
title: 第4章,栈补充
date: 2026-01-31
categories: 
- 数据结构与算法
tags:
- 数据结构与算法
---
第4章,栈补充

<!-- more -->

栈内容实战补充下学习资料

### 括号匹配的代码实现

#### js 版本

```js
/**
 * 验证括号是否合法嵌套匹配
 * @param {string} s 输入的括号字符串，仅包含 ()[]{}
 * @returns {boolean} 匹配结果
 */
function isValidBrackets(s) {
  // 1. 边界处理：空字符串直接返回true（无括号需匹配），奇数长度直接返回false（无法成对）
  if (s.length === 0) return true;
  if (s.length % 2 !== 0) return false;

  // 2. 定义右括号→左括号的映射表
  const bracketMap = {
    ')': '(',
    ']': '[',
    '}': '{'
  };

  // 3. 初始化栈（用数组模拟，push入栈，pop出栈，均操作栈顶）
  const stack = [];

  // 4. 遍历字符串中的每个字符
  for (let char of s) {
    // 5. 判断当前字符是右括号还是左括号
    if (bracketMap[char]) {
      // 是右括号：取出栈顶元素进行匹配
      const topElement = stack.pop() || ''; // 栈为空时，取空字符串避免报错
      if (topElement !== bracketMap[char]) {
        return false;
      }
    } else {
      // 是左括号：直接入栈
      stack.push(char);
    }
  }

  // 6. 遍历结束后，栈为空则全部匹配成功
  return stack.length === 0;
}

// 测试用例
console.log(isValidBrackets("()")); // true
console.log(isValidBrackets("()[]{}")); // true
console.log(isValidBrackets("({)}")); // false
console.log(isValidBrackets("[{()}]")); // true
console.log(isValidBrackets("[")); // false
```

#### Java 版本

```java
import java.util.Stack;
import java.util.HashMap;
import java.util.Map;

public class Main {
    /**
     * 验证括号是否合法嵌套匹配
     * @param s 输入的括号字符串，仅包含 ()[]{}
     * @return 匹配结果
     */
    public static boolean isValidBrackets(String s) {
        // 1. 边界处理
        if (s == null || s.length() == 0) {
            return true;
        }
        if (s.length() % 2 != 0) {
            return false;
        }

        // 2. 定义括号映射表
        Map<Character, Character> bracketMap = new HashMap<>();
        bracketMap.put(')', '(');
        bracketMap.put(']', '[');
        bracketMap.put('}', '{');

        // 3. 初始化栈（使用Java自带的Stack类）
        Stack<Character> stack = new Stack<>();

        // 4. 遍历字符串
        for (int i = 0; i < s.length(); i++) {
            char currentChar = s.charAt(i);
            if (bracketMap.containsKey(currentChar)) {
                // 是右括号：获取栈顶元素（栈为空时用空字符填充）
                char topElement = stack.isEmpty() ? ' ' : stack.pop();
                if (topElement != bracketMap.get(currentChar)) {
                    return false;
                }
            } else {
                // 是左括号：入栈
                stack.push(currentChar);
            }
        }

        // 5. 栈为空则匹配成功
        return stack.isEmpty();
    }

    // 测试用例
    public static void main(String[] args) {
        System.out.println(isValidBrackets("()")); // true
        System.out.println(isValidBrackets("()[]{}")); // true
        System.out.println(isValidBrackets("({)}")); // false
        System.out.println(isValidBrackets("[{()}]")); // true
        System.out.println(isValidBrackets("[")); // false
    }
}

```

