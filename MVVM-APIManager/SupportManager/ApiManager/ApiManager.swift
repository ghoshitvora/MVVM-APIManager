//
//  ApiManager.swift
//  MVVM-APIManager
//
//  Created by Ghoshit.
//

import Foundation
import UIKit

class ApiManager {
    
    // MARK: - Variable(s)
    
    static let shared = ApiManager()
    
    // MARK: - Init Method
    
    private init() {}
    
    // MARK: - APIS Method
    
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Result<T?, ApiNetworkError>)-> Void) {
        
        var urlRequest = self.createApiUrlRequestWithHeader(requestUrl: requestUrl)
        urlRequest.httpMethod = "GET"
        
        self.performApiOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }
    
    func postData<T:Decodable>(request: ApiPostRequest, resultType: T.Type, completionHandler:@escaping(Result<T?, ApiNetworkError>)-> Void) {
        
        var urlRequest = self.createApiUrlRequestWithHeader(requestUrl: request.url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = request.requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        self.performApiOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }
    
    // MARK: - Custom Method
    
    private func createApiUrlRequestWithHeader(requestUrl: URL) -> URLRequest {
        let urlRequest = URLRequest(url: requestUrl)
        
          //Note: You can put comman authtication and header part here
//        if(authenticationToken != nil) {
//            urlRequest.setValue(authenticationToken!, forHTTPHeaderField: "authorization")
//        }
        
        return urlRequest
    }
    
    private func performApiOperation<T: Decodable>(requestUrl: URLRequest, responseType: T.Type, completionHandler: @escaping (Result<T?, ApiNetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(ApiNetworkError(serverResponse: nil, requestUrl: requestUrl.url!, httpBody: requestUrl.httpBody, message: "Invalid Response", statusCode: 0)))
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            debugPrint("📡 Status Code: \(statusCode)") // Log HTTP Status Code
            
            if (200...299).contains(statusCode) {
                guard let data = data else {
                    completionHandler(.failure(ApiNetworkError(serverResponse: nil, requestUrl: requestUrl.url!, httpBody: requestUrl.httpBody, message: "No Data Received", statusCode: statusCode)))
                    return
                }
                
                let response = self.decodeJsonResponse(data: data, responseType: responseType)
                if let response = response {
                    completionHandler(.success(response))
                } else {
                    completionHandler(.failure(ApiNetworkError(serverResponse: data, requestUrl: requestUrl.url!, httpBody: requestUrl.httpBody, message: error.debugDescription, statusCode: statusCode)))
                }
            } else {
                completionHandler(.failure(ApiNetworkError(serverResponse: data, requestUrl: requestUrl.url!, httpBody: requestUrl.httpBody, message: error.debugDescription, statusCode: statusCode)))
            }
        }
        task.resume()
    }

    private func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type) -> T? {
        do {
            return try JSONDecoder().decode(responseType, from: data)
        } catch {
            debugPrint("❌ JSON Decoding Error: \(error.localizedDescription)")
            return nil
        }
    }
}
