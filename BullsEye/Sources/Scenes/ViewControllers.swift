//
//  ViewControllers.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/03.
//

import UIKit

enum ViewControllers {
    case game(GameViewReactor)
    case record(RecordViewReactor)
}

extension ViewControllers: InstantiatableType {
    func instantiate() -> UIViewController {
        switch self {
        case .game(let reactor):
            let gameViewController = GameViewController()
            gameViewController.reactor = reactor
            return gameViewController
            
        case .record(let reactor):
            let recordViewController = RecordViewController()
            recordViewController.reactor = reactor
            return recordViewController
        }
    }
}
