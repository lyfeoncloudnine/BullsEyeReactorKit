//
//  RecordView.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import UIKit

final class RecordView: BaseView {
    let editButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "pencil"), for: .normal)
    }
    
    let tableView = UITableView().then {
        $0.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.reuseIdentifier)
        $0.separatorStyle = .none
    }
    
    override func configureViews() {
        super.configureViews()
        
        addSubviews(tableView)
        
        tableView.hook.all(to: self, safeAreaSides: [.top])
    }
}
