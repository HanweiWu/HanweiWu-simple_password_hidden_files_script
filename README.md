# simple_password_hidden_files_script
带密码的简单文件隐藏bat脚本, 可编译成exe文件

再也不怕学习资料被别人发现 (:

我是个小白, 对bat批处理脚本并不懂, 这些都是网上找的代码东拼西凑写出来的, 写得很乱见谅, 勉强能运行哈 

### [hidden2.0.0](https://github.com/HanweiWu/simple_password_hidden_files_script/releases/tag/hidden2.0.0)

#### 新增部分

1. 1.0.0版本只能在同一目录下操作隐藏文件夹不太合理, 所以把隐藏的文件夹设置成了固定的绝对路径
2. 考虑到存储的资源会在多个目录下, 所以加入了通过快捷方式来隐藏文件, 也就是在隐藏的主文件夹的内部放入一个其他文件的快捷方式 (这个快捷方式需要进行处理, 就是必须是和目标文件同名, 一个空格的区别都不行!不同名的我还解决不了, 希望有大佬帮忙解决) , 运行脚本隐藏时, 也会把主文件夹内部的快捷方式对应的文件也进行隐藏, 这样就可以一起隐藏不同目录下的多个文件啦

#### 原理

脚本原理为修改文件夹的两个属性: 隐藏属性和系统文件属性, 控制面板->外观和个性化->文件资源管理选项->查看, 需要设置这两个属性为不隐藏才能显示出来

![image-20210501210728227](https://z3.ax1x.com/2021/05/02/gZglnS.png)

#### 配置说明

* **修改脚本**

自己设置三个参数:

```shell
set myDirPath=设置固定的隐藏文件所在路径(绝对路径)
set myDirName=设置固定的隐藏文件夹名称
set password=设置解锁密码
```

改进部分加入了绝对路径, 所以路径和文件名需要分开设置, 这里需要**存储在桌面**的友友们可以这么设置路径:

```powershell
set myDirPath=%USERPROFILE%\Desktop
```

* **编译成exe**

因为bat文件直接是可以编辑源码的, 这样设置密码谁都能看没有意义, 可以使用Bat_To_Exe_Converter.exe这个文件编译成exe, 非常方便, 图标我都给友友们准备了一个自己手写的H, 不好看也讲究昂

1. 在[1.0.0版本的源码](https://codeload.github.com/HanweiWu/simple_password_hidden_files_script/zip/refs/heads/hidden1.0.0)里带有的Bat_To_Exe_Converter.exe, 我也上传了[蓝奏网盘](https://wws.lanzous.com/i9OlIoq0qsj)密码:123

2. File -> Open 或者直接拖动bat脚本进来

3. 在右边的选项中勾选Icon, 填入图标的路径

4. 最后点击顶部的Convert就生成一个属于自己的exe了

   ![gZgxHg.png](https://z3.ax1x.com/2021/05/02/gZgxHg.png)



#### 使用方法

1. 首次运行脚本会在指定的目录生成一个文件夹

2. 把需要隐层的文件放入文件夹, 或者放入其他位置需要隐藏的文件的快捷方式, 特别说明**快捷方式要和源文件名称一致**才可以, 后再点击脚本, 文件夹及放入内部快捷方式所指向的文件会自动隐藏

3. 需要显示文件的时候, 再点一次脚本, 输入正确的密码, 文件夹和其他隐藏的文件就回来啦

   [视频演示](https://vd3.bdstatic.com/mda-me1g20nsbtes4kyq/sc/cae_h264/1619925913614473343/mda-me1g20nsbtes4kyq.mp4?v_from_s=gz_rmb_haokan_creator_6833&auth_key=1619931580-0-0-0f37f0e16e18f499b11cb4f803dd4c15&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=)

<video id="video" controls="" preload="none" style="margin: 0 auto; width: 600px;height:400px;">
	<source id="mp4" src="https://vd3.bdstatic.com/mda-me1g20nsbtes4kyq/sc/cae_h264/1619925913614473343/mda-me1g20nsbtes4kyq.mp4?v_from_s=gz_rmb_haokan_creator_6833&auth_key=1619931580-0-0-0f37f0e16e18f499b11cb4f803dd4c15&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=" type="video/mp4">
</video>

#### 注意事项

* 在操作脚本前, 必须要保证所有需要隐藏的文件都已释放资源, 不然会操作失败而且没有提示
* 要是脚本丢失了要找回隐藏文件,  再上述原理部分设置文件夹选项就可以, 隐层后的主文件夹名改为Locker, 通过快捷方式隐层的文件名称没有改变, 或者搜索也可以搜出来的

****

