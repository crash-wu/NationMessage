//
//  NationMessageModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/11.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper


/**
 *  @author crash         crash_wu@163.com   , 16-05-11 09:05:52
 *
 *  @brief  天地图服务专题统计表格数据实体
 */
class NationMessageModel: NSObject , Mappable {
    
    
    var colNum : Int? //表格列数
    var headList :Array<NationHeadListModel>? //表格头部实体(表格第一列标题实体)
    var recordsList :Array<NationRecordsListModel>? //表格单元内容
    var subjectCode :String? //图层名称 ,如: 060101
    var curPageNum : Int? //保存数据页数,判断是否需要请求统计数据使用,但请求页面>保存数据页码时，才发生请求
    
    required init?(_ map: Map) {
        
       // mapping(map)
        super.init()
    }
    
    
    func mapping(map: Map) {
        
        colNum <- map["colNum"]
        headList <- map["headList"]
        recordsList <- map["recordsList"]
        subjectCode <- map["subjectCode"]
        curPageNum <- map["curPageNum"]
    }

}
