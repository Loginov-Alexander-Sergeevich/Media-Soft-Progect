//
//  RegistrationViewController.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 03.07.2022.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        label.text = "Регистрация"
        label.textColor = .black
        label.layer.shadowOpacity = 0.4
        label.layer.shadowRadius = 4.0
        label.layer.shadowColor = UIColor.white.cgColor
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Введите Имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)

        textField.contentMode = .scaleAspectFit
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Введите Eмейл", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.keyboardType = .emailAddress
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)

        textField.contentMode = .scaleAspectFit
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: "Введите Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)

        textField.contentMode = .scaleAspectFit
        return textField
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        return button
    }()
    
    let errorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Не верные данные", message: "Введите Емайл и Пароль", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(ok)
        return alert
    }()
    
    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        cofigurationConstraints()
    }
    
    func setView() {
        view.addSubviews([verticalStackView])
        verticalStackView.addArrangedSubviews([loginLabel, nameTextField, emailTextField, passwordTextField, registrationButton])
    }
    
    func cofigurationConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalTo(verticalStackView.snp.bottom).offset(20)
        }
    }
    
    @objc private func registrationButtonAction() {
        
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    if let result = result {
                        print("ID USER ------- \(result.user.uid)")
                        let firebaseDataBase = Database.database().reference().child("users")
                        firebaseDataBase.child(result.user.uid).updateChildValues(["name" : name, "email" : email])
                    }
                }
                let tabBarViewController = TabBarViewController()
                tabBarViewController.modalPresentationStyle = .custom
                self.navigationController?.present(tabBarViewController, animated: true)
                self.dismiss(animated: true, completion: nil)
            }
        } else {
            present(errorAlert, animated: true, completion: nil)
        }
    }
}
