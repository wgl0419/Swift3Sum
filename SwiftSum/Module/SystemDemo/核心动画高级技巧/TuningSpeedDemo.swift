//
//  TuningSpeedDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/19.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit

class TuningSpeedDemo: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var itmes = [[String: String]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0 ..< 100 {
            itmes.append([
                "name": randomName,
                "image": randomAvatar
                ])
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    var randomName: String {
        let names = ["Alice", "Bob", "Bill", "Charles", "Dan", "Dave", "Ethan", "Frank"]
        let index = Int(arc4random_uniform(26)) % names.count
        
        return names[index]
    }
    
    var randomAvatar: String {
        let images = ["Snowman", "Igloo", "Cone", "Spaceship", "Anchor", "Key"]
        let index = Int(arc4random_uniform(26)) % images.count
        return images[index]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itmes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let item = itmes[indexPath.row]
        let filePath = Bundle.main.path(forResource: item["image"], ofType: "png")
        
        cell.imageView?.image = UIImage(contentsOfFile: filePath!)
        cell.textLabel?.text = item["name"]
        
        cell.imageView?.layer.shadowOffset = CGSize(width: 0, height: 5)
        cell.imageView?.layer.shadowOpacity = 0.75
        cell.clipsToBounds = true
        
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.textLabel?.layer.shadowOpacity = 0.5
        
        // MARK: - 优化处理
        
        /*当快速滑动的时候就会非常卡, 滑动帧率降到20FPS
         1. 仅凭直觉，我们猜测性能瓶颈应该在图片加载。我们实时从闪存加载图片，而且没有缓存，所以很可能是这个原因。
         
         2. 在开始编码之前，测试一下假设是否成立。用我们的三个Instruments工具分析一下程序来定位问题。我们推测问题可能和图片加载相关，所以用Time Profiler工具来试试（图12.8）。
         
         3. tableView:cellForRowAtIndexPath:中的CPU时间总利用率只有~28%（也就是加载头像图片的地方），非常低。于是建议是CPU/IO并不是真正的限制因素。然后看看是不是GPU的问题：在OpenGL ES Driver工具中检测GPU利用率。渲染服务利用率的值达到51%和63%。看起来GPU需要做很多工作来渲染联系人列表。
         
         4. 使用Color Blended Layers选项调试程序
         屏幕中所有红色的部分都意味着字符标签视图的高级别混合，这很正常，因为我们把背景设置成了透明色来显示阴影效果。这就解释了为什么渲染利用率这么高了。
         
         5. 使用Color Offscreen–Rendered Yellow选项
         所有的表格单元内容都在离屏绘制。这一定是因为我们给图片和标签视图添加的阴影效果。在代码中禁用阴影，然后看下性能是否有提高
         
         6. 禁用阴影之后运行程序接近60FPS
         问题解决了。干掉阴影之后，滑动很流畅。但是我们的联系人列表看起来没有之前好了。那如何保持阴影效果而且不会影响性能呢？
         
         7. 每一行的字符和头像在每一帧刷新的时候并不需要变，所以看起来UITableViewCell的图层非常适合做缓存。我们可以使用shouldRasterize来缓存图层内容。这将会让图层离屏之后渲染一次然后把结果保存起来，直到下次利用的时候去更新
         
         8. Color Hits Green and Misses Red验证了缓存有效
         结果和预期一致 - 大部分都是绿色，只有当滑动到屏幕上的时候会闪烁成红色。因此，现在帧率更加平滑了。
         
         9. 所以我们最初的设想是错的。图片的加载并不是真正的瓶颈所在，而且试图把它置于一个复杂的多线程加载和缓存的实现都将是徒劳。所以在动手修复之前验证问题所在是个很好的习惯！
         */
        
        //优化处理
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
}





























