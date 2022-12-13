//
//  CharactersPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Soler on 12/12/22.
//

import UIKit

class CharactersPresenter: CharactersViewToPresenterProtocol {
    
    var view: CharactersPresenterToViewProtocol?
    var interactor: CharactersPresenterToInteractorProtocol?
    var router: CharactersPresenterToRouterProtocol?
    
    func viewDidLoad() {
        self.interactor?.viewDidLoad()
    }
    
    func popViewController(withNavitagionController navigationController: UINavigationController) {
        self.router?.popViewController(withNavitagionController: navigationController)
    }
    
}

extension CharactersPresenter: CharactersInteractorToPresenterProtocol {

    func reloadData() {
        self.view?.reloadData()
    }
    
    func showAlert(withTitle title: String, description: String, andButtons buttons: [UIAlertAction]) {
        self.view?.showAlert(withTitle: title, description: description, andButtons: buttons)
    }
    
    func showSpinner() {
        self.view?.showSpinner()
    }
    
    func stopSpinner() {
        self.view?.stopSpinner()
    }
    
}
