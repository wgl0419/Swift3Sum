//
//  FunctionalThoughtDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/17.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

// MARK: - 函数式思想

/*
 函数在 Swift 中是一等值 (first-class-values)，换句话说，函数可以作为参数被传递到其它函数，也可以作为其它函数的返回值。如果你习惯了使用像是整型，布尔型或是结构体这样的简单类型来编程，那么这个理念可能看来非常奇怪。在本章中，我们会尽可能解释为什么一等函数是很有用的语言特性，并实际地提供本书的第一个函数式编程案例。
 */

// MARK: - 案例：Battleship

/*
 我们将会用一个小案例来引出一等函数：这个例子是你在编写战舰类游戏时可能需要实现的一个核心函数。我们把将要看到的问题归结为，判断一个给定的点是否在射程范围内，并且距离友方船舶和我们自身都不太近。
 
 */

typealias Distance = Double

struct Positon {
    var x: Distance
    var y: Distance
}

extension Positon {
    func inRange(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
    
    func minus(_ p: Positon) -> Positon {
        return Positon(x: x - p.x, y: y - p.y)
    }
    var length: Distance {
        return sqrt(x * x + y * y)
    }
}

struct Ship {
    var position: Positon
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canEnageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx - dy * dy)
        return targetDistance <= firingRange
    }
    
    func canSafelyEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx - dy * dy)
        return targetDistance <= firingRange && targetDistance > unsafeRange
    }
    
    //最后，我们还需要避免目标船舶过于靠近我方的任意一艘船。
    func canSafelyEngageShip1(target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(target.position).length
        return targetDistance <= firingRange &&
            targetDistance > unsafeRange &&
            friendlyDistance > unsafeRange
    }
}

// MARK: - 一等函数

/*
 在当前 canSafelyEngageShip 的函数体中，主要的行为是为构成返回值的布尔条件组合进行编码。在这个简单的例子中，虽然想知道这个函数做了什么并不是太难，但我们还是想要一个更模块化的解决方案。
 
 我们已经在 Position 中引入了辅助函数使几何运算的代码更清晰易懂。用同样的方式，我们现在要添加一个函数，以更加声明式的方式来判断一个区域内是否包含某个点。
 
 原来的问题归根结底是要定义一个函数来判断一个点是否在范围内。这样一个函数的类型会像是下面这样的：
 */

//Region 类型将指代把 Position 转化为 Bool 的函数。
typealias Region = (Positon) -> Bool

/*
 我们使用一个能判断给定点是否在区域内的函数来代表一个区域，而不是定义一个对象或结构体来表示它。
 如果你不习惯函数式编程，这可能看起来会很奇怪，但是记住：在 Swift 中函数是一等值！我们有意识地选择了Region 作为这个类型的名字，而非 CheckInRegion 或 RegionBlock 这种字里行间暗示着它们代表一种函数类型的名字。
 函数式编程的核心理念就是函数是值，它和结构体、整型或是布尔型没有什么区别 —— 对函数使用另外一套命名规则会违背这一理念。
 */

//1. 我们定义的第一个区域是以原点为圆心的圆 (circle)：
func circle(radius: Distance) -> Region {
    return { point in
        point.length <= radius
    }
}

//2. 圆心是任意定点的圆，我们只需要添加另一个代表圆心的参数，并确保在计算新区域时将这个参数考虑进去：
func circle2(radius: Distance, center: Positon) -> Region {
    return { point in
        point.minus(center).length <= radius
    }
}

//3. 如果我们想对更多的图形组件(例如，想象我们不仅有圆，还有矩形或其它形状)做出同样的改变，可能需要重复这些代码。更加函数式的方式是写一个区域变换函数。这个函数按一定的偏移量移动一个区域：
func shift(region: @escaping Region, offset: Positon) -> Region {
    return { point in
        region(point.minus(offset))
    }
}

/*
 调用 shift(region, offset: offset) 函数会将区域向右上方移动，偏移量分别是 offset.x 和offset.y。我们需要的是一个传入 Position 并返回 Bool 的函数 Region。
 为此，我们需要另写一个闭包，它接受我们要检验的点，这个点减去偏移量之后我们得到一个新的点。最后，为了检验新点是否在原来的区域内，我们将它作为参数传递给 region 函数。
 
 这是函数式编程的核心概念之一：为了避免创建像 circle2 这样越来越复杂的函数，我们编写了一个shift(_:offset:) 函数来改变另一个函数。
 例如，一个圆心为 (5, 5) 半径为 10 的圆，可以用下面的方式表示：
shift(circle(10), offset: Position(x: 5, y: 5))
 */

