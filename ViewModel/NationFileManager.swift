//
//  NationFileManager.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/12.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-05-12 09:05:13
 *
 *  @brief  文件操作
 */
class NationFileManager: NSObject  {

    
    /**
     获取数据保存路径
     
     :param: subjectCode 文件名称
     
     :returns: 返回保存路径
     */
    func getNationCachePlist(subjectCode:String) ->String {
        
        let paths =  NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        
        let   cacheDirectory  = NSURL(string: paths[0])?.URLByAppendingPathComponent(subjectCode + ".plist")
        return cacheDirectory!.absoluteString
    }
    
    
    
    //.=======================================//
    //          Mark :国情专题服务统计数据          //
    //=======================================//
    
    /**
     保存天地图服务专题统计表格数据
     
     :param: subjectCode 图层名称
     :param: model  统计表数据实体
     */
    func saveNationStatistics(subjectCode:String,model:NationMessageModel) ->Void{
        
        dispatch_async(dispatch_queue_create("saveNationModelToFile", DISPATCH_QUEUE_SERIAL)) {
            
            //获取图层统计表数据保存路径
            let path = self.getNationCachePlist(subjectCode)
            
            //创建文件
            let fileManager = NSFileManager.defaultManager()
            
            //判断图层统计表是否存在文件目录中
            if fileManager.fileExistsAtPath(path) {
                //如果存在,则读取文件中的数据
                do{
                    
                    let json = try NSString.init(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                    
                    //判断是否保存到数据
                    if json.length > 0  {
                        //如果数据不为空
                        let existModel = Mapper<NationMessageModel>().map(json)
                        //往表未添加数据
                        for list in (model.recordsList!){
                            existModel?.recordsList?.append(list)
                        }
                        //写入文件
                        self.writeModelToFile(existModel!, path: path)

                        
                    }else{
                        //如果数据为空
                        self.writeModelToFile(model, path: path)
                        
                    }
                    
                }catch{}
                
                
            }else{
                //如果不存在,则创建
                if fileManager.createFileAtPath(path, contents: nil, attributes: nil) {
                    
                    //将数据写入文件
                   self.writeModelToFile(model, path: path)

                }
            }
        }
    }
    
    /**
     获取保存统计表数据
     
     :param: subjectCode 图层名称
     
     :returns: 天地图服务专题统计实体
     */
    func getNationStatistics(subjectCode:String) ->NationMessageModel?{
        
        var model :NationMessageModel?
        //获取图层统计表数据保存路径
        let path = self.getNationCachePlist(subjectCode)
            
        //创建文件
        let fileManager = NSFileManager.defaultManager()
            
        //判断文件是否存在
        if fileManager.fileExistsAtPath(path){
            //如果存在
            do{
                let json = try NSString.init(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                    
                //判断是否保存到数据
                if json.length > 0  {
                    //如果数据不为空
                    let existModel = Mapper<NationMessageModel>().map(json)
                    model = existModel
                }
                    
            }catch{}
                
        }
        return model
    }
    
    /**
     将实体写入到文件
     
     :param: model 天地图服务统计实体
     :param: path  文件路径
     :return 返回写入状态
     */
    func writeModelToFile(model:NationMessageModel,path:NSString) ->Bool{
        
        let json = Mapper().toJSONString(model, prettyPrint: true)
        do{
            
            try json?.writeToFile(path as String, atomically: true, encoding: NSUTF8StringEncoding)
            return true
            
        }catch{}
        
        return false
    }
    
    
    
    //=======================================//
    //          Mark : 国情专题菜单          //
    //=======================================//
    
    /**
     获取保存在沙盒中的国情专题菜单列表数据
     
     :returns: 国情专题菜单列表实体
     */
    func getNationMenuListFromCache()-> NationMenuListModel?{
        
        
        var model :NationMenuListModel?
        //获取数据保存路径
        let path = self.getNationCachePlist("NationMenuList")
        
        //创建文件
        let fileManager = NSFileManager.defaultManager()
        
        //判断文件是否存在
        if fileManager.fileExistsAtPath(path){
            //如果存在
            do{
                
                let json = try NSString.init(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                //判断是否保存到数据
                if json.length > 0  {
                    //如果数据不为空
                    let existModel = Mapper<NationMenuListModel>().map(json)
                    model = existModel
                }
                
            }catch{}
            
        }
        return model
    }
    
    
    /**
     保存国情专题菜单列表
     
     :param: model 国情专题菜单列表数据实体
     */
    func saveNationMenuListToCache(model:NationMenuListModel) ->Void{
        
        dispatch_async(dispatch_queue_create("saveNationMenuModelToFile", DISPATCH_QUEUE_SERIAL)) {
            
            //获取图层统计表数据保存路径
            let path = self.getNationCachePlist("NationMenuList")
            
            //创建文件
            let fileManager = NSFileManager.defaultManager()
            
            if fileManager.createFileAtPath(path, contents: nil, attributes: nil) {
                    //写入文件
                self.writeNationMenuModelToFile(model, path: path)

            }
       }
    }
    
    
    /**
     将国情专题菜单列表实体写入到文件
     
     :param: model 国情专题菜单列表
     :param: path  文件路径
     :return 返回写入状态
     */
    func writeNationMenuModelToFile(model:NationMenuListModel,path:NSString) ->Bool{
        
        let json = Mapper().toJSONString(model, prettyPrint: true)
        do{
            
            try json?.writeToFile(path as String, atomically: true, encoding: NSUTF8StringEncoding)
            return true
            
        }catch{}
        
        return false
    }


}
