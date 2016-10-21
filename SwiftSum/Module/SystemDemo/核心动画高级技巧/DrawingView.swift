//
//  DrawingView.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/20.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

// MARK: - 绘制红色线条
class DrawingView: UIView {

    
    /*
     这样实现的问题在于，我们画得越多，程序就会越慢。因为每次移动手指的时候都会重绘整个贝塞尔路径（UIBezierPath），随着路径越来越复杂，每次重绘的工作就会增加，直接导致了帧数的下降。看来我们需要一个更好的方法了。
     */
    var path: UIBezierPath = {
        var path = UIBezierPath()
        path.lineJoinStyle = .round
        path.lineCapStyle = .round
        path.lineWidth = 5
        return path
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startPoint = touches.first?.location(in: view)
        
        path.move(to: startPoint!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get the current point
        let point = touches.first?.location(in: view)
        
        //add a new line segment to our path
        path.addLine(to: point!)
        
        //redraw the view
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.clear.setFill()
        UIColor.red.setStroke()
        path.stroke()
    }
    

}
