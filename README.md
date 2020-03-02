# MD5DIR
这是一个命令行脚本，可以用于对文件夹路径下所有文件进行md5，形成md5目录树结构，并输出json文件。

# 如何使用？
command+B编译工程，把输出文件放到指定文件夹，cd到此文件夹下。
支持如下命令：
1. -p 源文件夹path
2. -a 是否包括所有文件（默认不加-a，跳过隐藏文件）
3. -o 输出文件

例，md5递归flutter文件夹，并输出到md5temp.json内：
> ./MD5DIR -p ./flutter -o ./md5temp.json

*注：如果不输入-o，会打印出md5的结果值。*

# 效果
```
$ ./MD5DIR -p /Users/zmz/detectioncenter/Pods/RxSwift/Platform                                         
{
  "Platform.Linux.swift" : "b414b86d34e5666ad3a51ad55bdecec3",
  "DispatchQueue+Extensions.swift" : "60ae142ff05cf38ca119832578730580",
  "DeprecationWarner.swift" : "eddd2c39ab838c9ff553cc729916edfc",
  "Platform.Darwin.swift" : "838a7a0ffb0e8a088ace8c1d54dc906d",
  "DataStructures" : {
    "Queue.swift" : "ed2296a6838eb5051e373b924dc70746",
    "Bag.swift" : "2c3ba4da7fd987d954ad8f45597566ec",
    "InfiniteSequence.swift" : "66c74ce905e98979a19f1d383cbbc486",
    "PriorityQueue.swift" : "9bf6c734e00ee459e5cc93236f6e7f9d"
  },
  "RecursiveLock.swift" : "1f628a5b0bd961680e5ba4f130b31d51"
}
```
