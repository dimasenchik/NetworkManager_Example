//
//  TodoListModel.swift
//  NetworkManager_Example
//
//  Created by Dima Senchik on 9/11/19.
//  Copyright © 2019 Dima Senchik. All rights reserved.
//

import Foundation

final class TodoListModel {
    
    //MARK: - Properties
    private let todosService = TodosService()
    
    //MARK: - Public methods
    func getTasks(onSuccess: @escaping onSuccess<[TodoDomainModel]>, onFailure: @escaping onFailure<NetworkError>) {
        todosService.getTodos(onSuccess: { (tasks) in
            DispatchQueue.main.async {
                onSuccess(tasks)
            }
        }) { (error) in
            DispatchQueue.main.async {
                onFailure(error)
            }
        }
    }
}
