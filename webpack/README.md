# webpack_learn

[老陈：https://www.bilibili.com/video/BV1gA411B7M2?from=search&seid=11762398641701819399](https://www.bilibili.com/video/BV1gA411B7M2?from=search&seid=11762398641701819399)

[尚硅谷：https://www.bilibili.com/video/BV1e7411j7T5?p=39](https://www.bilibili.com/video/BV1e7411j7T5?p=39)

[TOC]

# webpack学习-老陈

官方文档https://www.webpackjs.com/concepts/

![image-20200726231243486](https://gitee.com/mus-z/blogImage/raw/master/img/20200726231244.png)

webpack是我们必须了解的打包工具

四个**核心概念**：

- 入口(entry)
- 输出(output)
- loader
- 插件(plugins)

### 初始化

先全局安装webpack和webpack-cli

```
npm install webpack webpack-cli -g
```

进入demo01目录

然后，初始化生成package.json

```
npm init -y
```

![image-20200726215148114](https://gitee.com/mus-z/blogImage/raw/master/img/20200726215157.png)

```
 tyarn add webpack webpack-cli
```

然后安装到项目依赖

![image-20200726215456112](https://gitee.com/mus-z/blogImage/raw/master/img/20200726215457.png)

新建src/index.js的测试代码并引用data.json的数据

![image-20200726215601601](https://gitee.com/mus-z/blogImage/raw/master/img/20200726215603.png)

执行下面命令的时候路径不对劲（发现全局安装用yarn是不太行 之后改回城npm安装全局）

开发环境的打包命令

```
webpack ./src/index.js -o ./dist/bundle_dev.js --mode=development
```

![image-20200726222127128](https://gitee.com/mus-z/blogImage/raw/master/img/20200726222133.png)

生产环境的打包命令

```
webpack ./src/index.js -o ./dist/bundle_pro.js --mode=production
```

![image-20200726222432380](https://gitee.com/mus-z/blogImage/raw/master/img/20200726222433.png)

生产环境没有注释并且压缩代码了，会小很多

而且webpack默认是可以处理js和json文件的，不需要loader和plugin

### 使用webpack.config.js

新建demo02 安装webpack和webpack-cli的依赖之后

新建webpack.config.js

```js
let path=require('path')
module.exports={
    entry:"./src/index.js",//入口文件
    output:{
        filename:'bundle.js',//输出文件名
        path:path.resolve(__dirname,'dist')//输出路径，用绝对路径
    },
    mode:'development',
}
```

__dirname在node的环境下可以拿到webpack.config.js的运行目录

直接运行`webpack`

![image-20200726223530276](https://gitee.com/mus-z/blogImage/raw/master/img/20200726223532.png)

### 使用loader加载样式打包

loader可以识别css等并一起打包

新建demo03，基本上可以使用demo02的内容，在根目录下放一个index.html

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="./dist/bundle.js"></script>
    <title>demo03</title>
</head>
<body>
    
</body>
</html>
```

然后src下面搞一个index.css

```css
body{
    background-color: blanchedalmond;
}
```

在index.js中引入

```js
import './index.css'
```

因为webpack默认不支持css引入，所以要使用loader

```js
let path=require('path')
module.exports={
    entry:"./src/index.js",//入口文件
    output:{
        filename:'bundle.js',//输出文件名
        path:path.resolve(__dirname,'dist')//输出路径，用绝对路径
    },
    mode:'development',//生产模式
    module:{
        //对某种格式的文件进行转换处理
        rules:[
            {
                test:/\.css$/,//使用正则匹配
                use:[
                    //顺序从下到上
                    'style-loader',//把css-js引入到style
                    'css-loader',//把css转换成js
                ]
            }
        ]
    }
}
```

要安装两个loader依赖

![image-20200726225234286](https://gitee.com/mus-z/blogImage/raw/master/img/20200726225244.png)

之前的颜色生效了

![image-20200726225459114](https://gitee.com/mus-z/blogImage/raw/master/img/20200726225500.png)

![image-20200726225620862](https://gitee.com/mus-z/blogImage/raw/master/img/20200726225622.png)

### 使用plugin插件

先可以实现自动整合编译，需要用到的插件为`html-webpack-plugin`要安装依赖

/index.html

```js
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <script src="./dist/bundle.js"></script> -->
    <title>demo04</title>
</head>
<body>
    
</body>
</html>
```

```js
let path=require('path')
let HtmlWebpackPlugin=require('html-webpack-plugin')
module.exports={
    entry:"./src/index.js",//入口文件
    output:{
        filename:'bundle.js',//输出文件名
        path:path.resolve(__dirname,'dist')//输出路径，用绝对路径
    },
    mode:'development',//生产模式
    module:{
        //对某种格式的文件进行转换处理
        rules:[
            {
                test:/\.css$/,//使用正则匹配
                use:[
                    //顺序从下到上
                    'style-loader',//把css-js引入到style
                    'css-loader',//把css转换成js
                ]
            }
        ]
    },
    //配置插件
    plugins:[
        new HtmlWebpackPlugin({
            template:'./index.html'
        })
    ]
}
```

运行webpack之后发现dist目录下有了新的index.html

![image-20200726230832778](https://gitee.com/mus-z/blogImage/raw/master/img/20200726230842.png)

### 打包图片资源

新建demo05

![image-20200726232222377](https://gitee.com/mus-z/blogImage/raw/master/img/20200726232223.png)

在入口index.js中引入图片

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <script src="./dist/bundle.js"></script> -->
    <title>demo04</title>
</head>
<body>
    <img src="./src/webpack.png" alt="webpack">
</body>
</html>
```

这时候肯定要加关于png的依赖

需要两个loader： url-loader html-loader file-loader

```js
let path=require('path')
let HtmlWebpackPlugin=require('html-webpack-plugin')
module.exports={
    entry:"./src/index.js",//入口文件
    output:{
        filename:'bundle.js',//输出文件名
        path:path.resolve(__dirname,'dist')//输出路径，用绝对路径
    },
    mode:'development',//生产模式
    module:{
        //对某种格式的文件进行转换处理
        rules:[
            {
                test:/\.css$/,//使用正则匹配
                use:[
                    //顺序从下到上
                    'style-loader',//把css-js引入到style
                    'css-loader',//把css转换成js
                ]
            },{
                test:/\.(jpg|png|gif)$/,
                loader:'url-loader',
                options:{
                    limit:8*1024,//图片小于8kb,用base64处理，减少请求
                    esModule:false,//把url-loader的es6模块化解析取消，不加的话与html-loader冲突，src会变成object module
                    name:'[hash:10].[ext]',//取图片hash的前十位与扩展名来命名
                }
            },{
                test:/\.html$/,
                loader:'html-loader',//用来解析html
            }
        ]
    },
    //配置插件
    plugins:[
        new HtmlWebpackPlugin({
            template:'./index.html'
        })
    ]
}
```

![image-20200726233718665](https://gitee.com/mus-z/blogImage/raw/master/img/20200726233720.png)

打包结果可以看见

![image-20200726233857309](https://gitee.com/mus-z/blogImage/raw/master/img/20200726233858.png)

### 热更新

使用插件

```
tyarn add webpack-dev-server -g
```

```js
let path=require('path')
let HtmlWebpackPlugin=require('html-webpack-plugin')
module.exports={
    entry:"./src/index.js",//入口文件
    output:{
        filename:'bundle.js',//输出文件名
        path:path.resolve(__dirname,'dist'),//输出路径，用绝对路径
    },
    mode:'development',//生产模式
    module:{
        //对某种格式的文件进行转换处理
        rules:[
            {
                test:/\.css$/,//使用正则匹配
                use:[
                    //顺序从下到上
                    'style-loader',//把css-js引入到style
                    'css-loader',//把css转换成js
                ]
            },{
                test:/\.(jpg|png|gif)$/,
                loader:'url-loader',
                options:{
                    limit:8*1024,//图片小于8kb,用base64处理，减少请求
                    esModule:false,//把url-loader的es6模块化解析取消，不加的话与html-loader冲突，src会变成object module
                    name:'[hash:10].[ext]',//取图片hash的前十位与扩展名来命名
                }
            },{
                test:/\.html$/,
                loader:'html-loader',//用来解析html
            }
        ]
    },
    //配置插件
    plugins:[
        new HtmlWebpackPlugin({
            template:'./index.html'
        })
    ],
    //开发服务环境
    devServer:{
        contentBase:path.resolve(__dirname,'dist'),//开发环境路径，用绝对路径
        compress:true,//开启gzip压缩
        port:3001,//端口号
        open:true,//浏览器自动打开
    }
}
```

![image-20200726234940639](https://gitee.com/mus-z/blogImage/raw/master/img/20200726234942.png)

可以热更新了

# webpack-尚硅谷

### 概述

webpack是前端模块打包器，把资源文件打包生成对应的bundle

比如.less需要先转化成浏览器识别的css才能解析

又比如js中使用了import的语法浏览器是识别不了的

![image-20200728131231396](https://gitee.com/mus-z/blogImage/raw/master/img/20200728131234.png)

![image-20200728131610150](https://gitee.com/mus-z/blogImage/raw/master/img/20200728131611.png)

会有依赖树状结构

### 五个核心概念

entry：入口，指示打包的起点文件

output：输出，指示打包资源bundles输出路径和命名

loader：处理非js文件（webpack自身只理解js、json），相当于翻译官

plugins：功能插件，可以做到优化、压缩、定义环境变量等

mode：模式氛围development和production模式

![image-20200728132313995](https://gitee.com/mus-z/blogImage/raw/master/img/20200728132315.png)

### 看演示~

![image-20200728132927241](https://gitee.com/mus-z/blogImage/raw/master/img/20200728132928.png)

上面是没有配置webpack.config.js的时候的webpack命令 ，生产环境会压缩代码，打包后的文件是处理成浏览器能识别的情况

一个干净的`webpack.config.js`

![image-20200728134114098](https://gitee.com/mus-z/blogImage/raw/master/img/20200728134115.png)

##### 如何打包样式：

![image-20200728134441205](https://gitee.com/mus-z/blogImage/raw/master/img/20200728134442.png)

如果使用其他的比如less文件要继续配置loader

![image-20200728135332740](https://gitee.com/mus-z/blogImage/raw/master/img/20200728135333.png)

##### 如何打包html：

![image-20200728135652011](https://gitee.com/mus-z/blogImage/raw/master/img/20200728135653.png)

使用`html-webpack-plugin`默认创建一个空html，自动引入built.js

如果要有结构

![image-20200728135928046](https://gitee.com/mus-z/blogImage/raw/master/img/20200728135929.png)

##### 打包图片：

老师在less中引入了图片

![image-20200728140301681](https://gitee.com/mus-z/blogImage/raw/master/img/20200728140303.png)

打包的时候，图片会报错，所以要使用处理图片的loader

![image-20200728140930220](https://gitee.com/mus-z/blogImage/raw/master/img/20200728140931.png)

但是这种情况下处理不了html引用的img图片，所以要用到`html-loader`

但是视频中发现会和url-loader的es6模式冲突，要关闭url-loader的esModule

![image-20200728141548613](https://gitee.com/mus-z/blogImage/raw/master/img/20200728141549.png)

不过经过自己**测试**这个已经解决了，**不需要考虑这个冲突问题**，下面是我用到的版本

>   "url-loader": "^4.1.0",
>
>   "webpack": "^4.44.0",
>
>   "webpack-cli": "^3.3.12"，
>
>   "html-loader": "^1.1.0",

##### 打包其他资源： 

视频中以字体文件为例（用的阿里的图标库）

![image-20200728142520490](https://gitee.com/mus-z/blogImage/raw/master/img/20200728142521.png)

![image-20200728143052996](https://gitee.com/mus-z/blogImage/raw/master/img/20200728143055.png)

```js
    module:{
        //对某种格式的文件进行转换处理
        rules:[
            {
                test:/\.css$/,//使用正则匹配
                use:[
                    //顺序从下到上
                    'style-loader',//把css-js引入到style
                    'css-loader',//把css转换成js
                ]
            },{
                //排除css、js、html、json
                exclude:/\.(css|js|html|json)$/,
                loader:'file-loader'
            }
        ]
    },
```

![image-20200728145938208](https://gitee.com/mus-z/blogImage/raw/master/img/20200728145940.png)

这样子大概是可以用的（不过特殊的需要处理的比如less、图片之类的在静态模板中是没有引用，可能还是要加loader，另外资源使用相对路径好像是不可以的，如果是import就可以）

##### 热加载devServer

修改代码需要重新打包，这时候就需要devserver了，保证我们一些小的修改不需要重新打包

可以自动编译、自动打开浏览器、自动刷新项目

临时的打包文件是保存在内存中，不会更新到我们的文件夹

启动命令是

```
webpack-dev-server
```

需要全局安装

### 开发环境搭建

```js
// 开发环境配置

const path =require('path')
const HtmlWebpackPlugin=require('html-webpack-plugin')
module.exports={
    entry:'./src/index.js',
    output:{
        filename:'built.js',
        path:path.resolve(__dirname,'build')
    },
    module:{
        rules:[
            {
                test:/\.less$/,
                use:['style-loader','css-loader','less-loader']
            },
            {
                test:/\.css$/,
                use:['style-loader','css-loader']
            },
            {
                test:/\.(png|jpg|gif)$/,
                loader:'url-loader',
                options:{
                    limit:8*1024,
                    name:'[hash:10].[ext]'
                }
            },
            {
                test:/\.html$/,
                loader:'html-loader',
            },
            {
                exclude:/\.(js|css|less|html|json|png|jpg|gif)$/,
                loader:'file-loader',
                options:{
                    limit:8*1024,
                    name:'[hash:10].[ext]'
                }
            }
        ]
    },
    plugins:[
        new HtmlWebpackPlugin({
            template:'./src/index.html'
        })
    ],
    mode:'development',
    devServer:{
        open:true,
        compress:true,
        port:3001,
        contentBase:path.resolve(__dirname,'build')
    }
    
}
```

![image-20200728153037534](https://gitee.com/mus-z/blogImage/raw/master/img/20200728153040.png)

讲道理我用了css、less、png、以及其他文件 确实是没问题的

src路径的话我就不动了，视频里面老师带着整理了下，其实就是相对路径转化的问题

![image-20200728153614853](https://gitee.com/mus-z/blogImage/raw/master/img/20200728153616.png)

后面主要是一个output路径的配置，像这样子就比较神奇了

![image-20200728154053590](https://gitee.com/mus-z/blogImage/raw/master/img/20200728154054.png)

能够制定output下的子目录

```js
// 开发环境配置

const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
module.exports = {
  entry: "./src/index.js",
  output: {
    filename: "built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      {
        test: /\.less$/,
        use: ["style-loader", "css-loader", "less-loader"],
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"],
      },
      {
        test: /\.(png|jpg|gif)$/,
        loader: "url-loader",
        options: {
          limit: 8 * 1024,
          name: "[hash:10].[ext]",
          outputPath: "imgs",
        },
      },
      {
        test: /\.html$/,
        loader: "html-loader",
      },
      {
        exclude: /\.(js|css|less|html|json|png|jpg|gif)$/,
        loader: "file-loader",
        options: {
          limit: 8 * 1024,
          name: "[hash:10].[ext]",
          outputPath: "default",
        },
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html",
    }),
  ],
  mode: "development",
  devServer: {
    open: true,
    compress: true,
    port: 3001,
    contentBase: path.resolve(__dirname, "build"),
  },
};

```

### 生产环境的痛点

生产中痛点：css从js中提取、代码压缩、兼容性问题

##### css

![image-20200728154732760](https://gitee.com/mus-z/blogImage/raw/master/img/20200728154735.png)

之前也说过css是被js引入才导入的，这样会导致js很大，想要拆出来

需要使用插件`mini-css-extract-plugin`

```js
// 开发环境配置

const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
module.exports = {
  entry: "./src/js/index.js",
  output: {
    filename: "js/built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      {
        test: /\.less$/,
        use: [
          // "style-loader",
          MiniCssExtractPlugin.loader,//代替style-loader不使用标签插入
          "css-loader",
          "less-loader",
        ],
      },
      {
        test: /\.css$/,
        use: [
          // "style-loader",
          MiniCssExtractPlugin.loader,
          "css-loader",
        ],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html",
    }),
    new MiniCssExtractPlugin(),
  ],
  mode: "development",
  devServer: {
    open: true,
    compress: true,
    port: 3001,
    contentBase: path.resolve(__dirname, "build"),
  },
};

```

![image-20200728160116599](https://gitee.com/mus-z/blogImage/raw/master/img/20200728160118.png)

之前定义的css文件被整合到main.css了

还可以通过传参的方式制定output的目录和文件名

```js
    new MiniCssExtractPlugin({
      filename:'css/built.css'
    }),
```

然后考虑css的兼容处理，一个loader一个插件

css兼容性处理：postcss-loader postcss-preset-env

还要配置browserslist，设置环境

```js
// 生产环境配置
// process.env.NODE_ENV='development';//设置node为开发环境
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");//单独提取css的插件
module.exports = {
  entry: "./src/js/index.js",
  output: {
    filename: "js/built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      {
        test: /\.less$/,
        use: [
          // "style-loader",
          MiniCssExtractPlugin.loader,//代替style-loader不使用标签插入
          "css-loader",
          "less-loader",
        ],
      },
      {
        test: /\.css$/,
        use: [
          // "style-loader",//代替style-loader不使用标签插入
          MiniCssExtractPlugin.loader,
          //css兼容性处理：postcss-loader postcss-preset-env
          "css-loader",
          // 'postcss-loader',//不能使用默认配置,帮postcss找到package.json中的browserslist（自己配置）
          // 而且browserslist默认是开发环境，要设置node环境变量，process.env.NODE_ENV='development'
          // "browserslist":{
          //   "development":[
          //     "last 1 chrome version",
          //     "last 1 firefox version",
          //     "last 1 safari version"
          //   ],
          //   "production":[
          //     ">0.01%",
          //     "not dead",
          //     "not op_mini all"
          //   ]
          // }
          {
            loader:'postcss-loader',
            options:{
              ident:'postcss',
              plugins:()=>[
                require("postcss-preset-env")()
              ]
            }
          }
        ],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html",
    }),
    new MiniCssExtractPlugin({
      filename:'css/built.css'
    }),
  ],
  mode: "development",
  devServer: {
    open: true,
    compress: true,
    port: 3001,
    contentBase: path.resolve(__dirname, "build"),
  },
};

```

package.json加上

```json
  "browserslist":{
    "development":[
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ],
    "production":[
      ">0.01%",
      "not dead",
      "not op_mini all"
    ]
  }
```

![image-20200728162832437](https://gitee.com/mus-z/blogImage/raw/master/img/20200728162833.png)

能够看见兼容效果啦

至于压缩css也需要使用一个插件`optimize-css-assets-webpack-plugin`

安装好直接调用就行了

```js
// 生产环境配置
// process.env.NODE_ENV='development';//设置node为开发环境
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");//单独提取css的插件
const OptimizeCssAssetsWebpackPlugin = require('optimize-css-assets-webpack-plugin');//压缩css文件
module.exports = {
  entry: "./src/js/index.js",
  output: {
    filename: "js/built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      {
        test: /\.less$/,
        use: [
          // "style-loader",
          MiniCssExtractPlugin.loader,//代替style-loader不使用标签插入
          "css-loader",
          "less-loader",
        ],
      },
      {
        test: /\.css$/,
        use: [
          // "style-loader",//代替style-loader不使用标签插入
          MiniCssExtractPlugin.loader,
          //css兼容性处理：postcss-loader postcss-preset-env
          "css-loader",
          // 'postcss-loader',//不能使用默认配置,帮postcss找到package.json中的browserslist（自己配置）
          {
            loader:'postcss-loader',
            options:{
              ident:'postcss',
              plugins:()=>[
                require("postcss-preset-env")()
              ]
            }
          }
        ],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html",
    }),
    new MiniCssExtractPlugin({
      filename:'css/built.css'
    }),
    new OptimizeCssAssetsWebpackPlugin(),
  ],
  mode: "development",
  devServer: {
    open: true,
    compress: true,
    port: 3001,
    contentBase: path.resolve(__dirname, "build"),
  },
};

```

##### js

下面学一下eslint语法检查

语法检查：对js进行规范，检查语法错误，eslint-loader eslint

设置检查规则 package.json中的eslintConfig中设置（airbnb）eslint-config-airbnb(-base)

不带base的有react相关eslint

```
tyarn add eslint-loader eslint eslint-plugin-import eslint-config-airbnb-base 
```

```js
const path =require('path')
const HtmlWebpackPlugin =require('html-webpack-plugin')
module.exports={
    mode:'development',
    entry:'./src/js/index.js',
    output:{
        filename:'js/built.js',
        path:path.resolve(__dirname,'build')
    },
    module:{
        rules:[
            {
                //语法检查：对js进行规范，检查语法错误，eslint-loader eslint
                //只检查源代码，不检查第三方
                //设置检查规则 package.json中的eslintConfig中设置（airbnb）
                // "eslintConfig":{
                //     "extends":"airbnb-base"
                //   }
                //eslint-config-airbnb-base->eslint eslint-plugin-import
                test:/\.js$/,
                exclude:/node_modules/,
                loader:'eslint-loader',
                options:{},
            }
        ]
    },
    plugins:[
        new HtmlWebpackPlugin({
            template:'./src/index.html'
        })
    ]
}
```

听说eslint很可怕 我看看这么几行会咋样

![image-20200728170051930](https://gitee.com/mus-z/blogImage/raw/master/img/20200728170100.png)

运行webpack，2333

![image-20200728170451426](https://gitee.com/mus-z/blogImage/raw/master/img/20200728170452.png)

```js
                options:{
                    fix:true,//自动修复
                },
```

开启自动修复，我们的src下的源代码还真的被格式化了呢

```js
function add(x, y) {
  return x + y;
}
// eslint-disable-next-line的注释会让eslint忽略其下一行的检查
// eslint-disable-next-line
console.log(add(2, 3));
```

之后关注一下js的兼容性

默认情况下，eval()中执行的字符串不会对我们的js兼容性做解释

现在比较新的浏览器还好，但是怼到ie上边就很头疼了

因此babel-loader就比较重要了，帮我们把es6转化成es5

```
 tyarn add babel-loader @babel/preset-env @babel/core
```



```
const path =require('path')
const HtmlWebpackPlugin =require('html-webpack-plugin')
module.exports={
    mode:'development',
    entry:'./src/js/index.js',
    output:{
        filename:'js/built.js',
        path:path.resolve(__dirname,'build')
    },
    module:{
        rules:[
            {
                //下载babel-loader和@babel/preset-env @babel/core
                loader:'babel-loader',
                test:/\.js$/,
                exclude:/node_modules/,
                options:{
                    //预设：指示babel做什么样的兼容性处理
                    presets:['@babel/preset-env']
                }
            }
        ]
    },
    plugins:[
        new HtmlWebpackPlugin({
            template:'./src/index.html'
        })
    ]
}
```

注：暂时只能转换基本语法，比如箭头函数是可以的，但是promise他又不认识了

因此要进行进一步兼容

使用@babel/polyfill引入所有的兼容语法

![image-20200728174227400](https://gitee.com/mus-z/blogImage/raw/master/img/20200728174231.png)

但是体积过大

所以推荐按需加载的方式core-js，删除之前引入的polyfill

```js
const path =require('path')
const HtmlWebpackPlugin =require('html-webpack-plugin')
module.exports={
    mode:'development',
    entry:'./src/js/index.js',
    output:{
        filename:'js/built.js',
        path:path.resolve(__dirname,'build')
    },
    module:{
        rules:[
            {
                //下载babel-loader和@babel/preset-env @babel/core
                //暂时只能转换一部分简单语法
                //使用@babel/polyfill，但是特别大
                //最终选择按需加载的方式 core-js
                loader:'babel-loader',
                test:/\.js$/,
                exclude:/node_modules/,
                options:{
                    //预设：指示babel做什么样的兼容性处理
                    //presets:['@babel/preset-env']
                    presets:[
                        [
                            '@babel/preset-env',{
                                useBuiltIns:'usage',//按需加载
                                corejs:{
                                    version:3,//制定core-js版本
                                },
                                targets:{
                                    chrome:"60",
                                    firefox:'60',
                                    ie:'9',
                                    safari:'10',
                                    edge:'17',
                                }
                            }
                        ]
                    ]
                }
            }
        ]
    },
    plugins:[
        new HtmlWebpackPlugin({
            template:'./src/index.html'
        })
    ]
}
```

最终只需要babel-loader @babel/preset-env @babel/core core-js 这些

然后考虑下js和html的代码压缩

js很简单 只需要用`mode:'production'`

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
module.exports = {
  mode: "production",//生产环境自动压缩js
  entry: "./src/js/index.js",
  output: {
    filename: "js/built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      {
        
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html",
    }),
  ],
};

```

##### html

html为什么要压缩呢，反正是可以缩成一行并且去掉注释

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
module.exports = {
  mode: "production",//生产环境自动压缩js
  entry: "./src/js/index.js",
  output: {
    filename: "js/built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      {
        
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html",
      minify:{
        //移除空格
        collapseWhitespace:true,
        //移除注释
        removeComments:true,
      }
    }),
  ],
};

```

### 生产环境配置

主要就是css的提取、兼容、压缩、js的兼容、压缩、html的压缩

css依赖：postcss-loader、postcss-preset-env、less-loader、optimize-css-assets-webpack-plugin、less

js依赖：babel-loader、@babel/preset-env、@babel/core、core-js

html依赖:html-webpack-plugin、html-loader、file-loader、url-loader

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板
const MiNiCssExtractPlugin = require("mini-css-extract-plugin"); //提取出css
const OptimizeCssAssetsWebpackPlugin = require("optimize-css-assets-webpack-plugin"); //压缩css
process.env.NODE_ENV = "production";
//复用css的loader
let commonCssLoader = [
  {
      loader:MiNiCssExtractPlugin.loader,
      options:{
        publicPath:'../',//避免css中的路径引入错误
      } 
    }, //代替style标签而是引入css的形式
  "css-loader",
  {
    //把css压缩
    loader: "postcss-loader",
    options: {
      //配置package.json的"browserslist"
      ident: "postcss",
      plugins: () => [require("postcss-preset-env")()],
    },
  },
];
module.exports = {
  mode: "production", //生产模式
  entry: "./src/js/index.js",
  output: {
    filename: "built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      //css\less
      {
        test: /\.css$/,
        use: [...commonCssLoader],
      },
      {
        test: /\.less$/,
        use: [...commonCssLoader, "less-loader"],
      },
      //js先eslint再babel
      //eslint检查
      {
        //package.json配置"eslintConfig"
        test: /\.js$/,
        exclude: /node_modules/,
        enforce:'pre',//js优先执行eslint
        loader: "eslint-loader",
        options: {
          fix: true, //规范自动修复
        },
      },
      //js兼容处理
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        options: {
          presets: [
            [
              "@babel/preset-env",
              {
                useBuiltIns: "usage", //按需加载
                corejs: {
                  version: 3, //制定core-js版本
                },
                targets: {//制定兼容的目标
                  chrome: "60",
                  firefox: "60",
                  ie: "9",
                  safari: "10",
                  edge: "17",
                },
              },
            ],
          ],
        },
      },
      {
          test:/\.(jpg|png|gif)$/,
          loader:'url-loader',
          options:{
              limit:8*1024,
              name:'[hash:10].[ext]',
              outputPath:'imgs',
              esMoudle:false,
          }
      },
      {
          test:/\.html$/,
          loader:'html-loader',
      },
      {
          exclude:/\.(js|html|css|less|json|jpg|png|gif)$/,
          loader:'file-loader',
          options:{
              outputPath:'media'
          }
      }
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
      minify:{//压缩html
          collapseInlineTagWhitespace:true,
          removeComments:true,
      }
    }),
    new MiNiCssExtractPlugin({
      filename: "css/built.css", //设置css的输出
    }),
    new OptimizeCssAssetsWebpackPlugin(), //压缩css的插件
  ],
};

```

package.json中

```json
"browserslist": {
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ],
    "production": [
      ">0.01%",
      "not dead",
      "not op_mini all"
    ]
  },
  "eslintConfig": {
    "extends": "airbnb-base"
  }
```

### webpack优化配置

性能优化：开发环境性能优化、生产环境性能优化

#### 开发环境性能优化：

##### 优化打包构建速度-HRM

因为修改部分文件的时候其他文件也会重新打包，肯定会影响打包速度因此就需要

**HRM热模块替换**：只会打包某一个模块而不是所有都重新打包

- 样式文件在使用style-loader的情况下可以使用HRM

- js文件默认不使用HRM，需要自动刷新：需要修改js文件实现热加载

- html不能随之热加载，也不会自动刷新（修改entry入口，改成数组引入html），spa不做HRM

![image-20200728220047053](https://gitee.com/mus-z/blogImage/raw/master/img/20200728220048.png)

```js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin'); // html模板
const MiNiCssExtractPlugin = require('mini-css-extract-plugin'); // 提取出css
const OptimizeCssAssetsWebpackPlugin = require('optimize-css-assets-webpack-plugin');
// 压缩css
process.env.NODE_ENV = 'development';
const webpack = require('webpack');
// 复用css的loader
const commonCssLoader = [
  // {
  //   loader:MiNiCssExtractPlugin.loader,
  //   options:{
  //     publicPath:'../',//避免css中的路径引入错误
  //   }
  // }, //代替style标签而是引入css的形式
  'style-loader',
  'css-loader',
  // {
  //   //把css压缩
  //   loader: "postcss-loader",
  //   options: {
  //     //配置package.json的"browserslist"
  //     ident: "postcss",
  //     plugins: () => [require("postcss-preset-env")()],
  //   },
  // },
];
module.exports = {
  mode: 'development', // 生产模式
  entry: ['./src/js/index.js', './src/index.html'],
  output: {
    filename: 'built.js',
    path: path.resolve(__dirname, 'build'),
  },
  module: {
    rules: [
      // css\less
      {
        test: /\.css$/,
        use: [...commonCssLoader],
      },
      {
        test: /\.less$/,
        use: [...commonCssLoader, 'less-loader'],
      },
      // js先eslint再babel
      // eslint检查
      // {
      //   // package.json配置"eslintConfig"
      //   test: /\.js$/,
      //   exclude: /node_modules/,
      //   enforce: 'pre', // js优先执行eslint
      //   loader: 'eslint-loader',
      //   options: {
      //     fix: true, // 规范自动修复
      //   },
      // },
      // js兼容处理
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: [
            [
              '@babel/preset-env',
              {
                useBuiltIns: 'usage', // 按需加载
                corejs: {
                  version: 3, // 制定core-js版本
                },
                targets: {
                  // 制定兼容的目标
                  chrome: '60',
                  firefox: '60',
                  ie: '9',
                  safari: '10',
                  edge: '17',
                },
              },
            ],
          ],
        },
      },
      {
        test: /\.(jpg|png|gif)$/,
        loader: 'url-loader',
        options: {
          limit: 8 * 1024,
          name: '[hash:10].[ext]',
          outputPath: 'imgs',
          esMoudle: false,
        },
      },
      {
        test: /\.html$/,
        loader: 'html-loader',
      },
      {
        exclude: /\.(js|html|css|less|json|jpg|png|gif)$/,
        loader: 'file-loader',
        options: {
          outputPath: 'media',
        },
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html', // 引用html模板
      // minify:{//压缩html
      //     collapseInlineTagWhitespace:true,
      //     removeComments:true,
      // }
    }),
    new MiNiCssExtractPlugin({
      filename: 'css/built.css', // 设置css的输出
    }),
    // new OptimizeCssAssetsWebpackPlugin(), //压缩css的文件
    // new webpack.HotModuleReplacementPlugin(),
    // new webpack.NamedModulesPlugin(),
  ],
  devServer: {
    contentBase: path.resolve(__dirname, 'build'),
    compress: true,
    port: 3001,
    // 开启HRM热模块替换
    hot: true,
  },
};

```



```js
//index.js
//.......
//.......
if (module.hot) {
  //可以监听print.js的代码变化启动HRM，但是对入口文件index.js不能起到作用
  module.hot.accept('./print.js', () => {
    console.log('热加载print.');
    //console.log(module.hot);
    print();
  });
}

```

对于非入口js文件和css可以启动HRM了，html对于pwa单页面应用则不宜启动HRM，随之刷新就好了（index.js也是如此）

##### 优化代码**调试**-source-map

source-map是一种提供源代码到构建后代码的映射技术

如果构建后代码出错，会通过映射关系追踪源代码错误

在webpack.config.js中加入

```
devtool:'source-map',
```

重要的是source-map的构建参数

`[inlie-|hidden-|eval-][nosources-][cheap-[module-]]source-map`

前面有三个可选的参数位置

![image-20200729235626958](https://gitee.com/mus-z/blogImage/raw/master/img/20200729235627.png)

> source-map：会生成built.js.map的一个映射文件
>
> inline-source-map：内联，映射文件的代码会内嵌在构建后的built.js的末尾
>
> hidden-source-map：会生成外部的built.js.map，但是在浏览器的source中会隐藏webpack://，不隐藏构建后代码
>
> eval-source-map：也是内联的source-map，但是都会追加在built.js的每个模块引入的eval中
>
> nosources-source-map：生成在外部，但是在浏览器的source中会隐藏我们的js源代码（有路径），构建后的js代码也看不见
>
> cheap-source-map：生成在外部，和source-map类似但是错误提示到整行而不是整句，会受到babel的影响
>
> cheap-module-source-map：生成在外部，和source-map类似但是错误提示到整行而不是整句，不会收到babel的影响

内联和外部的区别：外部会多生成文件，内联的构建速度会快

1. 开了source-map之后，如果print.js出现某种错误会告诉你出错在**源代码**的哪里可以精确到文件的行和列

![image-20200729225452523](https://gitee.com/mus-z/blogImage/raw/master/img/20200729225459.png)

![image-20200729225753510](https://gitee.com/mus-z/blogImage/raw/master/img/20200729225754.png)

看视频里弹幕的老哥说不加source-map也会提示我特意关了去试试看，（好像真的一样

但是，有些情况下，点击后面的跳转是不一样的，因为这些非语法错误，而是执行错误的部分，在非source-map的情况下跳转到的是一个eval的执行内容，而使用了source-map虽然提示一样但是跳转的确实是源代码的样子

![image-20200729230345446](https://gitee.com/mus-z/blogImage/raw/master/img/20200729230346.png)

![image-20200729230520659](https://gitee.com/mus-z/blogImage/raw/master/img/20200729230522.png)

2. inline-source-map和source-map的执行效果是完全一致的只是映射的代码文件一个在.map文件中一个是内嵌在构建后的built.js中

3. hidden-source-map执行到错误后隐藏了错误源代码的位置，指挥提示原因和构建后代码的报错位置，相较于我们的default状态，他更不会暴露我的源代码

![image-20200729230832717](https://gitee.com/mus-z/blogImage/raw/master/img/20200729230833.png)

4. eval-source-map相较于inlinie-source-map在控制台的报错信息末尾会多出一个hash值，对于我们跳转去观察源代码没有影响，跳转之后观察下图中的路径

![image-20200729231050784](https://gitee.com/mus-z/blogImage/raw/master/img/20200729231051.png)

![image-20200729231249658](https://gitee.com/mus-z/blogImage/raw/master/img/20200729231250.png)

5. 使用nosources-source-map，会在控制台提示报错的位置和原因，但是不暴露位置sources中的webpack://下的任何代码（即我们的源代码），和hidden-source-map模式不同的是hidden模式压根就不会出现webpack://的source路径和任何js文件代码，但是nosources-source-map只是引用不到源代码的内容，路径是构建好的

![image-20200729230345446](https://gitee.com/mus-z/blogImage/raw/master/img/20200729230346.png)

![image-20200729231516410](https://gitee.com/mus-z/blogImage/raw/master/img/20200729231517.png)

6. cheap-source-map和正常的source-map相比只能精确到行，而正常的可以精确到列（不包括hidden和nosources的模式），cheap-source-map在使用babel-loader时会自动转译（转译后的源代码会独立格式化分行

![image-20200729232742361](https://gitee.com/mus-z/blogImage/raw/master/img/20200729233733.png)

![image-20200729232750992](https://gitee.com/mus-z/blogImage/raw/master/img/20200729232752.png)

7. cheap-module-source-map也一样不会精确到列，好像是一样的，但是这个不会被babel-loader影响，而cheap-source-map在使用babel-loader时会自动转译（转译后的源代码会独立格式化分行)，因为module模式会把loader的sourcemap也加进来。

![image-20200729233141301](https://gitee.com/mus-z/blogImage/raw/master/img/20200729233142.png)

8. 根据环境适配

**开发环境**：速度快，调试友好

（eval>inline>cheap>...）

> 速度快排序：
>
> eval-cheap-source-map
>
> eval-source-map

> 调试友好排序：
>
> source-map
>
> cheap-module-source-map
>
> cheap-source-map

综合一下，折中推荐eval-source-map，想要更快加cheap，想要更友好加cheap-module

即eval-source-map或eval-cheap-module-source-map，前者更友好，后者更快

老师提到脚手架默认使用的是eval-source-map的方式来追溯错误源代码的

**生产环境**：源代码隐藏？调试友好？

内联会让代码体积变大，所以不使用内联，即排除inline和eval的模式

> 源代码隐藏：
>
> nosources-source-map 源代码和构建后js代码全部隐藏
>
> hidden-source-map 只隐藏源代码，会提示构建后代码错误的错误位置

> 调试友好：
>
> source-map
>
> cheap-module-source-map

生产环境推荐source-map，如果你想隐藏代码可以考虑加上隐藏的模式

![image-20200729235502692](https://gitee.com/mus-z/blogImage/raw/master/img/20200729235503.png)

![image-20200729235528191](https://gitee.com/mus-z/blogImage/raw/master/img/20200729235529.png)

```js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin'); // html模板
const MiNiCssExtractPlugin = require('mini-css-extract-plugin'); // 提取出css
const OptimizeCssAssetsWebpackPlugin = require('optimize-css-assets-webpack-plugin');
// 压缩css
process.env.NODE_ENV = 'development';
const webpack = require('webpack');
// 复用css的loader
const commonCssLoader = [
  // {
  //   loader:MiNiCssExtractPlugin.loader,
  //   options:{
  //     publicPath:'../',//避免css中的路径引入错误
  //   }
  // }, //代替style标签而是引入css的形式
  'style-loader',
  'css-loader',
  // {
  //   //把css压缩
  //   loader: "postcss-loader",
  //   options: {
  //     //配置package.json的"browserslist"
  //     ident: "postcss",
  //     plugins: () => [require("postcss-preset-env")()],
  //   },
  // },
];
module.exports = {
  mode: 'development', // 生产模式
  entry: ['./src/js/index.js', './src/index.html'],
  output: {
    filename: 'built.js',
    path: path.resolve(__dirname, 'build'),
  },
  module: {
    rules: [
      // css\less
      {
        test: /\.css$/,
        use: [...commonCssLoader],
      },
      {
        test: /\.less$/,
        use: [...commonCssLoader, 'less-loader'],
      },
      // js先eslint再babel
      // eslint检查
      // {
      //   // package.json配置"eslintConfig"
      //   test: /\.js$/,
      //   exclude: /node_modules/,
      //   enforce: 'pre', // js优先执行eslint
      //   loader: 'eslint-loader',
      //   options: {
      //     fix: true, // 规范自动修复
      //   },
      // },
      // // js兼容处理
      // {
      //   test: /\.js$/,
      //   exclude: /node_modules/,
      //   loader: 'babel-loader',
      //   options: {
      //     presets: [
      //       [
      //         '@babel/preset-env',
      //         {
      //           useBuiltIns: 'usage', // 按需加载
      //           corejs: {
      //             version: 3, // 制定core-js版本
      //           },
      //           targets: {
      //             // 制定兼容的目标
      //             chrome: '60',
      //             firefox: '60',
      //             ie: '9',
      //             safari: '10',
      //             edge: '17',
      //           },
      //         },
      //       ],
      //     ],
      //   },
      // },
      {
        test: /\.(jpg|png|gif)$/,
        loader: 'url-loader',
        options: {
          limit: 8 * 1024,
          name: '[hash:10].[ext]',
          outputPath: 'imgs',
          esMoudle: false,
        },
      },
      {
        test: /\.html$/,
        loader: 'html-loader',
      },
      {
        exclude: /\.(js|html|css|less|json|jpg|png|gif)$/,
        loader: 'file-loader',
        options: {
          outputPath: 'media',
        },
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: './src/index.html', // 引用html模板
      // minify:{//压缩html
      //     collapseInlineTagWhitespace:true,
      //     removeComments:true,
      // }
    }),
    // new MiNiCssExtractPlugin({
    //   filename: 'css/built.css', // 设置css的输出
    // }),
    // new OptimizeCssAssetsWebpackPlugin(), //压缩css的文件
    // new webpack.HotModuleReplacementPlugin(),
    // new webpack.NamedModulesPlugin(),
  ],
  devServer: {
    open:true,
    contentBase: path.resolve(__dirname, 'build'),
    compress: true,
    port: 3001,
    // 开启HRM热模块替换
    hot: true,
  },
  devtool:'eval-source-map',
};

```



#### 生产环境性能优化

##### 优化打包构建速度-oneOf

在加载loader时候，默认每个文件都会被所有的rules检查，但我们很多文件都只需要一条rules就可以解析完成，这无疑减慢了打包效率，因此可以考虑使用rules的oneOf规则，可以保证文件从oneOf里面的规则从上到下检查，满足一个rule之后就可以不进行下面的loader（需要做好顺序，而且不能同一个文件需要两个loader规则同时处理

所以如果有两个文件都需要不同的rule处理的时候把其中一个loader提取到oneOf外面，就可以了

比如对于js文件的eslint-loader和babelloader，我们考虑把先执行的eslint-loader放到oneOf的上方就可以了。

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板
const MiNiCssExtractPlugin = require("mini-css-extract-plugin"); //提取出css
const OptimizeCssAssetsWebpackPlugin = require("optimize-css-assets-webpack-plugin"); //压缩css
process.env.NODE_ENV = "production";
//复用css的loader
let commonCssLoader = [
  {
    loader: MiNiCssExtractPlugin.loader,
    options: {
      publicPath: "../", //避免css中的路径引入错误
    },
  }, //代替style标签而是引入css的形式
  "css-loader",
  {
    //把css压缩
    loader: "postcss-loader",
    options: {
      //配置package.json的"browserslist"
      ident: "postcss",
      plugins: () => [require("postcss-preset-env")()],
    },
  },
];
module.exports = {
  mode: "production", //生产模式
  entry: "./src/js/index.js",
  output: {
    filename: "built.js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      //eslint检查
      {
        //package.json配置"eslintConfig"
        test: /\.js$/,
        exclude: /node_modules/,
        enforce: "pre", //js优先执行eslint
        loader: "eslint-loader",
        options: {
          fix: true, //规范自动修复
        },
      },
      {
        oneOf: [
          //css\less
          {
            test: /\.css$/,
            use: [...commonCssLoader],
          },
          {
            test: /\.less$/,
            use: [...commonCssLoader, "less-loader"],
          },
          //js先eslint再babel
          //js兼容处理
          {
            test: /\.js$/,
            exclude: /node_modules/,
            loader: "babel-loader",
            options: {
              presets: [
                [
                  "@babel/preset-env",
                  {
                    useBuiltIns: "usage", //按需加载
                    corejs: {
                      version: 3, //制定core-js版本
                    },
                    targets: {
                      //制定兼容的目标
                      chrome: "60",
                      firefox: "60",
                      ie: "9",
                      safari: "10",
                      edge: "17",
                    },
                  },
                ],
              ],
            },
          },
          {
            test: /\.(jpg|png|gif)$/,
            loader: "url-loader",
            options: {
              limit: 8 * 1024,
              name: "[hash:10].[ext]",
              outputPath: "imgs",
              esMoudle: false,
            },
          },
          {
            test: /\.html$/,
            loader: "html-loader",
          },
          {
            exclude: /\.(js|html|css|less|json|jpg|png|gif)$/,
            loader: "file-loader",
            options: {
              outputPath: "media",
            },
          },
        ],
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
      minify: {
        //压缩html
        collapseInlineTagWhitespace: true,
        removeComments: true,
      },
    }),
    new MiNiCssExtractPlugin({
      filename: "css/built.css", //设置css的输出
    }),
    new OptimizeCssAssetsWebpackPlugin(), //压缩css的插件
  ],
};

```

##### 优化代码运行的**性能-**缓存

![image-20200730175726742](https://gitee.com/mus-z/blogImage/raw/master/img/20200730175727.png)

**对babel缓存、对资源缓存**

对于js代码的编译处理，我们每次构建之后，只想变动我们修改的文件模块，这时候不能依赖于HMR的dev-server，所以要对babel进行缓存操作

只需要在babel-loader中的options中开启`cacheDirectory:true`

![image-20200730170608585](https://gitee.com/mus-z/blogImage/raw/master/img/20200730170618.png)

想要看出区别要在根目录下新家server.js配置服务器代码

```js
const express = require("express");
const app = express();
app.use(express.static("build", { maxAge: 1000 * 3600 }));
app.listen(3001);
//启动服务器 nodemon server.js
//或 node server.js
```

由于nodemon需要全局安装一下，就没有使用

任何把服务端跑起来之后

![image-20200730172808878](https://gitee.com/mus-z/blogImage/raw/master/img/20200730172815.png)

发现第一次执行webpack和我修改之后没有发生变化（证明是被缓存了

![image-20200730172944142](https://gitee.com/mus-z/blogImage/raw/master/img/20200730172945.png)

原因是开启了强制缓存，cache-contral，我们设置了会缓存1小时

![image-20200730173110448](https://gitee.com/mus-z/blogImage/raw/master/img/20200730173111.png)

所以考虑给打包的资源加hash值

![image-20200730173359505](https://gitee.com/mus-z/blogImage/raw/master/img/20200730173400.png)

![image-20200730173420847](https://gitee.com/mus-z/blogImage/raw/master/img/20200730173421.png)

之后重新打包一次

发现浏览器的引入network中js和css是有hash值后缀的

![image-20200730173529621](https://gitee.com/mus-z/blogImage/raw/master/img/20200730173530.png)

我尝试改一下js代码重新打包都重新生成了新的hash值后缀的静态文件

![image-20200730173632378](https://gitee.com/mus-z/blogImage/raw/master/img/20200730173633.png)

但是这个还是有问题，因为这个hash是根据webpack打包来的，如果这样的话，我们无论是修改css还是js都会刷新缓存状态，他们公用了一个hash值

![image-20200730174442185](https://gitee.com/mus-z/blogImage/raw/master/img/20200730174443.png)

因此要引入chunkhash和contenthash

chunkhash: 根据chunk生成的hash值. 如果打包来源同一个chunk, 那么hash值就一样

contenthash: 根据文件的内容生成hash值, 不同文件hash值一定不一样

很明显contenthash可以解决我们的需求，chunkhash是因为我们的css是由index.js引入的所以同属一个chunk

使用contenthash可以保证只要文件没有修改，都会是同一个hash值不会额外引入

第一次构建

![image-20200730182052065](https://gitee.com/mus-z/blogImage/raw/master/img/20200730182054.png)

稍微修改一下css之后再构建一次，貌似是可以了

![image-20200730182016672](https://gitee.com/mus-z/blogImage/raw/master/img/20200730182018.png)

试一下只改js，只有js重新构建了

![image-20200730182155869](https://gitee.com/mus-z/blogImage/raw/master/img/20200730182156.png)

##### Tree shaking 树摇（去除没有使用的代码

基本上生产环境下使用es6模块引用会自动使用

Tree shaking是为了去除无用的js或者css代码，减少代码体积

js：必须使用es6模块化，使用production环境

![image-20200730182703865](https://gitee.com/mus-z/blogImage/raw/master/img/20200730182704.png)

在index.js中只引入部分

![image-20200730182729581](https://gitee.com/mus-z/blogImage/raw/master/img/20200730182731.png)

打包后可以发现构建后的代码中没有我们写的减法minus

如果在package.json中配置了

```json
"sideEffects":false
```

表示构建所有代码都使用树摇，则css或者其他文件会被默认摇掉

这样就可以了：

```json
"sideEffects":["*.css","*.less"]
```

当然，我试过了，这句话不加我的css是不会被摇掉的，所以还是不取消副作用了，生产模式会默认

"sideEffects"为true

##### 代码分割-code split

针对js把入口chunk分割成多个chunk文件，以减小体积，实现代码分割

step1：实现entry多入口

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板


module.exports = {
  mode: "production", //生产模式
  // entry: "./src/js/index.js",//单入口
  entry:{
    //多入口，每个入口一个bundle
    main:'./src/js/index.js',
    test:'./src/js/test.js'
  },
  output: {
    filename: "js/[name].[contenthash:10].js",
    path: path.resolve(__dirname, "build"),
  },
  
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
      minify:{//压缩html
          collapseInlineTagWhitespace:true,
          removeComments:true,
      }
    }),
  ],
  devtool:'source-map',
};

```

![image-20200730185120148](https://gitee.com/mus-z/blogImage/raw/master/img/20200730185123.png)

这个主要是应用于多页面应用

但是这种编写方式不灵活

step2：使用splitChunks

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板


module.exports = {
  mode: "production", //生产模式
  entry: "./src/js/index.js",//单入口
  output: {
    filename: "js/[name].[contenthash:10].js",
    path: path.resolve(__dirname, "build"),
  },
  
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
      minify:{//压缩html
          collapseInlineTagWhitespace:true,
          removeComments:true,
      }
    }),
  ],
  optimization:{
    //可以将node_modules中的模块单独打包成一个chunk
    splitChunks:{
      chunks:'all'
    }
  },
  devtool:'source-map',
};

```

比如我在index.js中引入了jquery

打包之后

![image-20200730190056097](https://gitee.com/mus-z/blogImage/raw/master/img/20200730190057.png)

```js
  optimization:{
    //可以将node_modules中的模块单独打包成一个chunk
    splitChunks:{
      chunks:'all'
    }
  },
```

可以把第三方的内容单独打包，现在我们可以改成多入口试试

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板


module.exports = {
  mode: "production", //生产模式
  // entry: "./src/js/index.js",//单入口
  entry:{
    //多入口，每个入口一个bundle
    main:'./src/js/index.js',
    test:'./src/js/test.js'
  },
  output: {
    filename: "js/[name].[contenthash:10].js",
    path: path.resolve(__dirname, "build"),
  },
  
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
      minify:{//压缩html
          collapseInlineTagWhitespace:true,
          removeComments:true,
      }
    }),
  ],
  optimization:{
    //可以将node_modules中的模块单独打包成一个chunk
    splitChunks:{
      chunks:'all'
    }
  },
  devtool:'source-map',
};

```

![image-20200730190305044](https://gitee.com/mus-z/blogImage/raw/master/img/20200730190309.png)

现在有三个chunk了，如果我们的test.js中也引入了jquery呢（公用的第三方）

就会发现出现不使用splitChunks的话两个chunk都会单独包括第三方都会很大

但是打开的话就都分开单独引用，体积就会变小

![image-20200730190607926](https://gitee.com/mus-z/blogImage/raw/master/img/20200730190609.png)

![image-20200730190800114](https://gitee.com/mus-z/blogImage/raw/master/img/20200730190801.png)

step3：主要针对单页面应用，js中import语句引入

如果在单入口的时候我引入的是自己的源代码，但是想把他单独打包

语法是使用`import('./test.js').then()`

```js
//index.js

// import { mul } from './test';
const add = (x, y) => x + y;
new Promise((resolve) => {
  console.log('promise');
  setTimeout(() => {
    console.log('timeout');
    resolve();
  }, 0);
}).then(() => {
  console.log('p_end');
});
console.log(add(2, 3));
import('./test')//返回promisr对象
  .then((res)=>{
    console.log('test加载成功',res)
    console.log(res.mul(3, 3));
  })
  .catch((e)=>{
    console.log(e)
  })

```

![image-20200730191520564](https://gitee.com/mus-z/blogImage/raw/master/img/20200730191521.png)

test.js就会被打包到1.js中

看一下输出

![image-20200730192008680](https://gitee.com/mus-z/blogImage/raw/master/img/20200730192009.png)

这时候有个问题我们想让那个命名1变友好，自定义命名为test的话，需要写注释

```js
import(/* webpackChunkName:'test' */'./test')//返回promisr对象
  .then((res)=>{
    console.log('test加载成功',res)
    console.log(res.mul(3, 3));
  })
  .catch((e)=>{
    console.log(e)
  })
```

然后就见证奇迹了~

![image-20200730192410667](https://gitee.com/mus-z/blogImage/raw/master/img/20200730192412.png)

个人感觉第二种方法即使用splitChunks加上第三种方法中偶尔引用个人源代码进行打包是比较智能的

顺便查了一下多入口应用的配置多出口和相应html

![image-20200730192956927](https://gitee.com/mus-z/blogImage/raw/master/img/20200730192958.png)

##### 懒加载layzloading和预加载

这里的webpack配置很简单，需要单入口形式的

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板


module.exports = {
  mode: "production", //生产模式
  entry: "./src/js/index.js",//单入口
  output: {
    filename: "js/[name].[contenthash:10].js",
    path: path.resolve(__dirname, "build"),
  },
  
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
      minify:{//压缩html
          collapseInlineTagWhitespace:true,
          removeComments:true,
      }
    }),
  ],
  optimization:{
    //可以将node_modules中的模块单独打包成一个chunk
    splitChunks:{
      chunks:'all'
    }
  },
  devtool:'source-map',
};

```

此懒加载是js文件的懒加载，不是图片资源的懒加载

![image-20200730193740464](https://gitee.com/mus-z/blogImage/raw/master/img/20200730193741.png)

![image-20200730193814507](https://gitee.com/mus-z/blogImage/raw/master/img/20200730193815.png)

很明显test被提前加载了

现在假如有一个需求，当我点击按钮，才想加载test.js

![image-20200730194151766](https://gitee.com/mus-z/blogImage/raw/master/img/20200730194152.png)

这时候import动态加载就来啦

![image-20200730194358678](https://gitee.com/mus-z/blogImage/raw/master/img/20200730194400.png)

初始情况为

![image-20200730194416304](https://gitee.com/mus-z/blogImage/raw/master/img/20200730194418.png)

当我点击按钮

![image-20200730194433176](https://gitee.com/mus-z/blogImage/raw/master/img/20200730194434.png)

![image-20200730194442386](https://gitee.com/mus-z/blogImage/raw/master/img/20200730194443.png)

这就实现了es6动态引入的懒加载，因为其实现了代码分割，并不需要担心会重复加载

然后，还有一个东西叫预加载webpackPrefetch

```js
console.log('index.js被加载了')
document.getElementById('btn').onclick=async function(){
  let {mul}=await import(/*webpackChunkName:'test',webpackPrefetch:true*/'./test')
  console.log(mul(4,5))
}
```

刚开始进入也是

![image-20200730194840104](https://gitee.com/mus-z/blogImage/raw/master/img/20200730194841.png)

但是再network显示责怪文件以及在初始被引入了，但是没有被调用

![image-20200730195054723](https://gitee.com/mus-z/blogImage/raw/master/img/20200730195055.png)

当我点击按钮，会追加一个很快的引入，其实是读取了之前的缓存

![image-20200730195105676](https://gitee.com/mus-z/blogImage/raw/master/img/20200730195106.png)

> 区别：
>
> 1. 预加载会在使用之前提前请求js文件，但是不会调取；懒加载是当文件被需要才会请求
>
> 2. 正常加载被认为是并行加载（同一时间加载多个文件，但是可能没人用，所以提倡懒加载）
>
> 3. 懒加载中的预加载是会等其他文件加载完毕，在浏览器空闲的时候才会进行预加载，以备打算使用该模块的人等待时间过长

##### PWA渐进式web应用

pwa模拟webapp的功能，在缓存、通知、后台功能等方面表现更好

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板
const MiNiCssExtractPlugin = require("mini-css-extract-plugin"); //提取出css
const OptimizeCssAssetsWebpackPlugin = require("optimize-css-assets-webpack-plugin"); //压缩css
const workboxWebpackPlugin=require('workbox-webpack-plugin');//使用pwa
process.env.NODE_ENV = "production";
//复用css的loader
let commonCssLoader = [
  {
      loader:MiNiCssExtractPlugin.loader,
      options:{
        publicPath:'../',//避免css中的路径引入错误
      } 
    }, //代替style标签而是引入css的形式
  "css-loader",
  {
    //把css压缩
    loader: "postcss-loader",
    options: {
      //配置package.json的"browserslist"
      ident: "postcss",
      plugins: () => [require("postcss-preset-env")()],
    },
  },
];
//pwa渐进式web应用（主要是离线可以访问
//workbox->workbox-webpack-plugin
module.exports = {
  mode: "production", //生产模式
  entry: "./src/js/index.js",
  output: {
    filename: "built.[contenthash:10].js",
    path: path.resolve(__dirname, "build"),
  },
  module: {
    rules: [
      //css\less
      {
        test: /\.css$/,
        use: [...commonCssLoader],
      },
      {
        test: /\.less$/,
        use: [...commonCssLoader, "less-loader"],
      },
      // //js先eslint再babel
      // //eslint检查
      // {
      //   //package.json配置"eslintConfig"
      //   test: /\.js$/,
      //   exclude: /node_modules/,
      //   enforce:'pre',//js优先执行eslint
      //   loader: "eslint-loader",
      //   options: {
      //     fix: true, //规范自动修复
      //   },
      // },
      //js兼容处理
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: "babel-loader",
        options: {
          presets: [
            [
              "@babel/preset-env",
              {
                useBuiltIns: "usage", //按需加载
                corejs: {
                  version: 3, //制定core-js版本
                },
                targets: {//制定兼容的目标
                  chrome: "60",
                  firefox: "60",
                  ie: "9",
                  safari: "10",
                  edge: "17",
                },
              },
            ],
          ],
          cacheDirectory:true,//开启babel缓存 
        },
      },
      {
          test:/\.(jpg|png|gif)$/,
          loader:'url-loader',
          options:{
              limit:8*1024,
              name:'[contenthash:10].[ext]',
              outputPath:'imgs',
              esMoudle:false,
          }
      },
      {
          test:/\.html$/,
          loader:'html-loader',
      },
      {
          exclude:/\.(js|html|css|less|json|jpg|png|gif)$/,
          loader:'file-loader',
          options:{
              outputPath:'media'
          }
      }
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
      minify:{//压缩html
          collapseInlineTagWhitespace:true,
          removeComments:true,
      }
    }),
    new MiNiCssExtractPlugin({
      filename: "css/built.[contenthash:10].css", //设置css的输出
    }),
    new OptimizeCssAssetsWebpackPlugin(), //压缩css的插件
    new workboxWebpackPlugin.GenerateSW({
      //帮助替换旧的serviceWorke文件，帮助快速启动
      //去入口js中做配置
      clientsClaim:true,
      skipWaiting:true,
    }),
  ],
};

```

```js
//index.js

import '../css/c.less';
import '../css/a.css';
import '../css/b.css';
import '../css/iconfont.css';
import '../css/index.css';
import { mul } from './test';

const add = (x, y) => x + y;
new Promise((resolve) => {
  console.log('promise');
  setTimeout(() => {
    console.log('timeout');
    resolve();
  }, 0);
}).then(() => {
  console.log('p_end');
});
console.log(add(2, 3));

console.log(mul(3, 3));

// 注册serverceWorker
//eslint不认识浏览器的配置，要去package修改eslintConfig的env
if ('serviceWorker' in navigator) {
  // 兼容判断
  window.addEventListener('load', () => {
    //由webpack生成
    navigator.serviceWorker.register('/service-worker.js')
      .then((res) => {
        console.log('注册service-worker成功', res);
      })
      .catch((e) => {
        console.log(e);
      });
  });
}


```

![image-20200730202817491](https://gitee.com/mus-z/blogImage/raw/master/img/20200730202822.png)

我之前是把eslint注释掉了

但是可以不注释，然后在package.json中修改eslintConfig，让eslint支持浏览器的全局变量

![image-20200730203143738](https://gitee.com/mus-z/blogImage/raw/master/img/20200730203144.png)

![image-20200730203525204](https://gitee.com/mus-z/blogImage/raw/master/img/20200730203526.png)

![image-20200730205108002](https://gitee.com/mus-z/blogImage/raw/master/img/20200730205109.png)

![image-20200730205152616](https://gitee.com/mus-z/blogImage/raw/master/img/20200730205154.png)

![image-20200730205210507](https://gitee.com/mus-z/blogImage/raw/master/img/20200730205211.png)

现在改成offline

![image-20200730205233017](https://gitee.com/mus-z/blogImage/raw/master/img/20200730205234.png)

离线环境下加载成功，size提示来自serviceWorker

![image-20200730205307489](https://gitee.com/mus-z/blogImage/raw/master/img/20200730205310.png)

##### 多进程打包

js是单进程，想通过多进程打包优化速度

下载thread-loader

一般给babel-loader用

![image-20200730214400158](https://gitee.com/mus-z/blogImage/raw/master/img/20200730214401.png)

```js
{
        test: /\.js$/,
        exclude: /node_modules/,
        use: [
          {
            //开启多进程打包
            //进程启动大概为600ms,进程通信也有开销
            //工作消耗长才需要多进程打包，在代码少的时候反而不应该使用
            loader: "thread-loader",
            options: {
              workers: 2, //进程数
            },
          },
          {
            loader: "babel-loader",
            options: {
              presets: [
                [
                  "@babel/preset-env",
                  {
                    useBuiltIns: "usage", //按需加载
                    corejs: {
                      version: 3, //制定core-js版本
                    },
                    targets: {
                      //制定兼容的目标
                      chrome: "60",
                      firefox: "60",
                      ie: "9",
                      safari: "10",
                      edge: "17",
                    },
                  },
                ],
              ],
              cacheDirectory: true, //开启babel缓存
            },
          },
        ],
      },
```

再次强调，应该适用于大项目，使用babel转化比较多的时候

##### Externals禁止一些打包

比如CDN

通过externals忽略了jquery

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板

module.exports = {
  mode: "production", //生产模式
  entry: "./src/js/index.js",
  output: {
    filename: "built.[contenthash:10].js",
    path: path.resolve(__dirname, "build"),
  },
  
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
    }),
  ],
  externals:{
    //忽略库名 -- npm包名
    jquery:'jQuery',
  }
};

```

![image-20200730220227338](https://gitee.com/mus-z/blogImage/raw/master/img/20200730220232.png)

很明显没有打包jquery，不然起码80k而不是1k左右

这时候如果想用jquery就是要依靠cdn，所以要在模板html中手动引入，之后jquery就能用了

![image-20200730221548237](https://gitee.com/mus-z/blogImage/raw/master/img/20200730221550.png)

##### DLL动态链接库

也指示哪些webpack库不参加打包，但是是从node_modules中单独取出来第三方打包

dll会单独打包成一个chunk，可以把第三方库分开打包

需要新建一个文件`webpack.dll.js`(叫啥都行)

```js
//使用dll技术对第三方库进行单独打包jquery\react\vue等
//需要运行webpack.dll.js
// webpack --config webpack.dll.js
const {resolve} =require('path')
const webpack =require('webpack')
module.exports={
    entry:{
        jquery:['jquery']
        //也可以写其他的，数组中也可以加
    },
    output:{
        filename:'[name].js',
        path:resolve(__dirname,'dll'),
        library:'[name]_[hash]',//打包的库向外暴露的内容叫什么名字
    },
    plugins:[
        //打包生成manifest.json-》提供和jquery的映射
        new webpack.DllPlugin({
            name:'[name]_[hash]',//映射库的暴露的内容名称
            path:resolve(__dirname,'dll/manifest.json')//输出的配置文件
        })
    ]
}
```

运行

```
webpack --config webpack.dll.js
```

![image-20200730223212615](https://gitee.com/mus-z/blogImage/raw/master/img/20200730223213.png)

关于jquery打包成功

然后要改一下webpack.config.js的配置

使用manifest.json告诉webpack.DllReferencePlugin配置信息

然后还要使用add-asset-html-webpack-plugin自动引入文件

```js
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin"); //html模板
const webpack = require('webpack')
const AddAssetHtmlWebpackPlugin=require('add-asset-html-webpack-plugin')
module.exports = {
  mode: "production", //生产模式
  entry: "./src/js/index.js",
  output: {
    filename: "built.[contenthash:10].js",
    path: path.resolve(__dirname, "build"),
  },
  
  plugins: [
    new HtmlWebpackPlugin({
      template: "./src/index.html", //引用html模板
    }),
    new webpack.DllReferencePlugin({
      //让manifest告诉webpack哪些库不参与打包
      manifest:path.resolve(__dirname,'dll/manifest.json')
    }),
    new AddAssetHtmlWebpackPlugin({
      //将某个文件打包输出去，并在html中自动引入
      filepath:path.resolve(__dirname,'dll/jquery.js')
    })
  ],
};


```

![image-20200730223844552](https://gitee.com/mus-z/blogImage/raw/master/img/20200730223845.png)

看起来没有打包jquery，但是浏览器也能拿到

![image-20200730224648711](https://gitee.com/mus-z/blogImage/raw/master/img/20200730224649.png)

> 1. 定义webpack.dll.js，把第三方单独打包，并配置产生manifest.json文件
> 2. 运行webpack --config webpack.dll.js 得到dll动态链接库和manifest.json文件
> 3. 在webpack.config.json中使用webpack.DllReferencePlugin插件引入manifest配置信息和第三方的不打包的信息
> 4. 在webpack.config.json中使用AddAssetHtmlWebpackPlugin插件引入dll/jquery.js，可以自动引入到html中
> 5. 只要自定义的dll不变，永远都不需要再次打包dll，直接引用即可

#### ！！！优化配置总结大纲

1. 开发环境优化

   * 优化打包构建速度
     * HRM

   * 优化代码调试
     * source-map

2. 生产环境性能优化

   * 优化打包构建速度

     * oneOf

     * 对babel缓存
     * 多进程打包
     * externals使用cdn
     * dll使用独立打包

   * 优化代码运行的性能

     * 资源缓存（contenthash）
     * tree shaking 
     * code split：分为单入口和多入口
     * js懒加载和预加载
     * PWA离线访问



### webpack详细配置

官方文档：[https://v4.webpack.docschina.org/concepts/](https://v4.webpack.docschina.org/concepts/)

#### entry

```js
const {resolve}=require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
/**
 * entry:入口起点
 * 1.string-》'./src/index.js' 单入口
 *      打包形成一个chunk，输出一个bundle文件
 *      chunk的默认名称是main
 * 2.array
 *      多入口
 *      所有入口文件最终形成一个chunk，只有一个bundle文件
 *      用于HMR功能让html热更新生效
 * 3.object
 *      多入口
 *      有几个入口文件就有几个chunk，会有多个bundle文件
 *      此时chunk的名称是key
 *      也可以给value使用数组形式，单独打包
 */

//1.string
module.exports = {
    mode:'development',
    entry:'./src/index.js',
    output:{
        filename:'[name].js',
        path:resolve(__dirname,'build')
    },
    plugins:[
        new HtmlWebpackPlugin()
    ]
};

// //2.array
// module.exports = {
//     mode:'development',
//     entry:['./src/index.js','./src/add.js'],
//     output:{
//         filename:'[name].js',
//         path:resolve(__dirname,'build')
//     },
//     plugins:[
//         new HtmlWebpackPlugin()
//     ]
// };

// //3.object
// module.exports = {
//     mode:'development',
//     entry:{
//         index:["./src/index.js","./src/count.js"],
//         add:"./src/add.js"
//     },
//     output:{
//         filename:'[name].js',
//         path:resolve(__dirname,'build')
//     },
//     plugins:[
//         new HtmlWebpackPlugin()
//     ]
// };
```

#### output

```js
const {resolve}=require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
    mode:'development',
    entry:'./src/index.js',
    output:{
        filename:'js/[name].js',//指定目录加名称
        path:resolve(__dirname,'build'),//将来所有资源输出的公共目录
        publicPath:'/',//所有引入资源公共路径前缀 ，'imgs/a.jpg'->'/imgs/a.jpg'
        chunkFilename:'js/[name]_chunk.js',//非入口chunk的名称：import动态引入或者optimazition使用splitchunk都可以
        //library一般用于dll，源代码构建不用
        library:'[name]',//把构建后的js暴露出去
        library:'window',//变量名添加到browser上，也可以使用global改用到node，或者commonjs、amd等

    },
    plugins:[
        new HtmlWebpackPlugin()
    ]
};

```

#### module

```js
const {resolve}=require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
    mode:'development',
    entry:'./src/index.js',
    output:{
        filename:'js/[name].js',
        path:resolve(__dirname,'build'),

    },
    module:{
        rules:[
            {
                test:/\.css$/,//test使用正则匹配
                //use使用多个loader
                use:['style-loader','css-loader']
            },
            {
                test:/\.js$/,
                exclude:/node_modules/,
                include:resolve(__dirname,'src'),
                enforce:'pre',//可以用post表示延后执行
                loader:'eslint-loader',
                options:{},//对应loader的配置项
            },
            {
                //oneOf中只会生效一个
                oneOf:[

                ]
            }
        ]
    },
    plugins:[
        new HtmlWebpackPlugin()
    ]
};

```

#### resolve

```js
const {resolve}=require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
    mode:'development',
    entry:'./src/js/index.js',
    output:{
        filename:'js/[name].js',//指定目录加名称
        path:resolve(__dirname,'build'),//将来所有资源输出的公共目录
    },
    plugins:[
        new HtmlWebpackPlugin()
    ],
    module:{
        rules:[
            {
                test:/\.css$/,//test使用正则匹配
                //use使用多个loader
                use:['style-loader','css-loader']
            },
        ]
    },
    resolve:{
        //解析模块的规则
        alias:{
            //配置路径别名,简写路径，但是就没有提示了
            $css:resolve(__dirname,'src/css')
        },
        //配置省略的后缀名,默认为.js
        extensions:['.js','.json','.css','.jsx'],
        //告诉webpack解析模块的目录，默认为当前目录的'node_modules'
        modules:[resolve(__dirname,'../node_modules'),'node_modules']
    }
};

```

#### devServer

```js
const {resolve}=require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
    mode:'development',
    entry:'./src/js/index.js',
    output:{
        filename:'js/[name].js',//指定目录加名称
        path:resolve(__dirname,'build'),//将来所有资源输出的公共目录
    },
    plugins:[
        new HtmlWebpackPlugin()
    ],
    module:{
        rules:[
            {
                test:/\.css$/,//test使用正则匹配
                //use使用多个loader
                use:['style-loader','css-loader']
            },
        ]
    },
    devServer:{
        contentBase:resolve(__dirname,'build'),//运行代码的目录
        watchContentBase:true,//监视contentBase目录的所有文件，如果变化就reload
        watchOptions:{
            ignored:/node_modules/,//忽略文件
        },
        compress:true,//启动gzip压缩
        port:3002,//设定端口号
        host:'localhost',//设置域名
        open:true,//自动打开浏览器
        hot:true,//开启HRM
        clintLogLevel:'none',//不打印启动服务器日志信息
        quiet:true,//除了基本的启动信息意外，其他内容都不打印
        overlay:false,//如果出错，不要全屏提示
        proxy:{
            //服务器代理，解决开发环境下的跨域问题
            'api':{
                //一旦devServer服务器3002接收到/api/xxx的请求，就会通过proxy转发到本地的服务器8080
                target:'http://localhost:8080',
                pathRewrite:{
                    '^/api':'',//发送请求时，请求路径重写，/api/xxx->/xxx
                }
            },
            //下面跨域新增代理
        }
    }
};

```

#### optimization

```js
const {resolve}=require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const TerserWebpackPlugin = require('terser-webpack-plugin')
module.exports = {
    mode:'production',
    entry:'./src/js/index.js',
    output:{
        filename:'js/[name].[contentHash:10].js',//指定目录加名称
        path:resolve(__dirname,'build'),//将来所有资源输出的公共目录
    },
    plugins:[
        new HtmlWebpackPlugin()
    ],
    module:{
        rules:[
            {
                test:/\.css$/,//test使用正则匹配
                //use使用多个loader
                use:['style-loader','css-loader']
            },
        ]
    },
    optimization:{
        splitChunks:{
            chunks:'all',
        //     //下面都是默认值，可以不写
        //     minSize:30*1024,//参与分割的chunk最小为30kb,
        //     maxSize:0,//最大没有限制
        //     minChunks:1,//要提取的chunk最少被引用1次
        //     maxAsyncRequests:5,//按需加载的时候并行加载的文件最大数量为5
        //     maxInitialRequests:3,//入口js文件最大并行请求数量
        //     automaticNameDelimiter:'~',//名称连接符
        //     name:true,//可以使用命名规则
        //     cacheGroups:{
        //         //分割chunk的组
        //         vendors:{
        //             //node_modules文件会被打包到vendors组中的chunk中-->vendors~xxx.js
        //             test:/[\\/]node_modules[\\/]/,
        //             priority:-10,//打包的优先级
        //         },
        //         default:{
        //             minChunks:2,//要提取的chunk最少被引用两次
        //             priority:-20,//打包的优先级
        //             reuseExistingChunk:true,//启动打包复用模块，再用不重新打包
        //         }
        //     }
        },
        runtimeChunk:{
            //将模块记录其他模块的hash单独打包为一个文件 runtime
            //解决修改其他文件导致入口文件中保存的hash值变化引起的入口文件缓存失效
            name:entrypoint=>`runtime-${entrypoint.name}`
        },
        minimizer:[
            //配置生产环境的压缩方案：js和css
            //4.26以上版本的webpack默认使用terser方案
            new TerserWebpackPlugin({
                //优化terser方案
                cache:true,//开启缓存
                parallel:true,//开启多进程打包
                sourceMap:true,//启动source-map
            })
        ]
    }
};

```

## webpack5

![image-20200731115951903](https://gitee.com/mus-z/blogImage/raw/master/img/20200731120002.png)

1. 精简配置
2. 通过持久缓存提高构建性能
3. 通过更好的算法和默认值来改善长期缓存
4. 通过更好的树摇和代码生成来改善捆绑包的大小
5. 清除处于怪异状态的内部结构，同时在v4中实现功能而不引入任何重大更改
6. 通过引入重大更改来为将来的功能做准备，以便我们尽可能长时间地使用v5

#### webpack4

先配置好webpack4，目前webpack默认是下载webpack4版本

```
npm init -y
tyarn add webpack webpack-cli -D
```

![image-20200731121223706](https://gitee.com/mus-z/blogImage/raw/master/img/20200731121226.png)

```js
console.log('a.js')
export const name='jack';
export const age=18;
```

```js
import * as a from './a'
console.log('b.js')
export {a};
```

```js
import * as b from './b';
console.log(b.a.name)
console.log('index.js')
```

```js
const {resolve}=require('path')
//最精简的基本仅能打包js代码的webpack4
module.exports={
    mode:'development',
    entry:'./src/index.js',
    output:{
        filename:'[name].js',
        path:resolve(__dirname,'dist'),
    },
}
```



#### webpack5

```
npm init -y
tyarn add webpack@next webpack-cli -D
```

![image-20200731122109728](https://gitee.com/mus-z/blogImage/raw/master/img/20200731122110.png)

```js
module.exports={
    mode:'development',
    //指定mode之后直接就可以测试了省略了enty和output
}
```

![image-20200731122510379](https://gitee.com/mus-z/blogImage/raw/master/img/20200731122511.png)

#### 生产模式下

![image-20200731122951600](https://gitee.com/mus-z/blogImage/raw/master/img/20200731122957.png)

![image-20200731123030646](https://gitee.com/mus-z/blogImage/raw/master/img/20200731123031.png)

webpack5小太多了

而且webpack4这种上级引入的形式没有办法使用treeshaking

而webpack5则是把所有的代码都整合到main.js中了

```js
(()=>{"use strict";console.log("a.js");console.log("b.js"),console.log("jack"),console.log("index.js")})();
//webpack5 的dist/main.js
```

#### 一些改进

[https://github.com/webpack/changelog-v5](https://github.com/webpack/changelog-v5)

![image-20200731123716759](https://gitee.com/mus-z/blogImage/raw/master/img/20200731123718.png)

![image-20200731123744674](https://gitee.com/mus-z/blogImage/raw/master/img/20200731123746.png)

![image-20200731123802449](https://gitee.com/mus-z/blogImage/raw/master/img/20200731123803.png)

![image-20200731124056624](https://gitee.com/mus-z/blogImage/raw/master/img/20200731124058.png)

![image-20200731124158257](https://gitee.com/mus-z/blogImage/raw/master/img/20200731124200.png)

![image-20200731124225218](https://gitee.com/mus-z/blogImage/raw/master/img/20200731124227.png)

![image-20200731124302827](https://gitee.com/mus-z/blogImage/raw/master/img/20200731124304.png)

![image-20200731124343634](https://gitee.com/mus-z/blogImage/raw/master/img/20200731124344.png)

