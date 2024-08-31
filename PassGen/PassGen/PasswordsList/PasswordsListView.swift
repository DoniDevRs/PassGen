//
//  PasswordsListView.swift
//  PassGen
//
//  Created by Doni Silva on 28/08/24.
//

import UIKit

public protocol PasswordsListViewDelegate: AnyObject {
    func generatePasswordAgain()
    func showSecurityTips()
}

final class PasswordsListView: UIView {
    
    enum Constants {
        static let buttonGenerateAgainTitle = "buttonGenerateAgainTitle".localized
        static let buttonTipsSecTitle = "buttonTipsSecTitle".localized
    }
    
    public weak var delegate: PasswordsListViewDelegate?
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    public lazy var textViewPassword: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.frame = .zero
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: SizeMetrics.large)
        textView.layer.cornerRadius = SizeMetrics.little
        textView.backgroundColor = .grayBg
        return textView
    }()
    
    private lazy var generateAgainButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .appPrimary
        button.setTitle(Constants.buttonGenerateAgainTitle, for: .normal)
        button.layer.cornerRadius = SizeMetrics.tiny
        button.addTarget(self, action: #selector(generateAgainButtonTapped), for:.touchUpInside)
        return button
    }()
    
    private lazy var tipsSecurityButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.buttonTipsSecTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(securityButtonAction), for:.touchUpInside)
        return button
    }()
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        buildViewHierarchy()
        addConstraints()
    }
    
    private func buildViewHierarchy() {
        addSubview(view)
        view.addSubview(textViewPassword)
        view.addSubview(generateAgainButton)
        view.addSubview(tipsSecurityButton)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        textViewPassword.topTo(view.safeAreaLayoutGuide.topAnchor, constant: SizeMetrics.little)
        textViewPassword.leadingTo(view.leadingAnchor, constant: SizeMetrics.little)
        textViewPassword.trailingTo(view.trailingAnchor, constant: SizeMetrics.little)
        
        generateAgainButton.topTo(textViewPassword.bottomAnchor, constant: SizeMetrics.large)
        generateAgainButton.leadingTo(view.leadingAnchor, constant: SizeMetrics.large)
        generateAgainButton.trailingTo(view.trailingAnchor, constant: SizeMetrics.large)
        generateAgainButton.height(SizeMetrics.big)
        
        tipsSecurityButton.topTo(generateAgainButton.bottomAnchor, constant: SizeMetrics.big)
        tipsSecurityButton.trailingTo(view.trailingAnchor, constant: SizeMetrics.little)
        tipsSecurityButton.bottomTo(view.safeAreaLayoutGuide.bottomAnchor, constant: SizeMetrics.large)
        tipsSecurityButton.height(SizeMetrics.medium)
        
    }
    
    @objc func generateAgainButtonTapped() {
        delegate?.generatePasswordAgain()
    }
    
    @objc func securityButtonAction() {
        delegate?.showSecurityTips()
    }
}
