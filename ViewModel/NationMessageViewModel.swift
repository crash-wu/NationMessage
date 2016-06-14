//
//  NationMessageViewModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/12.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class NationMessageViewModel: NSObject {
    
    /**
     表格数据填充
     
     :param: indexPath 单元格索引
     :param: cell      需要填充数据的单元格
     :param: model     表格数据源
     */
    func cellItemIndexPath(indexPath:NSIndexPath,cell:NationCollectionViewCell,model:NationMessageModel) -> Void {
        
        let headList = model.headList as [NationHeadListModel]!
        let recordsList = model.recordsList as [NationRecordsListModel]!
        if indexPath.section == 0{
            //表头行
            if headList.count > 0 {
                
                cell.textLb?.text = headList[indexPath.row].text
            }
            
        }else{
            
            if recordsList.count > 0 {
                
                let records = recordsList[indexPath.section - 1].records
                cell.textLb?.text = records![indexPath.row]
                
            }
        }

    }
    
    /**
     获取表格行数 section数量
     
     :param: model 数据源
     
     :returns: section 数量
     */
    func numberOfSectionsInCollectionView(model :NationMessageModel?) -> Int{
        
        if model != nil {
            
            let recordsList = model!.recordsList as [NationRecordsListModel]!
            
            if recordsList.count > 0 {
                return recordsList.count + 1
            }
            
        }

        return 0
    }
    
    
    /**
     计算每行的列数
     
     :param: model 数据源
     
     :returns: 每行列数
     */
    func numberOfItemsInSection(model:NationMessageModel?) ->Int{
        
        if model != nil {
            
            let headList = model!.headList as [NationHeadListModel]!

            return headList.count
            
        }
        return 0
    }
    
    
    
    /**
     计算每个Item的尺寸(列的尺寸)
     
     :param: model          数据源
     :param: collectionView 表格
     
     :returns: 尺寸
     */
    func sizeForItemAtIndexPath(model:NationMessageModel?,collectionView: UICollectionView) ->CGSize{
        
        if model != nil {
            
            let headList = model!.headList as [NationHeadListModel]!
            
            return CGSizeMake(collectionView.frame.width / CGFloat(headList.count) , 40)
            
        }
        return CGSizeMake(0, 0)
    }
}
