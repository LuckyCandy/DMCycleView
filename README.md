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

4. 最后
```
        self.cycleView = DMCycleView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300), DMCycleViewStyle: .center)
        self.cycleView.dataSource = self
        self.cycleView.delegate = self
        self.view.addSubview(cycleView)
        self.cycleView.start() //开始轮播  stop停止轮播
```
# Effects
带底部文字即实现了DMCycleDataSource的textForRowAt方法
![image](https://github.com/LuckyCandy/DMCycleView/blob/master/effects.png)
不带底部文字，可以控制indicator的位置:[left,center,right]
![image](https://github.com/LuckyCandy/DMCycleView/blob/master/effects1.png)
