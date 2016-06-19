//: Playground - noun: a place where people can play

import UIKit

/*
 ## API修改
 
 Swift 3.0最大的升级是标准库将会沿用之前的命名规范, [API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)包括了团队在完成Swift 3.0的时候定下来的规范, 对于新程序员有更高的可读性和易用性. 核心团队坚守”Good API Design always consider the call site”. 他们力争明确每一个使用的场景. 以下是一些马上会影响你的改变.
 
 ### 第一个参数的参数名
 
 让我们先来颠覆一个你每天都在swift里的操作吧
 
 函数和方法的第一个参数名不会再自动省略了, 除非你用了”_”. 之前你每次调用一个方法或者函数的时候都会自动省略第一个参数的参数名.
 
 ```
 // 第一个是 Swift 2的写法
 // 第二个是 Swift 3的写法
 
 "RW".writeToFile("filename", atomically: true, encoding: NSUTF8StringEncoding)
 "RW".write(toFile: "filename", atomically: true, encoding: NSUTF8StringEncoding)
 
 SKAction.rotateByAngle(CGFloat(M_PI_2), duration: 10)
 SKAction.rotate(byAngle: CGFloat(M_PI_2), duration: 10)
 
 UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
 UIFont.preferredFont(forTextStyle: UIFontTextStyleSubheadline)
 
 override func numberOfSectionsInTableView(tableView: UITableView) -> Int
 override func numberOfSections(in tableView: UITableView) -> Int
 
 func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
 func viewForZooming(in scrollView: UIScrollView) -> UIView?
 
 NSTimer.scheduledTimerWithTimeInterval(0.35, target: self, selector: #selector(reset), userInfo: nil, repeats: true)
 NSTimer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(reset), userInfo: nil, repeats: true)
 ```
 
 我们可以注意到函数和方法的定义是怎么使用类似于”of”, “to”, “with”和”in”这样的介词作为外部参数名( 而不再放在函数或者方法名里). 这一部分的修改是为了提高可读性.
 
 如果调用方法的时候不需要介词和外部参数名的时候, 你应该在第一个参数名前面加一个下划线_来表明:
 
 ```
 override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { ... }
 override func didMoveToView(_ view: SKView) { ... }
 ```
 */

//在很多编程语言里, 不同的方法也许会用同一个名字但使用不同的参数名. Swift也不例外, 在API修改得更加直接之后, 现在我们可以通过重载来使用同一个方法名调用不同的方法. 下面是index()的两种调用方式:
let names = ["Anna", "Barbara"]
if let annaIndex = names.index(of: "Anna") {
    print("Barbara's position: \(names.index(after: annaIndex))")
}
//现在, 变量名的改变让方法名能够更加具有一致性, 并且更容易理解

/*
 ### 移除多余的字词
 
 在之前Apple的库里面, 方法名通常会包含一个名字去表明返回值的类型, 但现在得益于Swift编译器的类型推断能力, 这件事情变得不再那么必要了. Swift核心团队花了很多功夫去过滤杂音, 提取提案里的真正需求, 就这样很多重复的词都去除掉了.
 
 Objective-C和C语言库的API变得更加接近原生Swift [SE-0005]:
 */

// old way, Swift 2, followed by new way, Swift 3
//let blue = UIColor.blueColor()
let blue = UIColor.blue()

//let min = numbers.minElement()
//let min = numbers.min()

//attributedString.appendAttributedString(anotherString)
//attributedString.append(anotherString)

//names.insert("Jane", atIndex: 0)
//names.insert("Jane", at: 0)

//UIDevice.currentDevice()
UIDevice.current()


/*
 ### GCD和Core Graphics的现代化
 
 提到顽固的老API, GCD和Core Graphics的语法都得到了美化
 
 GCD被用来处理诸如耗时运算和服务器通信的多线程任务, 通过把任务移到别的线程, 你可以防止自己的用户界面线程被阻塞. libdispatch这个库是用C语言写的, 并且API也是C语言风格的. 这一套API现在被重新塑造成原生的Swift风格 [SE-0088]:
 */
// Swift 2的写法
//let queue = dispatch_queue_create("com.test.myqueue", nil)
//dispatch_async(queue) {
//    print("Hello World")
//}

// Swift 3的写法
let queue = DispatchQueue(label: "com.my.queue")
queue.async { 
    print("DispatchQueue")
}


/*
 同样的, Core Graphics也是C语言写的, 并且以前都是使用很怪异的方法去调用. 新的用法就像这样 [SE-0044]:
 
 // Swift 2的写法
 let ctx = UIGraphicsGetCurrentContext()
 let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
 CGContextSetFillColorWithColor(ctx, UIColor.blueColor().CGColor)
 CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor().CGColor)
 CGContextSetLineWidth(ctx, 10)
 CGContextAddRect(ctx, rectangle)
 CGContextDrawPath(ctx, .FillStroke)
 UIGraphicsEndImageContext()
 */
