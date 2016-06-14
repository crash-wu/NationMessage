//
//  NationMenuListCell.swift
//  imapMobile
//
//  Created by 吴小星 on 16/5/16.
//  Copyright © 2016年 crash. All rights reserved.
//

import UIKit

class NationMenuListCell: UITableViewCell {
    
    var label: UILabel?
    var line :UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 0.9)
        
        label = UILabel()
        self.contentView.addSubview(label!)
        label?.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(self.snp_left).offset(10)
            make.height.equalTo(self.snp_height)
            make.width.equalTo(self.snp_width).offset(10)
            
        })
        
        label?.textAlignment = .Left
        label?.font = UIFont.systemFontOfSize(13)
        label?.textColor = UIColor.blackColor()
        
        line = UIView()
        self.insertSubview(line!, aboveSubview: label!)
        line?.snp_makeConstraints(closure: { (make) in
            
            make.top.equalTo(self.snp_bottom).offset(-0.5)
            make.height.equalTo(0.5)
            make.width.equalTo(self.snp_width)
        })
        line?.backgroundColor = UIColor.blackColor()

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
