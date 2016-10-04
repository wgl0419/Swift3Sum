//
//  GoodsDetailViewController.swift
//  SwiftSum
//
//  Created by sihuan on 16/4/25.
//  Copyright © 2016年 sihuan. All rights reserved.
//

import UIKit

class GoodsDetailGraphicViewController: UIViewController {

    // MARK: - Const
    
    let HeightForCommonCell = 49
    let CellIdentifier = "CellIdentifier"
    
    // MARK: - Property
    var dataArray = [String]()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.clearExtraCellLine()
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.CellIdentifier)
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContext()
    }
    
   
    
    // MARK: - Override
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
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
        dataArray = ["test1", "test2", "test2", "test2", ];
        renderUI()
    }
    
    // MARK: - Private
    
    func renderUI() {
        tableView.reloadData()
    }
    
    // MARK: - Public
    
    
    // MARK: - Delegate
    
}

extension GoodsDetailGraphicViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

