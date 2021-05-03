# simple_password_hidden_files_script
带密码的简单文件隐藏bat脚本, 可编译成exe文件

再也不怕学习资料被别人发现 (:

我是个小白, 对bat批处理脚本并不懂, 这些都是网上找的代码东拼西凑写出来的, 写得很乱见谅, 勉强能运行哈 

#### 最新版本[hidden2.1.1](https://github.com/HanweiWu/simple_password_hidden_files_script)
### [hidden1.0.0](https://github.com/HanweiWu/simple_password_hidden_files_script/releases/tag/hidden1.0.0)

#### 原理

脚本原理为修改文件夹的两个属性: 隐藏属性和系统文件属性, 控制面板->外观和个性化->文件资源管理选项->查看, 需要设置这两个属性为不隐藏才能显示出来

![image-20210501210728227](https://z3.ax1x.com/2021/05/02/gZglnS.png)

#### 配置说明

* **修改脚本**

自己设置两个参数:

```shell
set name=起一个固定的文件夹名称
set password=定义一个固定解锁的密码
```

这里中英文都可以直接写上去

* **编译成exe**

因为bat文件直接是可以编辑源码的, 这样设置密码谁都能看没有意义, 可以使用Bat_To_Exe_Converter.exe这个文件编译成exe, 非常方便, 图标我都给友友们准备了一个自己手写的H, 不好看也讲究昂

1. 直接运行源码里带有的Bat_To_Exe_Converter.exe, 或者百度搜索[自己下载](https://www.battoexe.com/)也可以

2. File -> Open 或者直接拖动bat脚本进来

3. 在右边的选项中勾选Icon, 填入图标的路径

4. 最后点击顶部的Convert就生成一个属于自己的exe了

   ![gZgxHg.png](https://z3.ax1x.com/2021/05/02/gZgxHg.png)



#### 使用方法

1. 首次运行脚本会在同一目录生成一个文件夹

2. 把需要隐层的文件放入文件夹后再点击脚本, 文件夹会自动隐藏

3. 需要显示文件的时候, 再点一次脚本, 输入正确密码文件夹就回来啦

   [视频演示](https://vd4.bdstatic.com/mda-me1fy7f1hhak6g0w/sc/mda-me1fy7f1hhak6g0w.mp4?v_from_s=hba_haokan_4469&auth_key=1619927658-0-0-714e64cb4c28b6e0797a091f937bb859&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=) (网址打不开需要点一下地址, 重新发送请求就可以访问了)

<video id="video" controls="" preload="none" style="margin: 0 auto; width: 600px;height:400px;">
	<source id="mp4" src="https://vd4.bdstatic.com/mda-me1fy7f1hhak6g0w/sc/mda-me1fy7f1hhak6g0w.mp4?v_from_s=hba_haokan_4469&auth_key=1619927658-0-0-714e64cb4c28b6e0797a091f937bb859&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=" type="video/mp4">
</video>

#### 注意事项

* 在操作脚本前, 必须要保证需要隐藏的文件夹及其内部的所有文件都已释放资源, 不然会操作失败而且没有提示
* 要是脚本丢失了要找回隐藏文件,  再上述原理部分设置文件夹选项就可以, 隐层后的文件名改为Locker, 或者搜索也可以搜出来的

****

