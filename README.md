# DMCycleView
(Banner图无线轮播)CycleView in swift

# Usage
1. 将四个主要文件<DMCycleView、DMPageControl、DMCycleViewDataSource、DMCycleViewDelegate>和两个Dot图片<active.png和inactive.png>导入工程

2. 实现代理方法DataSource和Delegate
```
    /*DMCycleViewDataSource Impl*/
    @available(iOS 2.0,*)
    func numberOfResource()->Int{ /*返回轮播总数*/
        return 3
    }
    
    @available(iOS 2.0,*)
    func resourceForRowAt(index: Int) -> UIImageView{ /*返回轮播每个条目的资源*/
        return UIImageView(image: #imageLiteral(resourceName: "lufei"))
    }
    @Optional
    func textForRowAt(index: Int) -> String {  /*可选实现，返回底部文字的内容*/
        if index == 0{
            return "World"
        }
        return "Hello"
    }

```

3. 如果需要获取图片点击事件，可以实现DMCycleViewDelegate
```
    /*DMCycleViewDelegate Impl*/
    func tapImage(index: Int){}
```

# Effects


