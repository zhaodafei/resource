<?php
//装饰器模式  ---文章编辑的难题
class article{
    protected $content;

    public function __construct($content)
    {
        $this->content = $content;
    }

    public function decorator()
    {
        return $this->content;
    }
}

$art = new article("好好学习");
echo $art->decorator();

// 文章需要 小编加摘要

class BianArticle extends article {

    public function summary()
    {
        return $this->content . '小编加了摘要';
    }
}

$art = new BianArticle('好好学习');
echo $art->summary();

// 又请了 SEO ,SEO 人员, 要对文章做 description 处理..........
class SeoArticle extends BianArticle
{
    public function seo()
    {
        //..................
    }
}

// 又有了广告部
class AdArticle extends SeoArticle
{
    // 层次越来越深............  目的只有一个,给文章加各种内容
}