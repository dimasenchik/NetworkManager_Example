//
//  ZhukEndPoint.swift
//  EvoZhuk
//
//  Created by Dima Senchik on 7/7/19.
//  Copyright © 2019 Dima Senchik. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case test
    case production
    
    var basePath: String {
        switch self {
        case .test:
            return "https://jsonplaceholder.typicode.com"
        case .production:
            return "https://jsonplaceholder.typicode.com"
        }
    }
}

final class RequestBuilder {

    enum RequestPath {
        case getTodos
        
        var path: String {
            switch self {
            case .getTodos:
                return "/todos"
            }
        }
    }

    enum HeadersType {
        case typical
        case custom
    }
    
    static func build(_ httpMethod: HTTPMethod = .get , baseUrl: String = NetworkConfiguration.baseEnvironment.basePath, headersType: HeadersType, body: Any? = nil, queryItems: String? = nil, requestType: RequestPath) -> URLRequest {
        var configuredURL = URL(string: "\(baseUrl)\(requestType.path)")
        
        if let queryString = queryItems {
            configuredURL = URL(string: "\(baseUrl)\(requestType.path)?\(queryString)")
        }
        
        var httpBody: Data? = nil
        
        if let requestURL = configuredURL {
            if body != nil {
                httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            }
            
            var request = URLRequest(url: requestURL)
            configureRequestHeaders(type: headersType, request: &request)
            request.httpMethod = httpMethod.rawValue
            request.httpBody = httpBody
            
            return request
        }
        
        return URLRequest(url: URL(string: "")!)
    }
}

// MARK: - Private methods
private extension RequestBuilder {
    static func configureRequestHeaders(type: HeadersType, request: inout URLRequest) {
        switch type {
        case .typical:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .custom:
            request.setValue("Custom field", forHTTPHeaderField: "http header field")
        }
    }
}
