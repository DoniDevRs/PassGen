//
//  PasswordGeneratorView.swift
//  PassGen
//
//  Created by Doni Silva on 28/08/24.
//

import UIKit

public protocol PasswordGeneratorViewDelegate: AnyObject {
    func goToPasswordsList(with password: Password)
}

final class PasswordGeneratorView: UIView {
    
    private enum Constants {
        static let numberOfPasswordsText = "numberOfPasswordsText".localized
        static let totalCharactersText = "totalCharactersText".localized
        static let useLowerCaseText = "useLowerCaseText".localized
        static let useNumbersText = "useNumbersText".localized
        static let useCapitalLettersText = "useCapitalLettersText".localized
        static let useSpecialCharText = "useSpecialCharText".localized
        static let buttonGenerateTitle = "buttonGenerateTitle".localized
        static let totalCharPlaceholder = "Max. 16"
        static let lockImage = "lockImage"
        static let imageSize: CGFloat = 200
        static let imageBgAlpha: CGFloat = 0.3
    }
    
    public weak var delegate: PasswordGeneratorViewDelegate?
    
    // MARK: - UI
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var imageLockBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bgImage")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = Constants.imageBgAlpha
        return imageView
    }()
    
    private lazy var labelNumberOfPasswords: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.numberOfPasswordsText
        label.font = UIFont.systemFont(ofSize: SizeMetrics.small)
        label.textColor = .white
        return label
    }()
    
    private lazy var textFieldNumberPasswords: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private lazy var labelTotalCharacters: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.totalCharactersText
        label.font = UIFont.systemFont(ofSize: SizeMetrics.small)
        label.textColor = .white
        return label
    }()
    
    private lazy var textFieldTotalCharacters: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.placeholder = Constants.totalCharPlaceholder
        textField.keyboardType = .numberPad
        textField.attributedPlaceholder = NSAttributedString(
            string: Constants.totalCharPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return textField
    }()
    
    private lazy var labelMinLetters: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.useLowerCaseText
        label.font = UIFont.systemFont(ofSize: SizeMetrics.small)
        label.textColor = .white
        return label
    }()
    
    private lazy var switchMinLetters: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = .appPrimary
        sw.isOn = true
        return sw
    }()
    
    private lazy var labelNumbers: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.useNumbersText
        label.font = UIFont.systemFont(ofSize: SizeMetrics.small)
        label.textColor = .white
        return label
    }()
    
    private lazy var switchNumbers: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = .appPrimary
        sw.isOn = true
        return sw
    }()
    
    private lazy var labelCapitalLetters: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.useCapitalLettersText
        label.font = UIFont.systemFont(ofSize: SizeMetrics.small)
        label.textColor = .white
        return label
    }()
    
    private lazy var switchCapitalLetters: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = .appPrimary
        sw.isOn = true
        return sw
    }()
    
    private lazy var labelSpecialCharacters: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.useSpecialCharText
        label.font = UIFont.systemFont(ofSize: SizeMetrics.small)
        label.textColor = .white
        return label
    }()
    
    private lazy var switchSpecialCharacters: UISwitch = {
        let sw = UISwitch()
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.onTintColor = .appPrimary
        sw.isOn = true
        return sw
    }()
    
    private lazy var generatePasswordButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .appPrimary
        button.setTitle(Constants.buttonGenerateTitle, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = SizeMetrics.tiny
        button.addTarget(self, action: #selector(generatePassordButtonTapped), for:.touchUpInside)
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
        view.addSubview(imageLockBackground)
        view.addSubview(labelNumberOfPasswords)
        view.addSubview(textFieldNumberPasswords)
        view.addSubview(labelTotalCharacters)
        view.addSubview(textFieldTotalCharacters)
        view.addSubview(labelMinLetters)
        view.addSubview(switchMinLetters)
        view.addSubview(labelNumbers)
        view.addSubview(switchNumbers)
        view.addSubview(labelCapitalLetters)
        view.addSubview(switchCapitalLetters)
        view.addSubview(labelSpecialCharacters)
        view.addSubview(switchSpecialCharacters)
        view.addSubview(generatePasswordButton)
    }
    
    private func addConstraints() {
        view.constraintToSuperView()
        imageLockBackground.constraintToSuperView(top: SizeMetrics.huge)
        
        labelNumberOfPasswords.topTo(view.safeAreaLayoutGuide.topAnchor, constant: SizeMetrics.medium)
        labelNumberOfPasswords.leadingTo(view.leadingAnchor, constant: SizeMetrics.medium2)
        labelNumberOfPasswords.trailingTo(textFieldNumberPasswords.leadingAnchor, constant: SizeMetrics.medium2)
        labelNumberOfPasswords.centerYTo(textFieldNumberPasswords.centerYAnchor)
        
        textFieldNumberPasswords.topTo(labelNumberOfPasswords.topAnchor)
        textFieldNumberPasswords.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        textFieldNumberPasswords.width(SizeMetrics.giant)
        
        labelTotalCharacters.topTo(labelNumberOfPasswords.bottomAnchor, constant: SizeMetrics.small)
        labelTotalCharacters.leadingTo(labelNumberOfPasswords.leadingAnchor)
        labelTotalCharacters.trailingTo(textFieldTotalCharacters.leadingAnchor, constant: SizeMetrics.medium2)
        labelTotalCharacters.centerYTo(textFieldTotalCharacters.centerYAnchor)
        
        textFieldTotalCharacters.topTo(labelTotalCharacters.topAnchor)
        textFieldTotalCharacters.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        textFieldTotalCharacters.width(SizeMetrics.giant)
        
        labelMinLetters.topTo(labelTotalCharacters.bottomAnchor, constant: SizeMetrics.small)
        labelMinLetters.leadingTo(labelNumberOfPasswords.leadingAnchor)
        labelMinLetters.trailingTo(switchMinLetters.leadingAnchor, constant: SizeMetrics.medium2)
        labelMinLetters.centerYTo(switchMinLetters.centerYAnchor)
        
        switchMinLetters.topTo(labelMinLetters.topAnchor)
        switchMinLetters.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        
        labelNumbers.topTo(labelMinLetters.bottomAnchor, constant: SizeMetrics.small)
        labelNumbers.leadingTo(labelNumberOfPasswords.leadingAnchor)
        labelNumbers.trailingTo(switchNumbers.leadingAnchor, constant: SizeMetrics.medium2)
        labelNumbers.centerYTo(switchNumbers.centerYAnchor)
        
        switchNumbers.topTo(labelNumbers.topAnchor)
        switchNumbers.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        
        labelCapitalLetters.topTo(labelNumbers.bottomAnchor, constant: SizeMetrics.small)
        labelCapitalLetters.leadingTo(labelNumberOfPasswords.leadingAnchor)
        labelCapitalLetters.trailingTo(switchCapitalLetters.leadingAnchor, constant: SizeMetrics.medium2)
        labelCapitalLetters.centerYTo(switchCapitalLetters.centerYAnchor)
        
        switchCapitalLetters.topTo(labelCapitalLetters.topAnchor)
        switchCapitalLetters.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        
        labelSpecialCharacters.topTo(labelCapitalLetters.bottomAnchor, constant: SizeMetrics.small)
        labelSpecialCharacters.leadingTo(labelNumberOfPasswords.leadingAnchor)
        labelSpecialCharacters.trailingTo(switchSpecialCharacters.leadingAnchor, constant: SizeMetrics.medium2)
        labelSpecialCharacters.centerYTo(switchSpecialCharacters.centerYAnchor)
        
        switchSpecialCharacters.topTo(labelSpecialCharacters.topAnchor)
        switchSpecialCharacters.trailingTo(view.trailingAnchor, constant: SizeMetrics.medium2)
        
        generatePasswordButton.topTo(labelSpecialCharacters.bottomAnchor, constant: SizeMetrics.huge)
        generatePasswordButton.leadingTo(view.leadingAnchor, constant: SizeMetrics.large)
        generatePasswordButton.trailingTo(view.trailingAnchor, constant: SizeMetrics.large)
        generatePasswordButton.height(SizeMetrics.big)

    }
    
    public func restartItemsState() {
        textFieldNumberPasswords.text = ""
        textFieldTotalCharacters.text = ""
        textFieldTotalCharacters.attributedPlaceholder = NSAttributedString(
            string: Constants.totalCharPlaceholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        switchMinLetters.isOn = true
        switchNumbers.isOn = true
        switchCapitalLetters.isOn = true
        switchSpecialCharacters.isOn = true
    }
    
    @objc func generatePassordButtonTapped() {
        guard let numberOfPasswords = Int(textFieldNumberPasswords.text ?? ""),
              let numberOfCharacters = Int(textFieldTotalCharacters.text ?? "")  else {
            return
        }
        
        var numchars = min(numberOfCharacters, 16)
        numchars = max(numchars, 1)
        
        let password = Password(numberOfPasswords: numberOfPasswords,
                                numberOfCharacters: numchars,
                                useLetters: switchMinLetters.isOn,
                                useNumbers: switchNumbers.isOn,
                                useCapitalLetters: switchCapitalLetters.isOn,
                                useSpecialCharacters: switchSpecialCharacters.isOn)
        delegate?.goToPasswordsList(with: password)
    }
}
