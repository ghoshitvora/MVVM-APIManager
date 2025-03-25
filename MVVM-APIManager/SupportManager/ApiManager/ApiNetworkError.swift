//
//  ApiNetworkError.swift
//  MVVM-APIManager
//
//  Created by Ghoshit on 25/03/25.
//

import Foundation

struct ApiNetworkError : Error {
    let reason: String?
    let httpStatusCode: Int?
    let requestUrl: URL?
    let requestBody: String?
    let serverResponse: String?

    init(serverResponse: Data? = nil, requestUrl: URL, httpBody: Data? = nil, message: String, statusCode: Int) {
        self.serverResponse = serverResponse != nil ? String(data: serverResponse!, encoding: .utf8) : nil
        self.requestUrl = requestUrl
        self.requestBody = httpBody != nil ? String(data: httpBody!, encoding: .utf8) : nil
        self.httpStatusCode = statusCode
        self.reason = message
    }
}
