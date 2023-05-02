//
//  RecordTableViewCell.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import UIKit

import Hook
import Then

final class RecordTableViewCell: BaseTableViewCell {
    private let targetNumbereLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    private let scoreLabel = UILabel().then {
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    override func configureViews() {
        super.configureViews()
        
        contentView.addSubviews(targetNumbereLabel, scoreLabel)
        
        targetNumbereLabel.hook
            .top(equalTo: contentView.topAnchor, constant: 8)
            .leading(equalTo: contentView.leadingAnchor, constant: 8)
            .bottom(equalTo: contentView.bottomAnchor, constant: -8)
            
        scoreLabel.hook
            .top(equalTo: targetNumbereLabel.topAnchor)
            .trailing(equalTo: trailingAnchor, constant: -8)
            .bottom(equalTo: targetNumbereLabel.bottomAnchor)
    }
}

extension RecordTableViewCell {
    func configure(with record: Record) {
        targetNumbereLabel.text = "\(record.targetNumber)"
        scoreLabel.text = "\(record.score)"
    }
}
