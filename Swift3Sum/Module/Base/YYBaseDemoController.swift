//
//  YYBaseDemoController.swift
//  SwiftSum
//
//  Created by sihuan on 15/11/3.
//  Copyright © 2015年 sihuan. All rights reserved.
//

import UIKit

// MARK: - demoController的模型
struct LibDemoInfo {
    var title: String?
    var desc: String?
    var controllerName: String?
    
    init(title:String, desc:String, controllerName:String) {
        self.title = title;
        self.desc = desc;
        self.controllerName = controllerName;
    }
}

// MARK: - 显示demoController列表的模板

class YYBaseDemoController: UITableViewController {

    let cellIdentifier = "reuseIdentifier"
    var dataArray = [LibDemoInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.rowHeight = 60;
        
        let footerView = UIView();
        footerView.backgroundColor = UIColor.clear();
        self.tableView.tableFooterView = footerView;
    }

    // MARK: - UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let item = dataArray[indexPath.row]
        cell?.accessoryType = item.controllerName != nil ? UITableViewCellAccessoryType.disclosureIndicator : UITableViewCellAccessoryType.none;
        cell?.textLabel?.text = item.title
        cell?.detailTextLabel?.text = item.desc
        return cell!
    }

    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = dataArray[indexPath.row]
        if let controllerName = item.controllerName  {
            if let vc = getInstanceFrom(className: controllerName) as? UIViewController {
                vc.title = item.title
                vc.view.backgroundColor = UIColor.white()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
