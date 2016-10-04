//
//  GoodsDetailController.swift
//  SwiftSum
//
//  Created by sihuan on 16/4/25.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit
import YYSDK

class GoodsDetailViewController: UIViewController {

    // MARK: - Const
    
    let HeightForCommonCell = 49
    let CellIdentifier = "CellIdentifier"
    
    // MARK: - Property
    
    var dataArray = [YYRenderableCellModel]()
    lazy var tableView: YYRenderableTableView = {
       let tableView = YYRenderableTableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.backgroundColor = UIColor.white
        tableView.clearExtraCellLine()
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContext()
    }
    
    
    // MARK: - Override
    
    
    // MARK: - Initialization
    
    func setupContext() {
        setupUI()
        requestData()
    }
    
    func setupUI() {
        self.title = "商品详情"
        self.extendedLayoutNone()
        self.view.addSubview(tableView)
        tableView.addConstraintFillSuperView()
    }
    
    // MARK: - Network
    
    func requestData() {
        requestData(append: false)
    }
    
    func requestData(append: Bool) {
        let dataArray = ["test1test1test1test1test1test1test1test1test1", "dddddd", "test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1test1", "test2", "test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2test2", "test2", "test2", "test2", "test2", "test2", "test2", "test2", "test2", "test2",]
        
        self.dataArray.append(DemoCellModel2(text: "DemoCellModel2"))
        
        for str in dataArray {
            self.dataArray.append(DemoCellModel(text: str))
        }
        renderUI()
    }
    
    // MARK: - Private
    
    func renderUI() {
        tableView.dataArray = dataArray
        tableView.reloadData()
    }
    
    // MARK: - Public
    
    
    // MARK: - Delegate
    
}

extension GoodsDetailViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}













