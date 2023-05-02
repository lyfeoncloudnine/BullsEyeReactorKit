//
//  BaseTableViewCell.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import UIKit

class BaseTableViewCell: UITableViewCell, ReusableType {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureViews()
    }
    
    func configureViews() {
        // Overrde Point
    }
}
