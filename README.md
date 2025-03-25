# MVVM-APIManager

## Overview
MVVM-ApiManager is a common API manager class that simplifies network requests and enhances modularity in Swift applications.

## Usage

## GET Request example 

        guard let url = URL(string: "https://api.restful-api.dev/objects") else {
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

## Post Request example 

        guard let url = URL(string: "https://api.restful-api.dev/objects") else {
            print("Invalid URL")
            return
        }
        
        let request = ApiPostRequest(withUrl: url, requestParameters: params)
        
        ApiManager.shared.postData(request: request, resultType: HomeModel.self) { [weak self] result in
            switch result {
            case .success(let homeModel):
                self?.delegate?.didReceivePostData(homeModel!)
            case .failure(let error):
                self?.delegate?.didFailWithError(error.reason ?? "")
            }
        }

## License
This project is licensed under the MIT License - see the LICENSE file for details.
