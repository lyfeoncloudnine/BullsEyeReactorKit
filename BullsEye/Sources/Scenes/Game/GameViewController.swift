//
//  GameViewController.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import UIKit

import ReactorKit
import RxCocoa
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
        // Action
        mainView.playButton.rx.tap
            .map { _ in Reactor.Action.play }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.listButton.rx.tap
            .map { _ in reactor.createRecordViewReactor() }
            .withUnretained(self)
            .subscribe(onNext: { weakSelf, reactor in
                weakSelf.pushRecordViewController(with: reactor)
            })
            .disposed(by: disposeBag)
        
        mainView.slider.rx.value
            .map { Reactor.Action.changeExpectNumber($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        mainView.checkButton.rx.tap
            .map { _ in Reactor.Action.check }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        let isPlaying = reactor.state.map { $0.isPlaying }.distinctUntilChanged().asDriver(onErrorJustReturn: false)
        isPlaying
            .drive(mainView.slider.rx.isEnabled)
            .disposed(by: disposeBag)
        
        isPlaying
            .drive(mainView.checkButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        isPlaying
            .map { !$0 }
            .drive(mainView.playButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { Float($0.expectNumber) }
            .distinctUntilChanged()
            .bind(to: mainView.slider.rx.value)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.round }
            .distinctUntilChanged()
            .map { "Round : \($0)" }
            .bind(to: mainView.roundLabel.rx.text)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.targetNumber }
            .distinctUntilChanged()
            .map { $0 == nil ? "??" : "\($0 ?? 0)" }
            .bind(to: mainView.targetNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Pulse
        reactor.pulse(\.$alertMessage)
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe(onNext: { weakSelf, message in
                weakSelf.presentAlert(message: message)
            })
            .disposed(by: disposeBag)
    }
}

private extension GameViewController {
    func presentAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default))
        present(alertController, animated: true)
    }
    
    func pushRecordViewController(with reactor: RecordViewReactor) {
        let recordViewController = RecordViewController()
        recordViewController.reactor = reactor
        navigationController?.pushViewController(recordViewController, animated: true)
    }
}
