//
//  CharactersProtocols.swift
//  rick-and-morty
//
//  Created by Carlos Soler on 12/12/22.
//

import UIKit

protocol CharactersViewToPresenterProtocol {
    var view: CharactersPresenterToViewProtocol? {get set}
    var interactor: CharactersPresenterToInteractorProtocol? {get set}
    var router: CharactersPresenterToRouterProtocol? {get set}
        
    func viewDidLoad()
    
    func popViewController(withNavitagionController navigationController: UINavigationController)
}

protocol CharactersPresenterToInteractorProtocol {
    var presenter: CharactersInteractorToPresenterProtocol? {get set}
    
    func viewDidLoad()
}

protocol CharactersInteractorToPresenterProtocol {    
    func reloadData()
    func showAlert(withTitle title: String, description: String, buttons: [UIAlertAction])
}

protocol CharactersPresenterToViewProtocol {
    func reloadData()
    func showAlert(withTitle title: String, description: String, andButtons buttons: [UIAlertAction])
    func showSpinner()
    func stopSpinner()
}

protocol CharactersPresenterToRouterProtocol {
    func popViewController(withNavitagionController navigationController: UINavigationController)
}
