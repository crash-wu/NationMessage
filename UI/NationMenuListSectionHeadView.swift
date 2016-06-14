//
//  NationMenuListSectionHeadView.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/16.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class NationMenuListSectionHeadView: UIView {

    var expendImageView :UIImageView?
    var listNameLb :UILabel?
    var line :UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        
        expendImageView = UIImageView()
        self.addSubview(expendImageView!)
        
        expendImageView?.snp_makeConstraints(closure: { (make) in
            
            make.left.equalTo(self.snp_left).offset(3)
            make.top.equalTo(self.snp_top).offset(5)
            make.bottom.equalTo(self.snp_bottom).offset(-5)
            make.width.equalTo(5)
        })
        
        
        listNameLb = UILabel()
        self.addSubview(listNameLb!)
        listNameLb?.snp_makeConstraints(closure: { (make) in
            
            make.left.equalTo(expendImageView!.snp_right).offset(0)
            make.height.equalTo(self.snp_height)
            make.width.equalTo(self.snp_width).offset(15)
            
        })
        
        listNameLb?.textAlignment = .Left
        listNameLb?.font = UIFont.systemFontOfSize(13)
        listNameLb?.textColor = UIColor.blackColor()
        
        line = UIView()
        self.addSubview(line!)
        line?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(self.snp_left).offset(5)
            make.right.equalTo(self.snp_right).offset(-5)
            make.top.equalTo(self.snp_bottom).offset(-1)
            make.height.equalTo(1)
        })
        
        line?.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
