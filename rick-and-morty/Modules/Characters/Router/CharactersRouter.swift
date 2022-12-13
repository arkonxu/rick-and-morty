//
//  CharactersRouter.swift
//  rick-and-morty
//
//  Created by Carlos Soler on 12/12/22.
//


class CharactersRouter {
    
    @objc func createModule() -> CharactersViewController {
        let view = CharactersViewController(nibName: "CharactersView", bundle: nil)
        var presenter: CharactersViewToPresenterProtocol & CharactersInteractorToPresenterProtocol = CharactersPresenter()
        var interactor: CharactersPresenterToInteractorProtocol = CharactersInteractor()
        let router: CharactersPresenterToRouterProtocol = CharactersRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
}


extension CharactersRouter: CharactersPresenterToRouterProtocol {
    
    func popViewController(withNavitagionController navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
    
}
