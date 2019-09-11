//
//  ViewController.swift
//  NetworkManager_Example
//
//  Created by Dima Senchik on 9/10/19.
//  Copyright © 2019 Dima Senchik. All rights reserved.
//

import UIKit

final class TodoListViewController: UIViewController, Alertable {

    //MARK: - IBOutlets
    @IBOutlet weak private var tasksTableView: UITableView!
    
    //MARK: - Properties
    private let todoListModel = TodoListModel()
    private var availableTasks: [TodoDomainModel] = [] {
        didSet {
            tasksTableView.reloadData()
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getAvailableTasks()
    }
    
    //MARK: - Private methods
    private func setupTableView() {
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
    }
    
    private func getAvailableTasks() {
        todoListModel.getTasks(onSuccess: { [weak self] (tasks) in
            self?.availableTasks = tasks
        }) { [weak self] (error) in
            self?.displayError(error.message)
        }
    }

}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.configureCell(with: availableTasks[indexPath.row])
        return cell
    }
}
