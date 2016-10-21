//
//  EfficientDrawingDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/20.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 软件绘图

/*
 绘图通常用在Core Animation的上下文中，指的是软件绘图（意即：不由GPU协助的绘图）。在iOS中，软件绘图通常是由Core Graphics框架完成来完成。但是，在一些必要的情况下，相比Core Animation和OpenGL，Core Graphics要慢了不少。
 
 软件绘图不仅效率低，还会消耗可观的内存。CALayer只需要很少的与自己相关的内存：只有它的寄宿图会消耗一定的内存空间。即使直接赋给contents属性一张图片，也不需要增加额外的照片存储大小。如果相同的一张图片被多个图层作为contents属性，那么他们将会共用同一块内存，而不是复制内存块。
 
 但是一旦你实现了CALayerDelegate协议中的-drawLayer:inContext:方法或者UIView中的-drawRect:方法（其实就是前者的包装方法），图层就创建了一个绘制上下文，这个上下文需要的大小的内存可从这个算式得出：图层宽图层高4字节，宽高的单位均为像素。对于一个在Retina iPad上的全屏图层来说，这个内存量就是 204815264字节，相当于12MB内存，图层每次重绘的时候都需要重新抹掉内存然后重新分配。
 
 软件绘图的代价昂贵，除非绝对必要，你应该避免重绘你的视图。提高绘制性能的秘诀就在于尽量避免去绘制。

 */
class EfficientDrawingDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    
    
}


























