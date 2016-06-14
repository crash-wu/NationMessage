//
//  NationNetworkRequest.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/11.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 *  @author crash         crash_wu@163.com   , 16-05-11 10:05:27
 *
 *  @brief  天地图专题统计数据请求接口
 */
class NationNetworkRequest: NSObject {

    /**
     获取天地图专题服务统计数据
     
     :param: subjectCode 图层名称
     :param: curPageNum  请求页码
     :param: success     请求成功闭包
     */
    func getNationStatisticsRequest(subjectCode:String ,curPageNum:Int,success:(model :NationMessageModel)->Void,fail:()->Void){
        
        //获取保存在沙盒中的统计表数据
        var saveModel = NationFileManager().getNationStatistics(subjectCode)
        
        //判断是否需要请求数据
        if saveModel == nil || saveModel?.curPageNum < curPageNum {
            //如果当前请求的页数 大于保存在沙盒中的数据页,则需要重新请求数据
            
            let dictionary = ["subjectCode" : subjectCode ,"page":["curPageNum":curPageNum]]
            
            var  json = toJSONString(dictionary)
            
            json = json.stringByReplacingOccurrencesOfString("\n ", withString: "")
            json = json.stringByReplacingOccurrencesOfString("\n", withString: "")
            var urls = "http://zhfw.tianditu.com/attrGrid.shtml?record=" + json
            urls = urls.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            let url = NSURL(string: urls)
            
            if (url != nil){
                
                NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
                    
                    //请求失败
                    if (error != nil) {
                        
                        fail()
                    }
                    
                    //判断返回值是否为空
                    if (data?.length > 0 || (data != nil )){
                        
                        //如果不为空
                        if ((data?.isKindOfClass(NSData)) != nil){
                            //转化成json字符串
                            let json = String(data: data!, encoding: NSUTF8StringEncoding)
                            
                            let model = Mapper<NationMessageModel>().map(json)
                            //记录请求页码
                            model?.curPageNum = curPageNum
                            //保存数据
                            NationFileManager().saveNationStatistics(subjectCode, model: model!)
                            
                            if saveModel == nil{
                                saveModel = model
                            }else{
                               
                                //往表未添加数据
                                for list in (model!.recordsList!){
                                    saveModel?.recordsList?.append(list)
                                }
                            }


                            success(model: saveModel!)
                        }
                    }
                    else{
                        //如果为空
                        fail()
                    }
                    }.resume()
            }
        }else{
            //不需要重新请求
            success(model: saveModel!)
        }

    }
    
    
    
    /**
     获取国情专题菜单
     
     :param: menuId  菜单ID
     :param: success 获取数据成功闭包
     */
    func getNationMenuListRequest(menuId:String,success:(model:NationMenuListModel)->Void,fail:()->Void) -> Void{
        
        let model = NationFileManager().getNationMenuListFromCache()
        
        //判断是否已经保存到数据
        if model == nil {
            //如果数据为空
            
            var urlt = NationRequstHost.nationRequstHost + "/mobile_config/api/appMenu/findAppBMenu.do?menuId=" + menuId
            urlt = urlt.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            
            let urlS = NSURL(string: urlt)
            
            NSURLSession.sharedSession().dataTaskWithURL(urlS!, completionHandler: { (data, response, erro) in
                
                if erro != nil{
                    
                    fail()
                }
                
                if data != nil || data?.length > 0{
                    
                    let json = String(data: data!, encoding: NSUTF8StringEncoding)
                    
                    let model = Mapper<NationMenuListModel>().map(json)
                    
                    if model != nil && model?.code == 200{
                        
                        //保存数据
                        NationFileManager().saveNationMenuListToCache(model!)
                        success(model: model!)
                        
                    }else{
                        
                        fail()
                    }
                    
                }else{
                    
                    fail()
                }
                
                
            }).resume()
        }else{
            
            success(model: model!)
        }
    }
    
    /**
     将字典转化JSOn 字符串
     
     :param: dictionary 需要转化的字典
     
     :returns: JSON字符串
     */
    func toJSONString(dictionary:NSDictionary)->String{
        
        var string :String!
        do{
            
            let data = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted) 
            
            string = String(data: data, encoding: NSUTF8StringEncoding)
            
        }catch{}
        return string
    }
    
}
