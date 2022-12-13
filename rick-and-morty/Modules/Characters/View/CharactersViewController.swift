//
//  CharactersViewController.swift
//  rick-and-morty
//
//  Created by Carlos Soler on 12/12/22.
//

import UIKit

class CharactersViewController: UIViewController {
    
    //MARK: Outlets
    
    
    //MARK: Properties
    
    
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        
        self.presenter?.viewDidLoad()
    }
    
    //MARK: Private implementations
    
    private func setUp() {
        self.configureCollection()
        
        self.configureStyles()
        
        self.configureNavigationBar()
    }
    
    private func configureCollection() {
//        invitationsCollectionView.register(UINib(nibName: InvitationsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: InvitationsCollectionViewCell.identifier)
//        invitationsCollectionView.register(UINib(nibName: AddMoreInvitationsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AddMoreInvitationsCollectionViewCell.identifier)
//
//        invitationsCollectionView.delegate = self
//        invitationsCollectionView.dataSource = self
    }
    
    private func configureStyles() {
        
    }
    
    private func configureNavigationBar() {
//        self.title = UserDefaultsHelper.sharedUserDefaults.getConsumerTypeUserDefaults() != "School" ? "GUESTS_SECTION_TITLE".localizedString : "GUESTS_SECTION_TITLE_SCHOOL".localizedString
//
//        self.setupNavigationBar()
    }
    
}

//MARK: CollectionView Implementation

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

//MARK: PresenterToViewProtocol implementation

extension CharactersViewController: CharactersPresenterToViewProtocol {
    
    
    
}
