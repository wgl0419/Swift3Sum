//
//  GoodsDetailContainerController.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/2.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import YYSDK

// MARK: - 仿淘宝商品详情交互 使用 容器Vc
class GoodsDetailContainerController: UIViewController {

    // MARK: - Const
    let AnimationDuration = 0.5

    
    // MARK: - Property
    lazy var goodsViewController: GoodsDetailViewController = {
        let viewController = GoodsDetailViewController()
        return viewController
    }()
    
    lazy var graphicViewController: GoodsDetailGraphicViewController = {
        let viewController = GoodsDetailGraphicViewController()
        return viewController
    }()
    
    weak var visibleViewController: UIViewController!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContext()
    }
    
    // MARK: - Initialization
    
    func setupContext() {
        setupUI()
    }
    
    func setupUI() {
        title = "商品详情"
        showGoodsViewController()
    }

}

// MARK: - ChildViewController
extension GoodsDetailContainerController {
    func addGoodsViewController() {
        if goodsViewController.parent != nil {
            return
        }
        
        addChildViewController(goodsViewController, toSubView: true, fillSuperViewConstraint: false)
        goodsViewController.view.frame = view.bounds
        
        var config = YYRefreshConfig()
        config.textIdle = "上拉加载图文详情"
        config.textReady = "释放加载图文详情"
        config.parkVisible = false
        
        goodsViewController.tableView.addYYRefresh(position: .bottom, config: config) { [weak self] (refresh) in
            refresh.endRefresh()
            self?.showGrapicViewController()
        }
    }
    
    func addGraphicViewController() {
        if graphicViewController.parent != nil {
            return
        }
        
        addChildViewController(graphicViewController, toSubView: true, fillSuperViewConstraint: false)
        graphicViewController.view.frame = frameDown
        
        var config = YYRefreshConfig()
        config.textIdle = "下拉返回宝贝详情"
        config.textReady = "释放返回宝贝详情"
        config.parkVisible = false
        
        graphicViewController.tableView.addYYRefresh(position: .top, config: config) { [weak self] (refresh) in
            refresh.endRefresh()
            self?.showGoodsViewController()
        }
    }
}

// MARK: - Transition
extension GoodsDetailContainerController {
    
    var frameVisible: CGRect { return self.view.bounds }
    var frameUp: CGRect { return view.bounds.offsetBy(dx: 0, dy: -view.bounds.size.height) }
    var frameDown: CGRect { return view.bounds.offsetBy(dx: 0, dy: view.bounds.size.height) }
    
    func showGoodsViewController() {
        addGoodsViewController()
        
        graphicViewController.viewWillDisappear(true)
        goodsViewController.viewWillAppear(true)
        
        UIView.animate(withDuration: AnimationDuration, animations: {
            self.goodsViewController.view.frame = self.frameVisible
            self.graphicViewController.view.frame = self.frameDown
        }) { (_) in
            self.graphicViewController.viewDidDisappear(true)
            self.goodsViewController.viewDidAppear(true)
            self.graphicViewController.view.frame = self.frameDown
        }
    }
    
    func showGrapicViewController() {
        addGraphicViewController()
        
        graphicViewController.tableView.scrollToTop(animated: false)
        goodsViewController.viewWillDisappear(true)
        graphicViewController.viewWillAppear(true)
        
        UIView.animate(withDuration: AnimationDuration, animations: {
            self.graphicViewController.view.frame = self.frameVisible
            self.goodsViewController.view.frame = self.frameUp
        }) { (_) in
            self.goodsViewController.viewDidDisappear(true)
            self.graphicViewController.viewDidAppear(true)
            self.goodsViewController.view.frame = self.frameUp
        }
    }
    
    func updateGoodsDetailGraphicViewWithOffset(offset: CGFloat) {
//        if graphicViewController != nil  {
//            graphicViewController.view.frame = CGRectOffset(frameDown, 0, -offset)
//        }
    }
    
}









