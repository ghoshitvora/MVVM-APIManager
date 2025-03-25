//
//  HomeVC.swift
//  MVVM-APIManager
//
//  Created by Ghoshit.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Outlet(s)
    
    @IBOutlet weak var btnSendData: UIButton!
    
    // MARK: - Variable(s)
    
    private var viewModel = HomeViewModel()
    
    // MARK: - ViewLife Cycle Method(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    // MARK: - Custom Method(s)
    
    func sendDataToServer() {
        viewModel.sendData()
    }
    
    // MARK: - Action Method(s)
    
    @IBAction func btnSendPostAction(_ sender: UIButton) {
        self.sendDataToServer()
    }
}

extension HomeVC : HomeViewModelDelegate {
    func didReceiveData(_ data: [HomeModel]) {
        print("The home Data is : \(data)")
    }
    
    func didReceivePostData(_ data: HomeModel) {
        print("The post Data is : \(data)")
    }
}
