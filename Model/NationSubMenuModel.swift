//
//  NationSubMenuModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/12.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-05-12 17:05:12
 *
 *  @brief  国情专题二级菜单实体
 */
 class NationSubMenuModel: Mappable {
    
    var layerName :String? //图层名称
    var url :String? //图层WMS切片地址
    var menuName :String? //图层标题
    
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        
        layerName <- map["layerName"]
        url <- map["url"]
        menuName <- map["menuName"]
    }

}
