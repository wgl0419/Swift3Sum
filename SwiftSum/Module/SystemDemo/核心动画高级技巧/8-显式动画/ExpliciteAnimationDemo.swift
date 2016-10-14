//
//  ExpliciteAnimationDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/7.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

class ExpliciteAnimationDemo: UIViewController, CAAnimationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupColorLayer()
    }

    /*
     基础动画
     
     动画其实就是一段时间内发生的改变，最简单的形式就是从一个值改变到另一个值，这也是CABasicAnimation最主要的功能。
     
     CABasicAnimation继承于CAPropertyAnimation，作用于单一的一个属性，并添加了如下属性：
     
     id fromValue
     id toValue
     id byValue
     
     从命名就可以得到很好的解释：fromValue代表了动画开始之前属性的值，toValue代表了动画结束之后的值，byValue代表了动画执行过程中改变的值。
     
     用于CAPropertyAnimation的一些类型转换
     
     Type         	Object Type	Code Example
     CGFloat      	NSNumber   	id obj = @(float);
     CGPoint      	NSValue    	id obj = [NSValue valueWithCGPoint:point);
     CGSize       	NSValue    	id obj = [NSValue valueWithCGSize:size);
     CGRect       	NSValue    	id obj = [NSValue valueWithCGRect:rect);
     CATransform3D	NSValue    	id obj = [NSValue valueWithCATransform3D:transform);
     CGImageRef   	id         	id obj = (__bridge id)imageRef;
     CGColorRef   	id         	id obj = (__bridge id)colorRef;
     
     fromValue，toValue和byValue属性可以用很多种方式来组合，但为了防止冲突，不能一次性同时指定这三个值。
     例如，如果指定了fromValue等于2，toValue等于4，byValue等于3，那么Core Animation就不知道结果到底是4（toValue）还是5（fromValue + byValue）了。
     总的说来，就是只需要指定toValue或者byValue，剩下的值都可以通过上下文自动计算出来。
     */

    weak var colorLayer: CALayer!
    func setupColorLayer() {
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 4, y: 10, width: 80, height: 80)
        colorLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(colorLayer)
        self.colorLayer = colorLayer
        
        addButtonToView(title: "点击改变颜色") { [weak self] (_) in
            self?.changeColorAnimated()
        }
        addButtonToView(title: "点击改变颜色Before") { [weak self] (_) in
            self?.changeColorAnimatedBefore()
        }
        addButtonToView(title: "点击改变颜色After") { [weak self] (_) in
            self?.changeColorAnimationStoped()
        }
        addButtonToView(title: "关键帧动画") { [weak self] (_) in
            self?.keyframeAnimation()
        }
        addButtonToView(title: "关键帧动画BezierPath") { [weak self] (_) in
            self?.keyframeAnimationBezier()
        }
        addButtonToView(title: "虚拟属性transform.rotation旋转动画") { [weak self] (_) in
            self?.transformRotation()
        }
        addButtonToView(title: "组合动画") { [weak self] (_) in
            self?.animationGroup()
        }
        addButtonToView(title: "切换图片的过渡动画") { [weak self] (_) in
            self?.transitionAnimation()
        }
    }
    
    /*
     点击按钮，的确可以使图层动画过渡到一个新的颜色，然动画结束之后又立刻变回原始值。
     
     这是因为动画并没有改变图层的模型，而只是呈现。一旦动画结束并从图层上移除之后，图层就立刻恢复到之前定义的外观状态。我们从没改变过backgroundColor属性，所以图层就返回到原始的颜色。
     
     把动画设置成一个图层的行为（然后通过改变属性值来启动动画）是到目前为止同步属性值和动画状态最简单的方式了，
     假设由于某些原因我们不能这么做（通常因为UIView关联的图层不能这么做动画），那么有两种可以更新属性值的方式：
     在动画开始之前或者动画结束之后。
     */
    func changeColorAnimated() {
        let animation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
        animation.toValue = UIColor.random.cgColor
        
        //apply animation to layer
        colorLayer.add(animation, forKey: nil)
    }
    
    /*
     动画之前改变属性的值是最简单的办法，但这意味着我们不能使用fromValue这么好的特性了，而且要手动将fromValue设置成图层当前的值。
     这的确是可行的，但还是有些问题，
     1. 如果这里已经正在进行一段动画，我们需要从呈现图层那里去获得fromValue，而不是模型图层。
     2. 另外，由于这里的图层并不是UIView关联的图层，我们需要用CATransaction来禁用隐式动画行为，否则默认的图层行为会干扰我们的显式动画（实际上，显式动画通常会覆盖隐式动画，但在文章中并没有提到，所以为了安全最好这么做）。
     */
    func changeColorAnimatedBefore() {
        let layer = colorLayer.presentation() ?? colorLayer
        let animation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
        animation.fromValue = layer?.backgroundColor
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        colorLayer.backgroundColor = UIColor.random.cgColor
        CATransaction.commit()
        
        //apply animation to layer
        colorLayer.add(animation, forKey: nil)
    }
    
    // MARK: - 在动画结束之后，图层返回到原始值之前更新属性。
    func changeColorAnimationStoped() {
        let animation = CABasicAnimation()
        animation.keyPath = "backgroundColor"
        animation.toValue = UIColor.random.cgColor
        animation.delegate = self
        
        //CAAnimation实现了KVC（键-值-编码）协议，于是你可以用-setValue:forKey:和-valueForKey:方法来存取属性。
        animation.setValue(colorLayer, forKey: "colorLayer")
        //apply animation to layer
        colorLayer.add(animation, forKey: nil)
    }
    
    //为了知道一个显式动画在何时结束，我们需要使用一个实现了CAAnimationDelegate协议的delegate。
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let layer = anim.value(forKey: "colorLayer") as? CALayer {
            //set the backgroundColor property to match animation toValue
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            /*
             对CAAnimation而言，使用委托模式而不是一个完成块会带来一个问题，就是当你有多个动画的时候，无法在在回调方法中区分。在一个视图控制器中创建动画的时候，通常会用控制器本身作为一个委托，但是所有的动画都会调用同一个回调方法，所以你就需要判断到底是那个图层的调用。
             */
            //colorLayer.backgroundColor = (anim as! CABasicAnimation).toValue as! CGColor?
            
            //使用valueForKey
            layer.backgroundColor = (anim as! CABasicAnimation).toValue as! CGColor?
            CATransaction.commit()
        }
        /*
         不幸的是，即使做了这些，还是有个问题，在模拟器上运行的很好，但当真正跑在iOS设备上时，我们发现在-animationDidStop:finished:委托方法调用之前，指针会迅速返回到原始值，这个清单8.3图层颜色发生的情况一样。
         
         问题在于回调方法在动画完成之前已经被调用了，但不能保证这发生在属性动画返回初始状态之前。这同时也很好地说明了为什么要在真实的设备上测试动画代码，而不仅仅是模拟器。
         
         我们可以用一个fillMode属性来解决这个问题，这里知道在动画之前设置它比在动画结束之后更新属性更加方便。
         */
    }
    
    // MARK: - 关键帧动画
    /*
     和CABasicAnimation类似，CAKeyframeAnimation同样是CAPropertyAnimation的一个子类，它依然作用于单一的一个属性，但是和CABasicAnimation不一样的是，它不限制于设置一个起始和结束的值，而是可以根据一连串随意的值来做动画。
     */
    func keyframeAnimation() {
        let keyframe = CAKeyframeAnimation()
        keyframe.keyPath = "backgroundColor"
        keyframe.duration = 2
        /*
         序列中开始和结束的颜色都是蓝色，这是因为CAKeyframeAnimation并不能自动把当前值作为第一帧（就像CABasicAnimation那样把fromValue设为nil）。
         动画会在开始的时候突然跳转到第一帧的值，然后在动画结束的时候突然恢复到原始的值。
         所以为了动画的平滑特性，我们需要开始和结束的关键帧来匹配当前属性的值。
         
         运行它，你会发现动画通过颜色不断循环，但效果看起来有些奇怪。
         原因在于动画以一个恒定的步调在运行。
         当在每个动画之间过渡的时候并没有减速，这就产生了一个略微奇怪的效果，为了让动画看起来更自然，我们需要调整一下缓冲，第十章将会详细说明。
         */
        keyframe.values = [
            UIColor.blue.cgColor,
            UIColor.red.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor
        ]
        colorLayer.add(keyframe, forKey: nil)
    }
    
    /*
     CAKeyframeAnimation有另一种方式去指定动画，就是使用CGPath。path属性可以用一种直观的方式，使用Core Graphics函数定义运动序列来绘制动画。
     */
    lazy var bezierPath: UIBezierPath = {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 150))
        bezierPath.addCurve(to: CGPoint(x: 300, y: 150), controlPoint1: CGPoint(x: 75, y: 0), controlPoint2: CGPoint(x: 225, y: 300))
        
        let pathLayer = CAShapeLayer()
        pathLayer.path = bezierPath.cgPath
        pathLayer.fillColor = UIColor.clear.cgColor
        pathLayer.strokeColor = UIColor.red.cgColor
        pathLayer.lineWidth = 3
        self.pathLayer = pathLayer
        self.view.layer.addSublayer(pathLayer)
        
        return bezierPath
    }()
    
    //draw the path using a CAShapeLayer
    var pathLayer: CAShapeLayer!
    
    func keyframeAnimationBezier() {
        
        let shipLayer = CALayer()
        shipLayer.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 64, height: 64))
        shipLayer.position = CGPoint(x: 0, y: 150)
        shipLayer.contents = UIImage(named: "Ship")?.cgImage
        view.layer.addSublayer(shipLayer)
        
        //create the keyframe animation
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position"
        animation.duration = 4
        animation.path = bezierPath.cgPath
        
        /*
         运行示例，你会发现飞船的动画有些不太真实，这是因为当它运动的时候永远指向右边，而不是指向曲线切线的方向。你可以调整它的affineTransform来对运动方向做动画，但很可能和其它的动画冲突。
         
         幸运的是，苹果预见到了这点，并且给CAKeyFrameAnimation添加了一个rotationMode的属性。设置它为常量kCAAnimationRotateAuto，图层将会根据曲线的切线自动旋转。
         */
        animation.rotationMode = kCAAnimationRotateAuto
        shipLayer.add(animation, forKey: nil)
    }
    
    // MARK: - 虚拟属性
    /*
     之前提到过属性动画实际上是针对于关键路径而不是一个键，这就意味着可以对子属性甚至是虚拟属性做动画。但是虚拟属性到底是什么呢？
     为了旋转图层，我们可以对transform.rotation关键路径应用动画，而不是transform本身

     transform.rotation属性有一个奇怪的问题是它其实并不存在。这是因为CATransform3D并不是一个对象，它实际上是一个结构体，也没有符合KVC相关属性，transform.rotation实际上是一个CALayer用于处理动画变换的虚拟属性。
     你不可以直接设置transform.rotation或者transform.scale，他们不能被直接使用。当你对他们做动画时，Core Animation自动地根据通过CAValueFunction来计算的值来更新transform属性。
     */
    func transformRotation() {
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation"
        animation.duration = 2
        animation.byValue = M_PI * 2
        colorLayer.add(animation, forKey: nil)
        /*
         用transform.rotation而不是transform做动画的好处如下：
         
         - 我们可以不通过关键帧一步旋转多于180度的动画。
         - 可以用相对值而不是绝对值旋转（设置byValue而不是toValue）。
         - 可以不用创建CATransform3D，而是使用一个简单的数值来指定角度。
         - 不会和transform.position或者transform.scale冲突（同样是使用关键路径来做独立的动画属性）。
         */
    }
    
    // MARK: - 动画组
    /*
     CABasicAnimation和CAKeyframeAnimation仅仅作用于单独的属性，而CAAnimationGroup可以把这些动画组合在一起。CAAnimationGroup是另一个继承于CAAnimation的子类，它添加了一个animations数组的属性，用来组合别的动画。
     */
    func animationGroup() {
        //create the position animation
        let animation1 = CAKeyframeAnimation()
        animation1.keyPath = "position"
        animation1.path = bezierPath.cgPath
        animation1.rotationMode = kCAAnimationRotateAuto
        
        //create the color animation
        let animation2 = CABasicAnimation()
        animation2.keyPath = "backgroundColor"
        animation2.toValue = UIColor.random.cgColor
        
        //create group animation
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [animation1, animation2]
        groupAnimation.duration = 4
        
        colorLayer.add(groupAnimation, forKey: nil)
    }
    
    // MARK: - 过渡
    /*
     有时候对于iOS应用程序来说，希望能通过属性动画来对比较难做动画的布局进行一些改变。比如交换一段文本和图片，或者用一段网格视图来替换，等等。
     属性动画只对图层的可动画属性起作用，所以如果要改变一个不能动画的属性（比如图片），或者从层级关系中添加或者移除图层，属性动画将不起作用。
     
     于是就有了过渡的概念。过渡并不像属性动画那样平滑地在两个值之间做动画，而是影响到整个图层的变化。过渡动画首先展示之前的图层外观，然后通过一个交换过渡到新的外观。
     CATransision可以对图层任何变化平滑过渡
     */
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100))
        imageView.image = UIImage(named: "Anchor")
        self.view.addSubview(imageView)
        return imageView
    }()
    let images:[CGImage] = [
        UIImage(named: "Anchor")!.cgImage!,
        UIImage(named: "Cone")!.cgImage!,
        UIImage(named: "Igloo")!.cgImage!,
        UIImage(named: "Spaceship")!.cgImage!,
    ]
    var index = 0
    func transitionAnimation() {
        //set up crossfade transition
        let transition = CATransition()
        
        /*
         type属性是一个NSString类型，可以被设置成如下类型：
         
         - kCATransitionFade
            - 默认的过渡类型是kCATransitionFade，当你在改变图层属性之后，就创建了一个平滑的淡入淡出效果。
         - kCATransitionPush
            - 创建了一个新的图层，从边缘的一侧滑动进来，把旧图层从另一侧推出去的效
         
         - kCATransitionMoveIn
            - kCATransitionMoveIn从顶部滑动进入，但不像推送动画那样把老图层推走
         - kCATransitionReveal
            - kCATransitionReveal把原始的图层滑动出去来显示新的外观，而不是把新的图层滑动进入。
         */
        transition.type = kCATransitionReveal
        
        /*
         subtype来控制它们的方向，提供了如下四种类型：
         
         - kCATransitionFromRight
         - kCATransitionFromLeft
         - kCATransitionFromTop
         - kCATransitionFromBottom
         */
        transition.subtype = kCATransitionFromTop
        
        
        /*
         过渡动画和之前的属性动画或者动画组添加到图层上的方式一致，都是通过-addAnimation:forKey:方法。
         但是和属性动画不同的是，对指定的图层一次只能使用一次CATransition，因此，无论你对动画的键设置什么值，过渡动画都会对它的键设置成“transition”，也就是常量kCATransition。
         */
        //apply transition to imageview backing layer
        colorLayer.add(transition, forKey: nil)
        
        //cycle to next image
        index = (index + 1) % images.count
        colorLayer.contents = images[index]
    }
    
    // MARK: - 隐式过渡
    /*
     CATransision可以对图层任何变化平滑过渡的事实使得它成为那些不好做动画的属性图层行为的理想候选。
     苹果当然意识到了这点，并且当设置了CALayer的content属性的时候，CATransition的确是默认的行为。对于你自己创建的图层，对图层contents图片做的改动都会自动附上淡入淡出的动画。
     但是对于视图关联的图层，或者是其他隐式动画的行为，这个特性依然是被禁用的。
     */
    
    // MARK: - 对图层树的动画
    /*
     CATransition并不作用于指定的图层属性，这就是说你可以在即使不能准确得知改变了什么的情况下对图层做动画，例如，在不知道UITableView哪一行被添加或者删除的情况下，直接就可以平滑地刷新它，或者在不知道UIViewController内部的视图层级的情况下对两个不同的实例做过渡动画。
     
     这些例子和我们之前所讨论的情况完全不同，因为它们不仅涉及到图层的属性，而且是整个图层树的改变--我们在这种动画的过程中手动在层级关系中添加或者移除图层。
     
     这里用到了一个小诡计，要确保CATransition添加到的图层在过渡动画发生时不会在树状结构中被移除，否则CATransition将会和图层一起被移除。一般来说，你只需要将动画添加到被影响图层的superlayer。
     */
    
    //在UITabBarController切换标签的时候添加淡入淡出的动画。见YYBaseTabBarController
    
    // MARK: - 自定义动画
    /*
     过渡是一种对那些不太好做平滑动画属性的强大工具，但是CATransition的提供的动画类型太少了。
     
     更奇怪的是苹果通过UIView +transitionFromView:toView:duration:options:completion:和+transitionWithView:duration:options:animations:方法提供了Core Animation的过渡特性。
     但是这里的可用的过渡选项和CATransition的type属性提供的常量完全不同。UIView过渡方法中options参数可以由如下常量指定：

     就像之前提到的那样，过渡动画做基础的原则就是对原始的图层外观截图，然后添加一段动画，平滑过渡到图层改变之后那个截图的效果。如果我们知道如何对图层截图，我们就可以使用属性动画来代替CATransition或者是UIKit的过渡方法来实现动画。
     */
    
    // MARK: - 在动画过程中取消动画
    /*
     为了终止一个指定的动画，你可以用如下方法把它从图层移除掉：
     
     - (void)removeAnimationForKey:(NSString *)key;
     
     或者移除所有动画：
     
     - (void)removeAllAnimations;
     
     动画一旦被移除，图层的外观就立刻更新到当前的模型图层的值。
     一般说来，动画在结束之后被自动移除，除非设置removedOnCompletion为NO，如果你设置动画在结束之后不被自动移除，那么当它不需要的时候你要手动移除它；否则它会一直存在于内存中，直到图层被销毁。
     */
}
























