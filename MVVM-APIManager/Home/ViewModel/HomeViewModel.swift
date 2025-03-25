//
//  HomeViewModel.swift
//  MVVM-APIManager
//
//  Created by Ghoshit.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didReceiveData(_ data: [HomeModel])
    func didFailWithError(_ error: String)
    func didReceivePostData(_ data: HomeModel)
}

extension HomeViewModelDelegate {
    func didReceiveData(_ data: [HomeModel]) {}
    func didFailWithError(_ error: String) {}
    func didReceivePostData(_ data: HomeModel) {}
}

class HomeViewModel {
    
    // MARK: - Variable(s)
    
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: - Api Method(s)
    
    func fetchData() {
        guard let url = URL(string: ApiURLS.objectData) else {
            print("Invalid URL")
            return
        }
        
        ApiManager.shared.getApiData(requestUrl: url, resultType: [HomeModel].self) { [weak self] result in
            switch result {
            case .success(let homeModel):
                self?.delegate?.didReceiveData(homeModel ?? [])
            case .failure(let error):
                self?.delegate?.didFailWithError(error.reason ?? "")
            }
        }
    }
    
    func sendData() {
        guard let url = URL(string: ApiURLS.objectData) else {
            print("Invalid URL")
            return
        }
        
        let params: [String: Any] = [
            "name": "Apple MacBook Pro 18-inch",
            "data": [
                "year" : 2019,
                "price": 1849.99,
                "CPU model": "Intel Core i9",
                "Hard disk size": "1 TB"
            ]
        ]
        
        let request = ApiPostRequest(withUrl: url, requestParameters: params)
        
        ApiManager.shared.postData(request: request, resultType: HomeModel.self) { [weak self] result in
            switch result {
            case .success(let homeModel):
                self?.delegate?.didReceivePostData(homeModel!)
            case .failure(let error):
                self?.delegate?.didFailWithError(error.reason ?? "")
            }
        }
    }
}
