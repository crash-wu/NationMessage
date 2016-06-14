//
//  NationRecordsListModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/11.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper


/**
 *  @author crash         crash_wu@163.com   , 16-05-11 10:05:20
 *
 *  @brief  天地图服务信息表格单元实体
 */
class NationRecordsListModel: Mappable {
    
    var id :String?
    var records :Array<String>?//表格单元内容数组 ，如 ： 天津 ｜ 001 ｜ 002 ｜003｜.....| 
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        records <- map["records"]
    }

}
