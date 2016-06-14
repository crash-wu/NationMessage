//
//  NationMenuListModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/12.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-05-12 17:05:59
 *
 *  @brief  国情专题菜单列表实体
 */
class NationMenuListModel: NSObject,Mappable {
    
    var code :Int? //状态标准
    var results :Array<NationSubMenuListModel>?//菜单数据
    
    required init?(_ map: Map) {
        
        super.init()
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        results <- map["results"]
    }

}
