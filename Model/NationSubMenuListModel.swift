//
//  NationSubMenuListModel.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/12.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-05-12 17:05:32
 *
 *  @brief  国情专题一级菜单实体
 */
class NationSubMenuListModel: Mappable {
    
    var menuName :String?//一级菜单名称
    var layerList :Array<NationSubMenuModel>?//二级菜单实体
    
    required init?(_ map: Map) {
        mapping(map)
    }
    
    func mapping(map: Map) {
        
        menuName <- map["menuName"]
        layerList <- map["layerList"]
    }

}
