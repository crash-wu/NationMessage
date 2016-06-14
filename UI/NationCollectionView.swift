//
//  NationCollectionView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/11.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class NationCollectionView: UIView ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    var collectView : UICollectionView?
    var layout :UICollectionViewFlowLayout?
    private let cellId = "nationcellID"
    var model : NationMessageModel?
    var curPageNum :Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout = UICollectionViewFlowLayout()
        collectView = UICollectionView(frame: CGRectMake(0, 0, self.frame.width, self.frame.height), collectionViewLayout: layout!)
        
        //设置垂直滚动方向
        collectView?.scrollEnabled = true
        collectView?.showsVerticalScrollIndicator = true
        
        //设置代理
        collectView?.dataSource = self
        collectView?.delegate = self

        collectView?.backgroundColor = UIColor.whiteColor()
        //注册UICollectionCell
        collectView?.registerClass(NationCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        self.addSubview(collectView!)
        
        curPageNum = 1


        //=======================================//
        //          Mark : 数据请求                 //
        //=======================================//
        NationNetworkRequest().getNationStatisticsRequest("060101", curPageNum: curPageNum!, success: {[weak self] (model) in
            
                //请求成功
                self?.model = model
            
                //在主线程中刷新UI
                dispatch_async(dispatch_get_main_queue(), {
                    self?.collectView?.reloadData()
                
                })
            
            }) {
                //请求失败
                
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError()
    }
    
    //=======================================//
    //          Mark :dateSouceDelegate          //
    //=======================================//
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return NationMessageViewModel().numberOfItemsInSection(model)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return NationMessageViewModel().numberOfSectionsInCollectionView(model)
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! NationCollectionViewCell
        if model != nil {
            
            NationMessageViewModel().cellItemIndexPath(indexPath, cell: cell, model: model!)
        }        
        return cell
    }
    
    //=======================================//
    //          Mark :UICollectionDelegateFlowLayout          //
    //=======================================//
    
    //设置每个item的尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        return NationMessageViewModel().sizeForItemAtIndexPath(model, collectionView: collectionView)
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        
        
        return UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
    }
    

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 0
    }

}
