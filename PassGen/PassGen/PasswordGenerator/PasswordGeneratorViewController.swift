//
//  PasswordGeneratorViewController.swift
//  PassGen
//
//  Created by Doni Silva on 28/08/24.
//

import UIKit

final class PasswordGeneratorViewController: UIViewController {
    
    private enum Constants {
        static let title = "titlePasswordGeneratorVC".localized
    }
    
    private var passwordGeneratorView: PasswordGeneratorView?
    private var passwordGenerator = PasswordGenerator()
    public var passwordsList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = Constants.title
        
        self.passwordGeneratorView = PasswordGeneratorView()
        self.view = passwordGeneratorView
        passwordGeneratorView?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordGeneratorView?.restartItemsState()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension PasswordGeneratorViewController: PasswordGeneratorViewDelegate {
    public func goToPasswordsList(with password: Password) {
        passwordsList.removeAll()
        
        let passwords = passwordGenerator.generate(password: password)
        for newPassword in passwords {
            self.passwordsList.append(newPassword)
        }
        
        let passwordListViewController = PasswordsListViewController()
        passwordListViewController.passwordsList = self.passwordsList
        passwordListViewController.password = password
        navigationController?.pushViewController(passwordListViewController, animated: true)
    }
}
