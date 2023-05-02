//
//  RecordHeaderView.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import UIKit

import Hook
import Then

final class RecordHeaderView: BaseView {
    private let targetNumberDescLabel = UILabel().then {
        $0.text = "맞춘 숫자"
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    private let scoreDescLabel = UILabel().then {
        $0.text = "점수"
        $0.font = .preferredFont(forTextStyle: .title3)
    }
    
    override func configureViews() {
        backgroundColor = .lightGray
        
        addSubviews(targetNumberDescLabel, scoreDescLabel)
        
        targetNumberDescLabel.hook
            .top(equalTo: topAnchor, constant: 8)
            .leading(equalTo: leadingAnchor, constant: 8)
            .bottom(equalTo: bottomAnchor, constant: -8)
        
        scoreDescLabel.hook
            .top(equalTo: targetNumberDescLabel.topAnchor)
            .trailing(equalTo: trailingAnchor, constant: -8)
            .bottom(equalTo: targetNumberDescLabel.bottomAnchor)
    }
}
