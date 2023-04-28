//
//  GameView.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import UIKit

import Hook
import Then

final class GameView: BaseView {
    let playButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    let listButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "trophy.fill"), for: .normal)
    }
    
    let roundLabel = UILabel().then {
        $0.text = "Round : 1"
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    let targetNumberDescLabel = UILabel().then {
        $0.text = "내가 맞춰야할 점수는..."
        $0.font = .preferredFont(forTextStyle: .body)
    }
    
    let targetNumberLabel = UILabel().then {
        $0.text = "??"
        $0.font = .preferredFont(forTextStyle: .largeTitle)
    }
    
    let slider: UISlider = UISlider().then {
        $0.minimumValue = 1
        $0.maximumValue = 1
    }
    
    let minNumberLabel = UILabel().then {
        $0.text = "1"
        $0.font = .preferredFont(forTextStyle: .caption1)
    }
    
    let maxNumberLabel = UILabel().then {
        $0.text = "100"
        $0.font = .preferredFont(forTextStyle: .caption1)
    }
    
    let checkButton = UIButton(type: .system).then {
        $0.setTitle("내 감각 체크해보기", for: .normal)
    }
    
    override func configureViews() {
        super.configureViews()
        
        addSubviews(roundLabel, targetNumberDescLabel, targetNumberLabel, slider, minNumberLabel, maxNumberLabel, checkButton)
        
        roundLabel.hook
            .top(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8)
            .leading(equalTo: leadingAnchor, constant: 8)
        
        targetNumberDescLabel.hook
            .bottom(equalTo: targetNumberLabel.topAnchor, constant: -8)
            .centerX(to: centerXAnchor)
        
        targetNumberLabel.hook
            .bottom(equalTo: slider.topAnchor, constant: -16)
            .centerX(to: centerXAnchor)
        
        slider.hook
            .leading(equalTo: leadingAnchor, constant: 16)
            .trailing(equalTo: trailingAnchor, constant: -16)
            .centerY(to: centerYAnchor)
        
        minNumberLabel.hook
            .top(equalTo: slider.bottomAnchor, constant: 8)
            .leading(equalTo: slider.leadingAnchor)
        
        maxNumberLabel.hook
            .top(equalTo: slider.bottomAnchor, constant: 8)
            .trailing(equalTo: slider.trailingAnchor)
        
        checkButton.hook
            .top(equalTo: slider.bottomAnchor, constant: 56)
            .centerX(to: centerXAnchor)
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct GameView_Preview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let view = GameView()
            return view
        }
        .previewLayout(.device)
    }
}
#endif
