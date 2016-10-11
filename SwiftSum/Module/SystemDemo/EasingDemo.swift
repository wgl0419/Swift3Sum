//
//  EasingDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/10.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class EasingDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addButtonToView(title: "改变颜色") { [weak self](_) in
            self?.changColor()
        }
        
        addButtonToView(title: "小球弹跳动画") { [weak self](_) in
            self?.ballAnimation()
        }
    }

    // MARK: - 动画速度
    
    /*
     动画实际上就是一段时间内的变化，这就暗示了变化一定是随着某个特定的速率进行。
     速率由以下公式计算而来 velocity = change / time
     
     上面的等式假设了速度在整个动画过程中都是恒定不变的（就如同第八章“显式动画”的情况），对于这种恒定速度的动画我们称之为“线性步调”，而且从技术的角度而言这也是实现动画最简单的方式，但也是完全不真实的一种效果。
     
     现实生活中的任何一个物体都会在运动中加速或者减速。那么我们如何在动画中实现这种加速度呢？
     一种方法是使用物理引擎来对运动物体的摩擦和动量来建模，然而这会使得计算过于复杂。
     我们称这种类型的方程为缓冲函数，幸运的是，Core Animation内嵌了一系列标准函数提供给我们使用。
     */

    // MARK: - CAMediaTimingFunction
    
    /*
     那么该如何使用缓冲方程式呢？
     首先需要设置CAAnimation的timingFunction属性，是CAMediaTimingFunction类的一个对象。
     如果想改变隐式动画的计时函数，同样也可以使用CATransaction的+setAnimationTimingFunction:方法。
     
     这里有一些方式来创建CAMediaTimingFunction，最简单的方式是调用+timingFunctionWithName:的构造方法。这里传入如下几个常量之一：
     
     - kCAMediaTimingFunctionLinear选项创建了一个线性的计时函数，同样也是CAAnimation的timingFunction属性为空时候的默认函数。线性步调对于那些立即加速并且保持匀速到达终点的场景会有意义（例如射出枪膛的子弹），但是默认来说它看起来很奇怪，因为对大多数的动画来说确实很少用到。
     - kCAMediaTimingFunctionEaseIn常量创建了一个慢慢加速然后突然停止的方法。对于之前提到的自由落体的例子来说很适合，或者比如对准一个目标的导弹的发射。
     - kCAMediaTimingFunctionEaseOut则恰恰相反，它以一个全速开始，然后慢慢减速停止。它有一个削弱的效果，应用的场景比如一扇门慢慢地关上，而不是砰地一声。
     - kCAMediaTimingFunctionEaseInEaseOut创建了一个慢慢加速然后再慢慢减速的过程。这是现实世界大多数物体移动的方式，也是大多数动画来说最好的选择。如果只可以用一种缓冲函数的话，那就必须是它了。那么你会疑惑为什么这不是默认的选择，实际上当使用UIView的动画方法时，他的确是默认的，但当创建CAAnimation的时候，就需要手动设置它了。
     - 最后还有一个kCAMediaTimingFunctionDefault，它和kCAMediaTimingFunctionEaseInEaseOut很类似，但是加速和减速的过程都稍微有些慢。它和kCAMediaTimingFunctionEaseInEaseOut的区别很难察觉，可能是苹果觉得它对于隐式动画来说更适合（然后对UIKit就改变了想法，而是使用kCAMediaTimingFunctionEaseInEaseOut作为默认效果），虽然它的名字说是默认的，但还是要记住当创建显式的CAAnimation它并不是默认选项（换句话说，默认的图层行为动画用kCAMediaTimingFunctionDefault作为它们的计时方法）。
     */
    
    lazy var colorLayer: CALayer = {
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.blue.cgColor
        
        self.view.layer.addSublayer(colorLayer)
        return colorLayer
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        colorLayer.position = touches.first!.location(in: view)
        CATransaction.commit()
    }
    
    // MARK: - UIView的动画缓冲
    
    /*
     UIKit的动画也同样支持这些缓冲方法的使用，尽管语法和常量有些不同，为了改变UIView动画的缓冲选项，给options参数添加如下常量之一：
     UIViewAnimationOptionCurveEaseInOut
     UIViewAnimationOptionCurveEaseIn
     UIViewAnimationOptionCurveEaseOut
     UIViewAnimationOptionCurveLinear
     */

    // MARK: - 缓冲和关键帧动画
    
    /*
     或许你会回想起第八章里面颜色切换的关键帧动画由于线性变换的原因（见清单8.5）看起来有些奇怪，使得颜色变换非常不自然。为了纠正这点，我们来用更加合适的缓冲方法，例如kCAMediaTimingFunctionEaseIn，给图层的颜色变化添加一点脉冲效果，让它更像现实中的一个彩色灯泡。
     
     我们不想给整个动画过程应用这个效果，我们希望对每个动画的过程重复这样的缓冲，于是每次颜色的变换都会有脉冲效果。
     
     CAKeyframeAnimation有一个NSArray类型的timingFunctions属性，我们可以用它来对每次动画的步骤指定不同的计时函数。但是指定函数的个数一定要等于keyframes数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
     
     在这个例子中，我们自始至终想使用同一个缓冲函数，但我们同样需要一个函数的数组来告诉动画不停地重复每个步骤，而不是在整个动画序列只做一次缓冲，我们简单地使用包含多个相同函数拷贝的数组就可以了（见清单10.3）。
     */
    func changColor() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "backgroundColor"
        animation.duration = 2
        animation.values = [
            UIColor.blue.cgColor,
            UIColor.red.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor,
        ]
        let fn = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        //指定函数的个数一定要等于keyframes数组的元素个数减一，因为它是描述每一帧之间动画速度的函数。
        animation.timingFunctions = [
            fn, fn, fn
        ]
        colorLayer.add(animation, forKey: nil)
    }
    
    // MARK: - 自定义缓冲函数
    
    /*
     在第八章中，我们给时钟项目添加了动画。看起来很赞，但是如果有合适的缓冲函数就更好了。在显示世界中，钟表指针转动的时候，通常起步很慢，然后迅速啪地一声，最后缓冲到终点。但是标准的缓冲函数在这里每一个适合它，那该如何创建一个新的呢？
     
     除了+functionWithName:之外，CAMediaTimingFunction同样有另一个构造函数，一个有四个浮点参数的+functionWithControlPoints::::（注意这里奇怪的语法，并没有包含具体每个参数的名称，这在objective-C中是合法的，但是却违反了苹果对方法命名的指导方针，而且看起来是一个奇怪的设计）。
     
     使用这个方法，我们可以创建一个自定义的缓冲函数，来匹配我们的时钟动画，为了理解如何使用这个方法，我们要了解一些CAMediaTimingFunction是如何工作的。
     
     三次贝塞尔曲线
     
     CAMediaTimingFunction函数的主要原则在于它把输入的时间转换成起点和终点之间成比例的改变。

     CAMediaTimingFunction有一个叫做-getControlPointAtIndex:values:的方法，可以用来检索曲线的点，这个方法的设计的确有点奇怪（或许也就只有苹果能回答为什么不简单返回一个CGPoint），但是使用它我们可以找到标准缓冲函数的点，然后用UIBezierPath和CAShapeLayer来把它画出来。
     
     曲线的起始和终点始终是{0, 0}和{1, 1}，于是我们只需要检索曲线的第二个和第三个点（控制点）。
     */
    
    //将kCAMediaTimingFunctionEaseOut函数的缓冲曲线画出来
    lazy var shapeLayer: CAShapeLayer = {
        //get control points
        let function = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        var controlPonit1 = CGPoint.zero
        var controlPonit2 = CGPoint.zero
//        function.getControlPoint(at: 1, values: &controlPonit1)
//        function.getControlPoint(at: 2, values: &controlPonit2)
        
        //create curve
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addCurve(to: CGPoint(x: 1, y: 1), controlPoint1: controlPonit1, controlPoint2: controlPonit2)
        
        //scale the path up to a reasonable size for display
        path.apply(CGAffineTransform(scaleX: 200, y: 200))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 4
        shapeLayer.path = path.cgPath
        self.view.layer.addSublayer(shapeLayer)
        
        //flip geometry so that 0,0 is in the bottom-left
        self.view.layer.isGeometryFlipped = true
        return shapeLayer
    }()
    
    //对于我们自定义时钟指针的缓冲函数来说，我们需要初始微弱，然后迅速上升，最后缓冲到终点的曲线，通过一些实验之后，最终结果如下：
    let customTimingFunction = CAMediaTimingFunction(controlPoints: 1, 0, 0.75, 1)
    
    // MARK: - 更加复杂的动画曲线
    
    /*
     考虑一个橡胶球掉落到坚硬的地面的场景，当开始下落的时候，它会持续加速知道落到地面，然后经过几次反弹，最后停下来。
     
     这种效果没法用一个简单的三次贝塞尔曲线表示，于是不能用CAMediaTimingFunction来完成。但如果想要实现这样的效果，可以用如下几种方法：
     
     1. 用CAKeyframeAnimation创建一个动画，然后分割成几个步骤，每个小步骤使用自己的计时函数。
     2. 使用定时器逐帧更新实现动画（见第11章，“基于定时器的动画”）。
     */
    
    // MARK: - 基于关键帧的缓冲
    
    /*
     为了使用关键帧实现反弹动画，我们需要在缓冲曲线中对每一个显著的点创建一个关键帧（在这个情况下，关键点也就是每次反弹的峰值），然后应用缓冲函数把每段曲线连接起来。同时，我们也需要通过keyTimes来指定每个关键帧的时间偏移，由于每次反弹的时间都会减少，于是关键帧并不会均匀分布。
     */
    lazy var ballView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "Ball")!
        imageView.frame = CGRect(origin: self.view.center, size: image.size)
        imageView.image = image
        self.view.addSubview(imageView)
        return imageView
    }()
    
    func ballAnimation() {
        ballView.center = CGPoint(x: 150, y: 32)
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 1
        animation.values = [
            NSValue(cgPoint: CGPoint(x: 150, y: 32)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
            NSValue(cgPoint: CGPoint(x: 150, y: 140)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
            NSValue(cgPoint: CGPoint(x: 150, y: 220)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
            NSValue(cgPoint: CGPoint(x: 150, y: 250)),
            NSValue(cgPoint: CGPoint(x: 150, y: 268)),
        ]
        animation.timingFunctions = [
             CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
              CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
              CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
              CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
              CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
              CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut),
              CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn),
        ]
        animation.keyTimes = [0.0, 0.3, 0.5, 0.7, 0.8, 0.9, 0.95, 1.0]
        ballView.layer.position =  CGPoint(x: 150, y: 268)
        ballView.layer.add(animation, forKey: nil)
    }
    
    // MARK: - 流程自动化
    
    /*
     在清单10.6中，我们把动画分割成相当大的几块，然后用Core Animation的缓冲进入和缓冲退出函数来大约形成我们想要的曲线。
     但如果我们把动画分割成更小的几部分，那么我们就可以用直线来拼接这些曲线（也就是线性缓冲）。为了实现自动化，我们需要知道如何做如下两件事情：
     
     - 自动把任意属性动画分割成多个关键帧
     - 用一个数学函数表示弹性动画，使得可以对帧做便宜

     */

}
































