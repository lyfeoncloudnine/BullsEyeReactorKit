//
//  GameViewController.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import UIKit

import ReactorKit
import RxSwift

final class GameViewController: BaseViewController, View {
    let mainView = GameView()
    
    var disposeBag = DisposeBag()
    
    override func configureViews() {
        super.configureViews()
        
        view = mainView
        
        navigationItem.setLeftBarButton(UIBarButtonItem(customView: mainView.playButton), animated: false)
        navigationItem.setRightBarButton(UIBarButtonItem(customView: mainView.listButton), animated: false)
    }
    
    func bind(reactor: GameViewReactor) {
        
    }
}
