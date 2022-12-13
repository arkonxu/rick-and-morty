//
//  CharactersPresenter.swift
//  rick-and-morty
//
//  Created by Carlos Soler on 12/12/22.
//

class CharacetersPresenter: CharactersViewToPresenterProtocol {
    
    var view: CharactersPresenterToViewProtocol?
    var interactor: CharactersPresenterToInteractorProtocol?
    var router: CharactersPresenterToRouterProtocol?
    
    var currentGuests: [Guest]?
    
    func viewDidLoad() {
        interactor?.viewDidLoad()
    }
    
    func popViewController(withNavitagionController navigationController: UINavigationController) {
        router?.popViewController(withNavitagionController: navigationController)
    }
    
}

extension InviteGuestsPresenter: CharactersInteractorToPresenterProtocol {

    func reloadData() {
        view?.reloadData()
    }
    
    func showAlert(withTitle title: String, description: String, andButtons buttons: [UIAlertAction]) {
        view?.showAlert(withTitle: title, description: description, andButtons: buttons)
    }
    
    func showSpinner() {
        view?.showSpinner(withCustomColor: nil)
    }
    
    func stopSpinner() {
        view?.stopSpinner()
    }
    
}
