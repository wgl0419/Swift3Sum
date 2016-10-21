//
//  ChalkDarwing.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/20.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 模拟粉笔在黑板上的效果

/*
 模拟粉笔最简单的方法就是用一个『线刷』图片然后将它粘贴到用户手指碰触的地方，但是这个方法用CAShapeLayer没办法实现。
 
 我们可以给每个『线刷』创建一个独立的图层，但是实现起来有很大的问题。屏幕上允许同时出现图层上限数量大约是几百，那样我们很快就会超出的。这种情况下我们没什么办法，就用Core Graphics吧（除非你想用OpenGL做一些更复杂的事情）。
 
 这个实现在模拟器上表现还不错，但是在真实设备上就没那么好了。问题在于每次手指移动的时候我们就会重绘之前的线刷，即使场景的大部分并没有改变。我们绘制地越多，就会越慢。随着时间的增加每次重绘需要更多的时间，帧数也会下降（见图13.3），如何提高性能呢？
 */
class ChalkDarwing: UIView {

    var strokes:[CGPoint] = []
    
    func addBrushStroke(atPoint point: CGPoint) {
        strokes.append(point)
        setNeedsDisplay()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startPoint = touches.first?.location(in: view)
        addBrushStroke(atPoint: startPoint!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get the current point
        let point = touches.first?.location(in: view)
        addBrushStroke(atPoint: point!)
    }

    let brushSize = CGFloat(34)
    override func draw(_ rect: CGRect) {
        //redraw strokes
        for point in strokes {
            //get brush rect
            let brushRect = CGRect(x: point.x - brushSize / 2, y: point.y - brushSize / 2, width: brushSize, height: brushSize)
            
            UIImage(named: "Chalk")?.draw(in: brushRect)
        }
    }
}

























