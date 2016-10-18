//
//  CoreImageDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/11.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK
// MARK: - 滤镜类型

/*
 CIFilter 是 Core Image 中的核心类之一，用于创建图像滤镜。当实例化一个 CIFilter 对象时，你 (几乎) 总是通过 kCIInputImageKey 键提供输入图像，再通过 kCIOutputImageKey 键取回处理后的图像。取回的结果可以作为下一个滤镜的输入值。
 */
typealias YYFilter = (CIImage) -> CIImage

class CoreImageDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    // MARK: - 模糊
    
    /**< 高斯模糊滤镜。定义它只需要模糊半径这一个参数 
     
     一切就是这么简单。blur 函数返回一个新函数，新函数接受一个 CIImage 类型的参数 image，并返回一个新图像 (return filter.outputImage)。因此，blur 函数的返回值满足我们之前定义的 CIImage -> CIImage，也就是 Filter 类型。
     */
    func blur(radius: Double) -> YYFilter {
        return { image in
            let parameters: [String : Any] = [
                kCIInputRadiusKey: radius,
                kCIOutputImageKey: image
            ]
            guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: parameters) else {
                yyLogFatal("CIFilter(name: CIGaussianBlur, withInputParameters: \(parameters)) failed")
                fatalError()
            }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        }
    }
    
    // MARK: - 颜色叠层
    
    /**< 现在让我们来定义一个能够在图像上覆盖纯色叠层的滤镜。Core Image 默认不包含这样一个滤镜，但是我们完全可以用已经存在的滤镜来组成它。
     
     我们将使用的两个基础组件：颜色生成滤镜 (CIConstantColorGenerator) 和图像覆盖合成滤镜 (CISourceOverCompositing)。
     */
    func colorGenerator(_ color: UIColor) -> YYFilter {
        /**< 看起来和我们用来定义模糊滤镜的代码非常相似，但是有一个显著的区别:
         颜色生成滤镜不检查输入图像。
         因此，我们不需要给返回函数中的图像参数命名。
         取而代之，我们使用一个匿名参数 _ 来强调滤镜的输入图像参数是被忽略的。 */
        return { _ in
            let parameters = [kCIInputColorKey: CIColor(color: color)]
            guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else {
                fatalError()
            }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        }
    }
    
    //定义合成滤镜
    func compositeSourceOver(_ overlay: CIImage) -> YYFilter {
        return { image in
            let parameters: [String : Any] = [
                kCIInputBackgroundImageKey: image,
                kCIOutputImageKey: overlay
            ]
            guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else {
                fatalError()
            }
            guard let outputImage = filter.outputImage else { fatalError() }
            return outputImage
        }
    }
    
    //最后，我们通过结合两个滤镜来创建颜色叠层滤镜：
    func colorOverlay(color: UIColor) -> YYFilter {
        /**< 首先使用 colorGenerator 函数创建一个滤镜，接着向这个滤镜传递一个 image 参数来创建新图像。与之类似，返回值 compositeSourceOver(overlay)(image) 由一个通过 compositeSourceOver(overlay)函数构建的滤镜和随即被作为参数的 image 组成。 */
        return { image in
            let overlay = self.colorGenerator(color)(image)
            return self.compositeSourceOver(overlay)(image)
        }
    }
    
    // MARK: - 组合滤镜
    
    /**< 到现在为止，我们已经定义了模糊滤镜和颜色叠层滤镜，可以把它们组合在一起使用：首先将图像模糊，然后再覆盖上一层红色叠层。 */
    func test() {
        let url = URL(string: "http://www.objc.io/images/covers/16.jpg")!
        let image = CIImage(contentsOf: url)!
        
//        我们可以链式地将两个滤镜应用到载入的图像上
        let blurRadius = 5.0
        let overlayColor = UIColor.red
        let blurredImage = blur(radius: blurRadius)(image)
        _ = colorOverlay(color: overlayColor)(blurredImage)
        
        var myFilter = composeFilters(blur(radius: blurRadius), colorOverlay(color: overlayColor))
        _ = myFilter(image)
        
        //使用自定义运算符版本,>>> 是左结合的 (left-associative)，就像 Unix 的管道一样，滤镜将以从左到右的顺序被应用到图像上。
        myFilter = blur(radius: blurRadius) >>> colorOverlay(color: overlayColor)
        _ = myFilter(image)
        
    }

    // MARK: - 复合函数
    
    /**< 当然，我们可以将上面代码里两个调用滤镜的表达式简单合为一体：
     
     let result = colorOverlay(overlayColor)(blur(blurRadius)(image))
     
     然而，由于括号错综复杂，这些代码很快失去了可读性。更好的解决方式是自定义一个运算符来组合滤镜。为了定义该运算符，首先我们要定义一个用于组合滤镜的函数：
 */
    //接受两个 Filter 类型的参数，并返回一个新定义的滤镜。这个复合滤镜接受一个 CIImage 类型的图像参数，然后将该参数传递给 filter1，取得返回值之后再传递给 filter2。
    func composeFilters(_ filter1: @escaping YYFilter, _ filter2: @escaping YYFilter) -> YYFilter {
        return { image in
            filter2(filter1(image))
        }
    }
    
    // MARK: - 为组合滤镜引入运算符
    
    /**< 为了让代码更具可读性，我们可以再进一步，为组合滤镜引入运算符。
     随意自定义运算符并不一定对提升代码可读性有帮助。
     不过，在图像处理库中，滤镜的组合是一个反复被讨论的问题，所以引入运算符极有意义： */
}

precedencegroup LeftPrecedence {
    associativity: left
    lowerThan: LogicalConjunctionPrecedence
}
infix operator >>> { associativity left }

func >>>(_ filter1: @escaping YYFilter, _ filter2: @escaping YYFilter) -> YYFilter {
    return { image in
        filter2(filter1(image))
    }
}
































