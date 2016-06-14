//
//  NationMenuListModelView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/16.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class NationMenuListViewModel: NSObject {
    
    
    /**
     计算section中的row
     
     :param: data    数据源
     :param: section tableView 中的section索引
     
     :returns: 返回section 中的 row
     */
    func numberOfRowsInSection(data:NationMenuListModel?,section :Int) ->Int{
        var row = 0
        
        if data != nil {
            
            let subMenuModel  = data?.results![section]
            if subMenuModel != nil  {
                
                row = (subMenuModel?.layerList?.count)!
            }
        }
        
        return row
    }
    
    
    /**
     获取tableView Section的数量
     
     :param: data 数据源
     
     :returns: section数量
     */
    func numberOfSections(data:NationMenuListModel?) ->Int{
        
        var section = 0
        
        if data != nil {
            
            section = (data?.results?.count)!
        }
        
        
        return section
    }
    
    
    /**
     section headView 数据填充
     
     :param: headView section headView
     
     :param: data 数据源
     
     :param: section tableView section索引
     */
    func headViewOfSection(data:NationMenuListModel?,headView:NationMenuListSectionHeadView?,section :Int) ->Void{
    
        if data != nil {
            
            let resutls = data?.results![section]
            
            headView!.listNameLb?.text = resutls?.menuName
            
        }
    }
    
    
    /**
     单元格数据填充
     
     :param: data      数据源
     :param: indexPath 需要填充的单元格索引
     :param: cell      需要填充的单元格
     */
    func cellForRowAtIndexPath(data:NationMenuListModel? ,indexPath:NSIndexPath,cell:NationMenuListCell?) -> Void{
        
        if data != nil {
            
            let result = data?.results![indexPath.section]
            
            let subModel = result?.layerList![indexPath.row]
            
            cell?.label?.text = subModel?.menuName
            cell!.tag = indexPath.section * 1000 + indexPath.row
        }
        
    }
    
    
    /**
     单元格选中
     
     :param: data      数据源
     :param: indexPath 单元格索引
     :param: tableView 表格
     */
    func selectRowAtIndexPath(data:NationMenuListModel?,indexPath:NSIndexPath,tableView:SCMultipleTableView,selectDelegate:MenuListSelectDelegate?) ->Void{
        
        if data != nil{
            
            let result = data?.results![indexPath.section]
            
            let  subModel = result?.layerList![indexPath.row]
    
            //发送表格选择代理
            selectDelegate?.nationMenuListCellSelect(subModel)
            
        }
    }

}
