//
//  DrawingView2.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/20.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

/*
 Core Animation为这些图形类型的绘制提供了专门的类，并给他们提供硬件支持（第六章『专有图层』有详细提到）。CAShapeLayer可以绘制多边形，直线和曲线。CATextLayer可以绘制文本。CAGradientLayer用来绘制渐变。这些总体上都比Core Graphics更快，同时他们也避免了创造一个寄宿图。
 
 如果稍微将之前的代码变动一下，用CAShapeLayer替代Core Graphics，性能就会得到提高（见清单13.2）.虽然随着路径复杂性的增加，绘制性能依然会下降，但是只有当非常非常复杂的绘制时才会感到明显的帧率差异。
 */
class DrawingView2: UIView {

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }
    
    var path: UIBezierPath = {
        var path = UIBezierPath()
        return path
    }()
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        if newSuperview != nil {
            let shapLayer = layer as! CAShapeLayer
            shapLayer.strokeColor = UIColor.red.cgColor
            shapLayer.fillColor = UIColor.clear.cgColor
            shapLayer.lineJoin = kCALineJoinRound
            shapLayer.lineCap = kCALineCapRound
            shapLayer.lineWidth = 5
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startPoint = touches.first?.location(in: view)
        
        path.move(to: startPoint!)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //get the current point
        let point = touches.first?.location(in: view)
        
        //add a new line segment to our path
        path.addLine(to: point!)
        
        (layer as! CAShapeLayer).path = path.cgPath
    }

}


























