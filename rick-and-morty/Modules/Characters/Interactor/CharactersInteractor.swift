//
//  CharactersInteractor.swift
//  rick-and-morty
//
//  Created by Carlos Soler on 12/12/22.
//

import Alamofire
import UIKit

class CharactersInteractor {
    
    //MARK: Properties
    
    var presenter: CharactersInteractorToPresenterProtocol?
    
    //MARK: Private implementations
    
    private func showErrorAlert(withDescription description: String = "REUSABLE_KEY_GENERIC_ERROR".localizedString) {
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        self.presenter?.showAlert(withTitle: "Error".localizedString, description: description, andButtons: [action])
    }
    
    private func reloadData() {
//        self.presenter?.currentGuests = self.currentGuests
        self.presenter?.reloadData()
    }
    
}

//MARK: CharactersPresenterToInteractorProtocol implementation

extension CharactersInteractor: CharactersPresenterToInteractorProtocol {
    
    //MARK: Life cycle
    
    func viewDidLoad() {
        
    }
    
}
