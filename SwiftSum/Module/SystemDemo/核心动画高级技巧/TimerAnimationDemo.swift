//
//  TimerAnimationDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/18.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 定时帧

/**< 动画看起来是用来显示一段连续的运动过程，但实际上当在固定位置上展示像素的时候并不能做到这一点。
 一般来说这种显示都无法做到连续的移动，能做的仅仅是足够快地展示一系列静态图片，只是看起来像是做了运动。 */

class TimerAnimationDemo: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 我们来试着用NSTimer来修改第十章中弹性球的例子。
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate()
    }
    
    lazy var ballView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "Ball")!
        imageView.frame = CGRect(origin: self.view.center, size: image.size)
        imageView.image = image
        self.view.addSubview(imageView)
        return imageView
    }()
    
    var duration = 1.0
    var timeOffset = 1.0
    var fromValue = NSValue()
    var toValue = NSValue()
    var timer: Timer?
    var timer2: CADisplayLink?
    var lastStep = CACurrentMediaTime()
    
    func animate() {
        ballView.center = CGPoint(x: 150, y: 32)
        duration = 1.0
        timeOffset = 0
        fromValue = NSValue(cgPoint: CGPoint(x: 150, y: 32))
        toValue = NSValue(cgPoint: CGPoint(x: 150, y: 268))
        timer?.invalidate()
//        timer = Timer.scheduledTimer(timeInterval: 1/60.0, target: self, selector: #selector(step), userInfo: nil, repeats: true)
        
        /**< NSTimer并不是最佳方案,我们可以通过一些途径来优化：
         - 我们可以用CADisplayLink让更新频率严格控制在每次屏幕刷新之后。
         - 基于真实帧的持续时间而不是假设的更新频率来做动画。
         - 调整动画计时器的run loop模式，这样就不会被别的事件干扰。
         */
        lastStep = CACurrentMediaTime()
        timer2?.invalidate()
        timer2 = CADisplayLink(target: self, selector: #selector(step))
        timer2?.add(to: RunLoop.main, forMode: .defaultRunLoopMode)
        timer2?.add(to: RunLoop.main, forMode: .UITrackingRunLoopMode)
    }
    
    // MARK: - CADisplayLink
    
    /*
     CADisplayLink是CoreAnimation提供的另一个类似于NSTimer的类，它总是在屏幕完成一次更新之前启动，它的接口设计的和NSTimer很类似，所以它实际上就是一个内置实现的替代，但是和timeInterval以秒为单位不同，CADisplayLink有一个整型的frameInterval属性，指定了间隔多少帧之后才执行。默认值是1，意味着每次屏幕更新之前都会执行一次。但是如果动画的代码执行起来超过了六十分之一秒，你可以指定frameInterval为2，就是说动画每隔一帧执行一次（一秒钟30帧）或者3，也就是一秒钟20次，等等。
     
     用CADisplayLink而不是NSTimer，会保证帧率足够连续，使得动画看起来更加平滑，但即使CADisplayLink也不能保证每一帧都按计划执行，一些失去控制的离散的任务或者事件（例如资源紧张的后台程序）可能会导致动画偶尔地丢帧。当使用NSTimer的时候，一旦有机会计时器就会开启，但是CADisplayLink却不一样：如果它丢失了帧，就会直接忽略它们，然后在下一次更新的时候接着运行。
     */
    
    // MARK: - 计算帧的持续时间
    
    /*
     无论是使用NSTimer还是CADisplayLink，我们仍然需要处理一帧的时间超出了预期的六十分之一秒。由于我们不能够计算出一帧真实的持续时间，所以需要手动测量。我们可以在每帧开始刷新的时候用CACurrentMediaTime()记录当前时间，然后和上一帧记录的时间去比较。
     */

    
    func step() {
        //calculate time delta
        let thisStep = CACurrentMediaTime()
        let stepDuration = thisStep - lastStep
        lastStep = thisStep
        
        timeOffset = min(timeOffset + stepDuration, duration)
        var time = timeOffset / duration
        time = bounceEaseOut(t: time)
        let postion = interpolate(fromValue: fromValue, toValue: toValue, time: CGFloat(time))
        ballView.center = postion.cgPointValue
        if timeOffset >= duration {
            timer?.invalidate()
            timer2?.invalidate()
        }
    }
    
    func bounceEaseOut(t: Double) -> Double {
        if (t < 4/11.0) {
            return (121.0 * t * t) / 16.0
        } else if (t < 8/11.0) {
            return (363 / 40.0 * t * t) - (99 / 10.0 * t) + 17 / 5.0
        } else if (t < 9/10.0) {
            return (4356 / 361.0 * t * t) - (35442 / 1805.0 * t) + 16061 / 1805.0;
        }
        return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
    }
    
    func interpolate(from: CGFloat, to: CGFloat, time: CGFloat) -> CGFloat {
        return (to - from) * time + from;
    }
    
    func interpolate(fromValue: NSValue, toValue: NSValue, time: CGFloat) -> NSValue {
        //        let type = fromValue.objCType
        let from = fromValue.cgPointValue
        let to = toValue.cgPointValue
        let result = CGPoint(x: interpolate(from: from.x, to: to.x, time: time), y: interpolate(from: from.y, to: to.y, time: time))
        return NSValue(cgPoint: result)
    }
}






























