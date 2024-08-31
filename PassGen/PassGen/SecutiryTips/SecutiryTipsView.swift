//
//  SecutiryTipsView.swift
//  PassGen
//
//  Created by Doni Silva on 28/08/24.
//

import Foundation
import UIKit

public protocol SecutiryTipsViewDelegate: AnyObject {
    func dismissView()
}

final class SecutiryTipsView: UIView {
    
    enum Constants {
        static let closeButton = "closeButton".localized
        static let labelTitle = "labelTitle".localized
        static let securityTips = SecurityTips.securityTips
    }
    
    public weak var delegate: SecutiryTipsViewDelegate?

    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.labelTitle
        label.font = UIFont.systemFont(ofSize: SizeMetrics.medium)
        label.numberOfLines = .zero
        label.textColor = .white
        return label
    }()
    
    private lazy var textViewPassword: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.frame = .zero
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textAlignment = NSTextAlignment.justified
        textView.textColor = .white
        textView.font = UIFont.systemFont(ofSize: SizeMetrics.small)
        textView.backgroundColor = .grayBg
        textView.text = Constants.securityTips
        textView.layer.cornerRadius = SizeMetrics.little
        return textView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(Constants.closeButton, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonAction), for:.touchUpInside)
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
        view.addSubview(labelTitle)
        view.addSubview(textViewPassword)
        view.addSubview(closeButton)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        
        labelTitle.topTo(view.safeAreaLayoutGuide.topAnchor, constant: SizeMetrics.large)
        labelTitle.centerXTo(view.centerXAnchor)
        
        textViewPassword.topTo(labelTitle.bottomAnchor, constant: SizeMetrics.medium)
        textViewPassword.leadingTo(view.leadingAnchor, constant: SizeMetrics.medium)
        textViewPassword.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium)
    
        closeButton.topTo(textViewPassword.bottomAnchor, constant: SizeMetrics.small)
        closeButton.trailingTo(view.trailingAnchor, constant: SizeMetrics.little)
        closeButton.bottomTo(view.safeAreaLayoutGuide.bottomAnchor, constant: SizeMetrics.big)
        closeButton.height(SizeMetrics.medium)
    }
    
    @objc func closeButtonAction() {
        delegate?.dismissView()
    }
}
