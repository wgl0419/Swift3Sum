//
//  ChalkDarwing2.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/21.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 模拟粉笔在黑板上的效果 优化版

/*
 为了减少不必要的绘制，Mac OS和iOS设备将会把屏幕区分为需要重绘的区域和不需要重绘的区域。那些需要重绘的部分被称作『脏区域』。在实际应用中，鉴于非矩形区域边界裁剪和混合的复杂性，通常会区分出包含指定视图的矩形位置，而这个位置就是『脏矩形』。
 
 当一个视图被改动过了，TA可能需要重绘。但是很多情况下，只是这个视图的一部分被改变了，所以重绘整个寄宿图就太浪费了。但是Core Animation通常并不了解你的自定义绘图代码，它也不能自己计算出脏区域的位置。然而，你的确可以提供这些信息。
 
 当你检测到指定视图或图层的指定部分需要被重绘，你直接调用-setNeedsDisplayInRect:来标记它，然后将影响到的矩形作为参数传入。这样就会在一次视图刷新时调用视图的-drawRect:（或图层代理的-drawLayer:inContext:方法）。

 传入-drawLayer:inContext:的CGContext参数会自动被裁切以适应对应的矩形。为了确定矩形的尺寸大小，你可以用CGContextGetClipBoundingBox()方法来从上下文获得大小。调用-drawRect()会更简单，因为CGRect会作为参数直接传入。
 
 你应该将你的绘制工作限制在这个矩形中。任何在此区域之外的绘制都将被自动无视，但是这样CPU花在计算和抛弃上的时间就浪费了，实在是太不值得了。
 
 相比依赖于Core Graphics为你重绘，裁剪出自己的绘制区域可能会让你避免不必要的操作。那就是说，如果你的裁剪逻辑相当复杂，那还是让Core Graphics来代劳吧，记住：当你能高效完成的时候才这样做。

 */
class ChalkDarwing2: UIView {
    var strokes:[CGPoint] = []
    
    func addBrushStroke(at point: CGPoint) {
        strokes.append(point)
        /*
         它只重绘当前线刷的附近区域。另外也会刷新之前线刷的附近区域，我们也可以用CGRectIntersectsRect()来避免重绘任何旧的线刷以不至于覆盖已更新过的区域。这样做会显著地提高绘制效率
         */
        setNeedsDisplay(brushRect(for: point))
    }
    
    func brushRect(for point: CGPoint) -> CGRect {
        return CGRect(x: point.x - brushSize / 2, y: point.y - brushSize / 2, width: brushSize, height: brushSize)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startPoint = touches.first?.location(in: view)
        addBrushStroke(at: startPoint!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get the current point
        let point = touches.first?.location(in: view)
        addBrushStroke(at: point!)
    }
    
    let brushSize = CGFloat(34)
    override func draw(_ rect: CGRect) {
        //redraw strokes
        for point in strokes {
            //get brush rect
            let brushRect = self.brushRect(for: point)
            
            //only draw brush stroke if it intersects dirty rect
            if rect.intersects(brushRect) {
                UIImage(named: "Chalk")?.draw(in: brushRect)
            }
        }
    }

}
















