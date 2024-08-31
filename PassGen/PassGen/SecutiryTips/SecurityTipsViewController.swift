//
//  SecurityTipsViewController.swift
//  PassGen
//
//  Created by Doni Silva on 28/08/24.
//

import UIKit

final class SecurityTipsViewController: UIViewController {

    private var securityTipsView: SecutiryTipsView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setup() {
        self.securityTipsView = SecutiryTipsView()
        self.view = securityTipsView
        securityTipsView?.delegate = self
    }
}

extension SecurityTipsViewController: SecutiryTipsViewDelegate {
    func dismissView() {
        self.dismiss(animated: true)
    }
}
