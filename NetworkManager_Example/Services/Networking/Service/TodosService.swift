//
//  TodosService.swift
//  NetworkManager_Example
//
//  Created by Dima Senchik on 9/11/19.
//  Copyright © 2019 Dima Senchik. All rights reserved.
//

import Foundation

final class TodosService {
    
    //MARK: - Public methods
    func getTodos(onSuccess: @escaping onSuccess<[TodoDomainModel]>, onFailure: @escaping onFailure<NetworkError>) {
        let request = RequestBuilder.build(.get, headersType: .typical, requestType: .getTodos)
        
        NetworkManager.shared.perform(request, onSuccess: { (data) in
            do {
                let apiResponse = try JSONDecoder().decode(TodoResponseDataModel.self, from: data)
                onSuccess(apiResponse.convertToDomain())
            } catch {
                onFailure(NetworkError(errorMessage: "NetworkErrors.incorrectContent", statusCode: 422))
            }
        }) { (error) in
            onFailure(error)
        }
    }
}
