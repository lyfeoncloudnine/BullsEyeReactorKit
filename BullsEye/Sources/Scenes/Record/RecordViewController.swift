//
//  RecordViewController.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import UIKit

import ReactorKit

final class RecordViewController: BaseViewController, View {
    let mainView = RecordView()
    
    var disposeBag = DisposeBag()
    
    override func configureViews() {
        super.configureViews()
        
        view = mainView
    }
    
    func bind(reactor: RecordViewReactor) {
        // Action
        Observable.just(())
            .map { Reactor.Action.load }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.records }
            .distinctUntilChanged()
            .bind(to: mainView.tableView.rx.items(cellIdentifier: RecordTableViewCell.reuseIdentifier, cellType: RecordTableViewCell.self)) { _, record, cell in
                cell.configure(with: record)
            }
            .disposed(by: disposeBag)
    }
}
