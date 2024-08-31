//
//  PasswordsListViewController.swift
//  PassGen
//
//  Created by Doni Silva on 28/08/24.
//

import UIKit

final class PasswordsListViewController: UIViewController {
    
    private enum Constants {
        static let title = "titlePasswordsListVC".localized
    }
    
    private var passwordGenerator = PasswordGenerator()
    private var passwordsListView: PasswordsListView?
    public var password: Password?
    public var passwordsList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = Constants.title
        
        self.passwordsListView = PasswordsListView()
        self.view = passwordsListView
        passwordsListView?.delegate = self
        
        updatePasswordsList()
    }
    
    private func updatePasswordsList() {
        for password in passwordsList {
            passwordsListView?.textViewPassword.text.append(password + "\n\n")
        }
    }
}

extension PasswordsListViewController: PasswordsListViewDelegate {
    public func generatePasswordAgain() {
        passwordsList.removeAll()
        
        if let password = password {
            let passwords = passwordGenerator.generate(password: password)
            
            for newPassword in passwords {
                self.passwordsList.append(newPassword)
                passwordsListView?.textViewPassword.scrollRangeToVisible(NSRange(location: .zero, length: .zero))
                passwordsListView?.textViewPassword.text = ""
                updatePasswordsList()
            }
        }
    }
    
    public func showSecurityTips() {
        let securityTipsViewController = SecurityTipsViewController()
        securityTipsViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(securityTipsViewController, animated: true)
    }
}
