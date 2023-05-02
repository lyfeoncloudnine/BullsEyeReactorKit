//
//  RecordViewController.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import UIKit

import ReactorKit
import RxDataSources

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
        
        mainView.tableView.rx.modelDeleted(Record.self)
            .map { Reactor.Action.delete($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.sectionOfRecords }
            .bind(to: mainView.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.title }
            .distinctUntilChanged()
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}

private extension RecordViewController {
    var dataSource: RxTableViewSectionedAnimatedDataSource<SectionOfRecords> {
        .init(
            animationConfiguration: .init(),
            configureCell: { dataSource, tableView, indexPath, record in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.reuseIdentifier, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
                cell.configure(with: record)
                return cell
            },
            canEditRowAtIndexPath: { _, _ in
                return true
            }
        )
    }
}