//4. 还有很多其它的方法可以变换已经存在的区域。例如，也许我们想要通过反转一个区域以定义另一个区域。这个新产生的区域由原区域以外的所有点组成：
func invert(region: @escaping Region) -> Region {
    return { point in !region(point) }
}

// 5. 我们也可以写一个函数将既存区域合并为更大更复杂的区域。比如，下面两个函数分别可以计算参数中两个区域的交集和并集：
func intersection(_ region1: @escaping Region, _ region2: @escaping Region) -> Region {
    return { point in region1(point) && region2(point) }
}

func union(_ region1: @escaping Region, _ region2: @escaping Region) -> Region {
    return { point in region1(point) || region2(point) }
}

// 6. 当然，我们可以利用这些函数来定义更丰富的区域。difference 函数接受两个区域作为参数 —— 原来的区域和要减去的区域 —— 然后为所有在第一个区域中且不在第二个区域中的点构建一个新的区域：
func difference(region: @escaping Region, minus: @escaping Region) -> Region {
    return intersection(region, invert(region: minus))
}

/*
 这个例子告诉我们，在 Swift 中计算和传递函数的方式与整型或布尔型没有任何不同。这让我们能够写出一些基础的图形组件 (比如圆)，进而能以这些组件为基础，来构建一系列函数。每个函数都能修改或是合并区域，并以此创建新的区域。比起写复杂的函数来解决某个具体的问题，现在我们完全可以通过将一些小型函数装配起来，广泛地解决各种各样的问题。
 */

//7. 重构 canSafelyEngageShip(_:friendly:) 这个复杂的函数：
extension Ship {
    func canSafelyEngageShip2(target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = difference(region: circle(radius: firingRange), minus: circle(radius: unsafeRange))
        let firingRegion = shift(region: rangeRegion, offset: position)
        let friendlyRegion = shift(region: circle(radius: unsafeRange), offset: friendly.position)
        let resultRegion = difference(region: firingRegion, minus: friendlyRegion)
        
        /*
         定义了两个区域：firingRegion 和 friendlyRegion。
         通过计算这两个区域的差集 (即在 firingRegion 中且不在 friendlyRegion 中的点的集合)，我们可以得到我们感兴趣的区域。
         将这个区域函数作用在目标船舶的位置上，我们就可以计算所需的布尔值了。
         */
        return resultRegion(target.position)
    }
}

/*
 面对同一个问题，与原来的 canSafelyEngageShip1(_:friendly:) 函数相比，使用 Region 函数重构后的版本是更加声明式的解决方案。我们坚信后一个版本会更容易理解，因为我们的解决方案是装配式的。你可以探究组成它的每个部分，例如 firingRegion 和 friendlyRegion，看一看它们是如何被装配并解决原来的问题的。另一方面，原来庞大的函数混合了各个组成区域的描述语句和描述它们所需要的算式。通过定义我们之前提出的辅助函数将这些关注点进行分离，显著提高了复杂区域的组合性和易读性。
 
 能做到这样，一等函数是至关重要的。虽然 Objective-C 也支持一等函数，或者说是 block，也可以做到类似的事情，但遗憾的是，在 Objective-C 中使用 block 十分繁琐。一部分原因是因为语法问题：block 的声明和 block 的类型与 Swift 的对应部分相比并不是那么简单。在后面的章节中，我们也将看到泛型如何让一等函数更加强大，远比 Objective-C 中用 blocks 实现更加容易。
 
 我们定义 Region 类型的方法有它自身的缺点。我们选择了将 Region 类型定义为简单类型，并作为 Position -> Bool 函数的别名。其实，我们也可以选择将其定义为一个包含单一函数的结构体：
 
 struct Region {
 let lookup: Position -> Bool
 }
 接下来我们可以用 extensions 的方式为结构体定义一些类似的函数，来代替对原来的 Region 类型进行操作的那些函数。这可以让我们能够通过对区域进行反复的函数调用来变换这个区域，直至得到需要的复杂区域，而不用像以前那样将区域作为参数传递给其他函数：
 
 rangeRegion.shift(ownPosition).difference(friendlyRegion)
 这种方法有一个优点，它需要的括号更少。再者，这种方式下 Xcode 的自动补全在装配复杂的区域时会十分有用。不过，为了便于展示，我们选择了使用简单的类型别名以突出在 Swift 中使用高阶函数的方法。
 
 此外，值得指出的是，现在我们不能够看到一个区域是如何被构建的：它是由更小的区域组成的吗？还是单纯只是一个以原点为圆心的圆？我们唯一能做的是检验一个给定的点是否在区域内。如果想要形象化一个区域，我们只能对足够多的点进行采样来生成 (黑白) 位图。
 */


class FunctionalThoughtDemo: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}




























