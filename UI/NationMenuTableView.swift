//
//  NationMenuTableView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/13.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit


/**
 *  @author crash         crash_wu@163.com   , 16-05-18 09:05:43
 *
 *  @brief  单元格cell选中代理
 */
protocol MenuListSelectDelegate :NSObjectProtocol{
    
    /**
     单元格选中
     
     :param: model 数据源
     
     :returns:
     */
   func nationMenuListCellSelect(model:NationSubMenuModel?) ->Void
    
}

class NationMenuTableView: UIViewController ,SCMultipleTableDelegate{

    
    var tableView : SCMultipleTableView?
    var data :NationMenuListModel?
    var selectDelegate :MenuListSelectDelegate?
    
    override func viewDidLoad(){
        
        super.viewDidLoad()
        tableView = SCMultipleTableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: .Plain)
        tableView?.multipleDelegate = self
        tableView?.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//        tableView?.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(tableView!)
        
        //获取国情专题列表
        NationNetworkRequest().getNationMenuListRequest("03d993af-ade2-4984-bd7f-ae0bc618b08b", success: { [weak self](model) in
            
            self?.data = model
            self!.tableView?.reload()
            
        }) {
            
        }
        
    }

    
    //.=======================================//
    // Mark :SCMultipleTableViewDelegate      //
    //=======================================//
    
     func m_tableView(tableView: SCMultipleTableView, numberOfRowsInSection section: Int) -> Int {
        
        return NationMenuListViewModel().numberOfRowsInSection(data, section: section)
    }
    
    func  numberOfSectionsInSCMutlipleTableView(tableView: SCMultipleTableView) -> Int {
        
        return NationMenuListViewModel().numberOfSections(data)
    }
    
    func m_tableView(tableView: SCMultipleTableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    
    func m_tableView(tableView: SCMultipleTableView, heightForFootInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func m_tableView(tableView: SCMultipleTableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let  headView = NationMenuListSectionHeadView()
        
        NationMenuListViewModel().headViewOfSection(data, headView: headView, section: section)
        
        return headView
    }
    
    func m_tableView(tableView: SCMultipleTableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell? {
        
        let cellId = "cellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as! NationMenuListCell!
        
        if (cell == nil) {
            
            cell = NationMenuListCell(style: .Default, reuseIdentifier: cellId)
        }
        
        NationMenuListViewModel().cellForRowAtIndexPath(data, indexPath: indexPath, cell: cell)
        
        return cell
        
    }
    
    
    func m_tableView(tableView: SCMultipleTableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        NationMenuListViewModel().selectRowAtIndexPath(data, indexPath: indexPath, tableView: tableView, selectDelegate: selectDelegate)

    }
    
}
