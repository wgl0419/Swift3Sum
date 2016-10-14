//
//  ImplicitAnimationsDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/5.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class ImplicitAnimationsDemo: UIViewController {

    weak var colorLayer: CALayer!
    override func viewDidLoad() {
        super.viewDidLoad()

        setupColorLayer()
        addButtonToView(title: "点击将改变颜色的动画调整为推进过渡效果") { [weak self] (_) in
            self?.setPushTransition()
        }
    }

    /*
     1. 事务
     
     Core Animation基于一个假设，说屏幕上的任何东西都可以（或者可能）做动画。动画并不需要你在Core Animation中手动打开，相反需要明确地关闭，否则他会一直存在。
     
     当你改变CALayer的一个可做动画的属性，它并不能立刻在屏幕上体现出来。相反，它是从先前的值平滑过渡到新的值。这一切都是默认的行为，你不需要做额外的操作。
     */
    func setupColorLayer() {
        let colorLayer = CALayer()
        colorLayer.frame = CGRect(x: 4, y: 10, width: 100, height: 100)
        colorLayer.backgroundColor = UIColor.red.cgColor
        view.layer.addSublayer(colorLayer)
        self.colorLayer = colorLayer
        
        addButtonToView(title: "点击改变颜色") { [weak self] (_) in
            self?.changeColorAnimated()
        }
    }
    
    /*
     但当你改变一个属性，Core Animation是如何判断动画类型和持续时间的呢？
     
     实际上动画执行的时间取决于当前事务的设置，动画类型取决于图层行为。
     
     事务是Core Animation用来包含一系列属性动画集合的机制，任何用指定事务去改变可以做动画的图层属性都不会立刻发生变化，而是当事务一旦提交的时候开始用一个动画过渡到新值。
     
     事务是通过CATransaction类来做管理，CATransaction没有属性或者实例方法，并且也不能用+alloc和-init方法创建它。但是可以用+begin和+commit分别来入栈或者出栈。
     
     任何可以做动画的图层属性都会被添加到栈顶的事务，你可以通过+setAnimationDuration:方法设置当前事务的动画时间，或者通过+animationDuration方法来获取值（默认0.25秒）。
     
     Core Animation在每个run loop周期中自动开始一次新的事务，即使你不显式的用[CATransaction begin]开始一次事务，任何在一次run loop循环中属性的改变都会被集中起来，然后做一次0.25秒的动画。
     
     明白这些之后，我们就可以轻松修改变色动画的时间了。我们当然可以用当前事务的+setAnimationDuration:方法来修改动画时间，但在这里我们首先起一个新的事务，于是修改时间就不会有别的副作用。因为修改当前事务的时间可能会导致同一时刻别的动画（如屏幕旋转），所以最好还是在调整动画之前压入一个新的事务。
     */
    func changeColorAnimated() {
        //begin a new transaction
        CATransaction.begin()
        
        //set the animation duration to 1 second
        CATransaction.setAnimationDuration(1)//默认0.25秒
        
        //randomize the layer background color
        colorLayer.backgroundColor = UIColor.random.cgColor
        
        /*
         改变UIView关联图层的背景色没有动画
         图层颜色瞬间切换到新的值，而不是上面平滑过渡的动画。隐式动画被UIView关联图层给禁用了。
         
         我们把改变属性时CALayer自动应用的动画称作行为，当CALayer的属性被修改时候，它会调用-actionForKey:方法，传递属性的名称。剩下的操作都在CALayer的头文件中有详细的说明，实质上是如下几步：
         
         1. 图层首先检测它是否有委托，并且是否实现CALayerDelegate协议指定的-actionForLayer:forKey方法。如果有，直接调用并返回结果。
         2. 如果没有委托，或者委托没有实现-actionForLayer:forKey方法，图层接着检查包含属性名称对应行为映射的actions字典。
         3. 如果actions字典没有包含对应的属性，那么图层接着在它的style字典接着搜索属性名。
         4. 最后，如果在style里面也找不到对应的行为，那么图层将会直接调用定义了每个属性的标准行为的-defaultActionForKey:方法。
         
         所以一轮完整的搜索结束之后，-actionForKey:要么返回空（这种情况下将不会有动画发生），要么是CAAction协议对应的对象，最后CALayer拿这个结果去对先前和当前的值做动画。

         于是这就解释了UIKit是如何禁用隐式动画的：
         每个UIView对它关联的图层都扮演了一个委托，并且提供了-actionForLayer:forKey的实现方法。当不在一个动画块的实现中，UIView对所有图层行为返回nil，但是在动画block范围之内，它就返回了一个非空值。
         */
        view.layer.backgroundColor = UIColor.random.cgColor
        
        /*
         当然返回nil并不是禁用隐式动画唯一的办法，CATransaction有个方法叫做+setDisableActions:，
         可以用来对所有属性打开或者关闭隐式动画。
         */
        //CATransaction.setDisableActions(true)
        
        //add the spin animation on completion
        CATransaction.setCompletionBlock {
            let transform = self.colorLayer.affineTransform().rotated(by: CGFloat(M_PI_2))
            //这个动画时间是默认0.25秒
            self.colorLayer.setAffineTransform(transform)
        }
        
        //commit the transaction
        CATransaction.commit()
    }

    // MARK: - 自定义的actions字典 来改变layer的隐式动画
    /*
     通过给colorLayer设置一个自定义的actions字典。我们也可以使用委托来实现，但是actions字典可以写更少的代码。
     这里我们使用的是一个实现了CATransition的实例，叫做推进过渡。
     */
    func setPushTransition() {
        let transtion = CATransition()
        transtion.type = kCATransitionPush
        transtion.subtype = kCATransitionFromLeft
        
        colorLayer.actions = ["backgroundColor": transtion]
        //colorLayer.style
    }
    
    // MARK: - 4. 呈现与模型
    
    /*
     CALayer的属性行为其实很不正常，因为改变一个图层的属性并没有立刻生效，而是通过一段时间渐变更新。这是怎么做到的呢？
     
     当你改变一个图层的属性，属性值的确是立刻更新的（如果你读取它的数据，你会发现它的值在你设置它的那一刻就已经生效了），但是屏幕上并没有马上发生改变。这是因为你设置的属性并没有直接调整图层的外观，相反，他只是定义了图层动画结束之后将要变化的外观。
     
     当设置CALayer的属性，实际上是在定义当前事务结束之后图层如何显示的模型。Core Animation扮演了一个控制器的角色，并且负责根据图层行为和事务设置去不断更新视图的这些属性在屏幕上的状态。
     
     我们讨论的就是一个典型的微型MVC模式。CALayer是一个连接用户界面（就是MVC中的view）虚构的类，但是在界面本身这个场景下，CALayer的行为更像是存储了视图如何显示和动画的数据模型。实际上，在苹果自己的文档中，图层树通常都是值的图层树模型。
     
     在iOS中，屏幕每秒钟重绘60次。如果动画时长比60分之一秒要长，Core Animation就需要在设置一次新值和新值生效之间，对屏幕上的图层进行重新组织。这意味着CALayer除了“真实”值（就是你设置的值）之外，必须要知道当前显示在屏幕上的属性值的记录。
     
     每个图层属性的显示值都被存储在一个叫做呈现图层的独立图层当中，他可以通过-presentationLayer方法来访问。这个呈现图层实际上是模型图层的复制，但是它的属性值代表了在任何指定时刻当前外观效果。换句话说，你可以通过呈现图层的值来获取当前屏幕上真正显示出来的值（图7.4）。
     
     我们在第一章中提到除了图层树，另外还有呈现树。呈现树通过图层树中所有图层的呈现图层所形成。注意呈现图层仅仅当图层首次被提交（就是首次第一次在屏幕上显示）的时候创建，所以在那之前调用-presentationLayer将会返回nil。
     
     你可能注意到有一个叫做–modelLayer的方法。在呈现图层上调用–modelLayer将会返回它正在呈现所依赖的CALayer。通常在一个图层上调用-modelLayer会返回–self（实际上我们已经创建的原始图层就是一种数据模型）。
     
     大多数情况下，你不需要直接访问呈现图层，你可以通过和模型图层的交互，来让Core Animation更新显示。两种情况下呈现图层会变得很有用，一个是同步动画，一个是处理用户交互。
     
     1. 如果你在实现一个基于定时器的动画（见第11章“基于定时器的动画”），而不仅仅是基于事务的动画，这个时候准确地知道在某一时刻图层显示在什么位置就会对正确摆放图层很有用了。
     2. 如果你想让你做动画的图层响应用户输入，你可以使用-hitTest:方法（见第三章“图层几何学”）来判断指定图层是否被触摸，这时候对呈现图层而不是模型图层调用-hitTest:会显得更有意义，因为呈现图层代表了用户当前看到的图层位置，而不是当前动画结束之后的位置。

     */
    
    //让动画的图层，响应事件
    //点击屏幕上的任意位置将会让图层平移到那里。点击图层本身可以随机改变它的颜色。
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: view)
        if ((colorLayer.presentation()?.hitTest(point)) != nil) {
            colorLayer.backgroundColor = UIColor.random.cgColor
        } else {
            CATransaction.begin()
            CATransaction.setAnimationDuration(4)
            colorLayer.position = point
            CATransaction.commit()
        }
    }
}














