//
//  HomeViewController.swift
//  YoutubeClone
//
//  Created by Fernando Maximiliano on 03/07/23.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var presenter = HomePresenter(delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Task{
            await presenter.getHomeObjects()
        }
    }


}


extension HomeViewController: HomeViewProtocol {
    func getData(list: [[Any]]) {
        print("list: ", list)
    }
    
    
}
