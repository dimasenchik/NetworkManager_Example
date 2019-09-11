//
//  TodoResponseModel.swift
//  NetworkManager_Example
//
//  Created by Dima Senchik on 9/11/19.
//  Copyright © 2019 Dima Senchik. All rights reserved.
//

import Foundation

//MARK: - TodoResponseDataModel
typealias TodoResponseDataModel = [TodoResponseElementModel]

extension TodoResponseDataModel {
    func convertToDomain() -> [TodoDomainModel] {
        var availableTasks: [TodoDomainModel] = []
        self.forEach { (task) in
            let domainModel = TodoDomainModel(title: task.title, isCompleted: task.completed)
            availableTasks.append(domainModel)
        }
        return availableTasks
    }
}

//MARK: - TodoResponseElementModel
struct TodoResponseElementModel: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool
    
    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
    
    func convertToDomain() -> TodoDomainModel {
        let domainModel = TodoDomainModel(title: title, isCompleted: completed)
        return domainModel
    }

}
