//
//  ApiRequest.swift
//  MVVM-APIManager
//
//  Created by Ghoshit on 25/03/25.
//

import Foundation

protocol Request {
    var url: URL { get set }
}

public struct ApiPostRequest: Request {
    var url: URL
    var requestBody: Data?
    var requestParameters: [String: Any]?

    public init(withUrl: URL, requestBody: Data? = nil, requestParameters: [String: Any]? = nil) {
        self.url = withUrl

        if let parameters = requestParameters {
            self.requestBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        } else {
            self.requestBody = requestBody
        }
    }
}
