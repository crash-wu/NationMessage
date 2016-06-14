//
//  NationHeadListModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/11.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-05-11 09:05:19
 *
 *  @brief  表格头部信息(表格第一列标题)
 */
class NationHeadListModel: Mappable {

    var id :String? //
    var text :String? //名称
    var seachType1 :String?
    var seach1 :String?
    var seachNum :String?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        text <- map["text"]
        seachType1 <- map["seachType1"]
        seach1 <- map["seach1"]
        seachNum <- map["seachNum"]
        
    }
}