if let ctx = UIGraphicsGetCurrentContext() {
    let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
    ctx.setFillColor(UIColor.blue().cgColor)
    ctx.setStrokeColor(UIColor.white().cgColor)
    ctx.setLineWidth(10)
    ctx.addRect(rectangle)
    ctx.drawPath(using: .fillStroke)
    
    UIGraphicsEndImageContext()
}


/*
 ### 枚举值首字母大小写
 
 另一个完全不同的地方来自于你日常编写Swift代码的方式, 枚举的值现在要用首字母小写的驼峰命名法(lowerCamelCase). 这会让他们看起来跟其他Property和Values更加一致 (向Struct和Class靠拢) [SE-0006]:
 
 
 // old way, Swift 2, followed by new way, Swift 3
 UIInterfaceOrientationMask.Landscape
 UIInterfaceOrientationMask.landscape
 
 NSTextAlignment.Right
 NSTextAlignment.right
 
 SKBlendMode.Multiply
 SKBlendMode.multiply
 
 首字母大写的驼峰命名(UpperCamelCase)现在只有类型(Types)和协议(Protocols). 你也许需要一些时间去适应, 这是Swift团队对于一致性的执着.
 */

/*
 ### 方法名: 修改 / 返回修改后的副本
 
 标准库里方法名的动词和名词都更加具有一致性, 你可以根据action造成的效应去选择命名方式(You choose a name based on side effects or the action taken). 最重要的原则是如果方法名包含了”-ed”或者”-ing”这样的后缀的话, 那么就可以把方法当做一个名词, 一个”名词方法”将会返回一个值, 如果它不包含后缀, 那很像是一个动词, 这些”动词方法”将会在引用对象的内存里进行操作, 也就是修改对象. 这里有几对动词和名词方法遵循这样的原则 [SE-0006]:
 
 customArray.enumerate()
 customArray.enumerated()
 
 customArray.reverse()
 customArray.reversed()
 
 customArray.sort() // 原来的写法 .sortInPlace()
 customArray.sorted()
 */
var ages = [21, 10, 2] // 这里是变量而不是常量, 所以可以修改
ages.sort()// 在这里进行修改, 当前值为 [2, 10, 21]

// "-ed" 后缀意味着会返回一个修改后的副本
for (index, age) in ages.enumerated() {
    print("\(index). \(age)") // 1. 2 \n 2. 10 \n 3. 21
}

/*
 ### 函数类型
 
 函数声明和调用总是会要求用圆括号()把参数包起来:
 
 ```
 func f(a: Int) { ... }
 
 f(5)
 ```
 不过, 当你使用函数作为参数传入的时候, 你也许会写成这样:
 
	func g(a: Int -> Int) -> Int -> Int  { ... } // Swift 2的写法
 你也许会发现这样可读性很差, 参数在哪里结束? 返回值在哪里开始? Swift 3.0里定义函数的正确方式是这样的 [SE-0066]:
 
	func g(a: (Int) -> Int) -> (Int) -> Int  { ... } // Swift 3的写法
	
 现在参数必须被圆括号()包住, 后面跟着返回值类型. 一切都变得很清晰, 具有连贯性, 函数的类型更容易看出来. 下面一个很明显的对比:
 
 ```
 // Swift 2的写法
 Int -> Float
 String -> Int
 T -> U
 Int -> Float -> String
 
 // Swift 3的写法
 (Int) -> Float
 (String) -> Int
 (T) -> U
 (Int) -> (Float) -> String
 
 */

/*
 ## API的补充
 
 Swift 3.0最大的更新是现有API变得更加现代化, 有越来越多的Swift社区在致力于这件事, 包括一些额外的, 实用API
 
 获取类型
 
 当你定义一个static的property或者method的的时候, 你必须通过他们的Type去调用他们:

 */
struct CustomStruct {
    static func staticMethod() {
        print("staticMethod")
    }
    
    func instanceMethod() {
        CustomStruct.staticMethod()
        //Self.staticMethod() error
    }
}
let customStruct = CustomStruct()
//customStruct.Self.staticMethod() error

/*
 ### Inline Sequences
 
 sequence(first: next:)和sequence(state: next:)是返回无限的sequence的全局方法. 你可以给他们一个初始值或者一个可变的状态, 然后他们会通过闭包进行懒加载 [SE-0094]
 
 你可以通过prefix关键字来给sequence增加限制 [SE-0045]:
 */
for x in sequence(first: 0.1, next: { $0 * 2 }).prefix(4) {
    print(x)
}
















