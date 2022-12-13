//
//  CharactersInteractor.swift
//  rick-and-morty
//
//  Created by Carlos Soler on 12/12/22.
//

import Alamofire

class CharactersInteractor {
    
    //MARK: Properties
    
    var presenter: CharactersInteractorToPresenterProtocol?
    
    
    //MARK: Private implementations
    
    private func sendInvitations(_ emails: [String]?) {
        self.presenter?.showSpinner()
        
        guard let emails = emails else {
            return
        }

        let endpoint = OpacApiV2.BASE.rawValue + "/invitations"
        
        let params = ["guestEmails": emails]
        
        ClientNetworking().requestMock(fromEndpoint: endpoint, method: .post, params: params, encoding: JSONEncoding.default) { response in
            
            guard let data = response["response"] as? [String: Any], let successData = data["invitationsOk"] as? [[String: Any]], let errorData = data["invitationsKo"] as? [[String: Any]] else {
                return
            }
            
            for successGuest in successData {
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: successGuest)
                    let guest = try JSONDecoder().decode(Guest.self, from: data)
                    
                    guard let guestIndex = self.currentGuests?.lastIndex(where: {$0.guestEmail == guest.guestEmail}), var currentGuest = self.currentGuests?[guestIndex] else {
                        continue
                    }
                    
                    currentGuest = guest
                    
                    self.currentGuests?[guestIndex] = currentGuest
                } catch {
                    self.showErrorAlert()
                }
            }
            
            for errorGuest in errorData {
                do {
                    let data: Data = try JSONSerialization.data(withJSONObject: errorGuest)
                    let guest = try JSONDecoder().decode(Guest.self, from: data)
                    
                    guard let guestIndex = self.currentGuests?.lastIndex(where: {$0.guestEmail == guest.guestEmail}), var currentGuest = self.currentGuests?[guestIndex] else {
                        continue
                    }
                    
                    currentGuest.cause = guest.cause
                    
                    self.currentGuests?[guestIndex] = currentGuest
                    
                } catch {
                    self.showErrorAlert()
                }
            }
            
            self.validateEmails(self.currentGuests?.filter({ !$0.isInvitationValid && $0.isEmailValid }) ?? [])
            
            self.reloadData()
            
            guard let invalidInvitations = self.currentGuests?.filter({!$0.isInvitationValid}) else {
                self.showErrorAlert()
                return
            }
            
            if (invalidInvitations.count > 0) {
                self.showErrorAlert(withDescription: "GUESTS_ERROR_INVITATION_FAILURE".localizedString)
            } else {
                self.showSendConfirmationAlert()
            }
            
            self.presenter?.stopSpinner()
            
        } failure: { error in
            self.presenter?.stopSpinner()
            
            self.showErrorAlert()
        }
    }
    
    private func reSendInvitations(_ guest: Guest) {
        self.presenter?.showSpinner()
        
        guard let invitationId = guest.invitationId?.description else {
            return
        }

        let endpoint = OpacApiV2.BASE.rawValue + "/invitations/forward/" + invitationId
                
        ClientNetworking().requestMock(fromEndpoint: endpoint, method: .get) { response in
            self.showReSendConfirmationAlert()
            
            self.presenter?.stopSpinner()
        } failure: { error in
            
            guard let currentGuestIndex = self.currentGuests?.firstIndex(where: {$0.invitationId == guest.invitationId}), var currentGuest = self.currentGuests?[currentGuestIndex] else {
                self.showErrorAlert()
                return
            }
            
            if (error.errorCode == 404) {
                currentGuest.cause = "GUESTS_ERROR_WRONG_EMAIL"
            } else if (error.errorCode == 409) {
                currentGuest.cause = "GUESTS_ERROR_USED_INVITATION"
            }
            
            self.currentGuests?[currentGuestIndex] = currentGuest;
            
            self.reloadData()
            
            self.presenter?.stopSpinner()
            
            self.showErrorAlert()
            
        }
    }
    
    private func validateEmails(_ guests: [Guest]) {
        let areEmailsCompleted = guests.allSatisfy({$0.isEmailValid})
        let areAllWithoutError = guests.allSatisfy({!$0.didFailSending})
                
        self.presenter?.enableConfirmButton(areEmailsCompleted && areAllWithoutError)
    }
    
    private func showErrorAlert(withDescription description: String = "REUSABLE_KEY_GENERIC_ERROR".localizedString) {
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        self.presenter?.showAlert(withTitle: "Error".localizedString, description: description, andButtons: [action])
    }
    
    private func showSendConfirmationAlert() {
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        self.presenter?.showAlert(withTitle: "Info".localizedString, description: "GUEST_INVITATION_SENT_CONFIRMATION".localizedString, andButtons: [action])
    }
    
    private func showReSendConfirmationAlert() {
        let action = UIAlertAction(title: "OK".localizedString, style: .default)
        self.presenter?.showAlert(withTitle: "Info".localizedString, description: "GUEST_INVITATION_RESENT_CONFIRMATION".localizedString, andButtons: [action])
    }
    
    private func reloadData() {
        self.presenter?.currentGuests = self.currentGuests
        self.presenter?.reloadData()
    }
    
}

//MARK: CharactersPresenterToInteractorProtocol implementation

extension InviteGuestsInteractor: InviteGuestsPresenterToInteractorProtocol {
    
    //MARK: Life cycle
    
    func viewDidLoad() {
        self.getInvitations()
    }
    
}
