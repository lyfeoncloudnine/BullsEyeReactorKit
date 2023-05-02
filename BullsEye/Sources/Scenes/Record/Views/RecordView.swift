//
//  RecordView.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import UIKit

final class RecordView: BaseView {
    let headerView = RecordHeaderView()
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.reuseIdentifier)
        $0.delegate = self
    }
    
    override func configureViews() {
        super.configureViews()
        
        addSubviews(tableView)
        
        tableView.hook.all(to: self, safeAreaSides: [.top])
    }
}

extension RecordView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        systemLayoutSizeFitting(CGSize(width: tableView.frame.width, height: UIView.layoutFittingCompressedSize.height)).height
    }
}
