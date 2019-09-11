//
//  TaskTableViewCell.swift
//  NetworkManager_Example
//
//  Created by Dima Senchik on 9/11/19.
//  Copyright © 2019 Dima Senchik. All rights reserved.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var isCompletedLabel: UILabel!
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Public methods
    func configureCell(with task: TodoDomainModel) {
        titleLabel.text = task.title
        isCompletedLabel.text = task.isCompleted ? "Yes":"No"
    }

}
