//
//  NationCollectionViewCell.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/11.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class NationCollectionViewCell: UICollectionViewCell {
    
    var textLb :UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLb = UILabel(frame:CGRectMake(0, 0,frame.width, frame.height) )
        textLb?.textAlignment = .Center
        textLb?.textColor = UIColor.grayColor()
        textLb?.font = UIFont.systemFontOfSize(13)
        
        self.contentView.addSubview(textLb!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    
}
