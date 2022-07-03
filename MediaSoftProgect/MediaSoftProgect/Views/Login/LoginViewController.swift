//
//  LoginViewController.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

import UIKit
import SnapKit
import Firebase

final class LoginViewController: UIViewController {
    
    var checkRegistration: Bool = true {
        willSet {
            if newValue {
                loginLabel.text = "Регистрация"
                nameTextField.isHidden = false
                logInButton.setTitle("Регистрация", for: .normal)
            } else {
                loginLabel.text = "Вход"
                nameTextField.isHidden = true
                logInButton.setTitle("Войти", for: .normal)
            }
        }
    }
 
    let loginLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(30)
        label.text = "Войти"
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
        textField.returnKeyType = .done
        textField.contentMode = .scaleAspectFit
        
        textField.delegate = self
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
        textField.returnKeyType = .done
        textField.contentMode = .scaleAspectFit
        
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.attributedPlaceholder = NSAttributedString(string: "Введите Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 10
        textField.backgroundColor = UIColor.clear
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textField.returnKeyType = .done
        textField.contentMode = .scaleAspectFit
        
        textField.delegate = self
        return textField
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(logInButtonButtonAction), for: .touchUpInside)
        return button
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
    
    let horisontallStackView: UIStackView = {
        let stackView = UIStackView()
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
        horisontallStackView.addArrangedSubviews([logInButton, registrationButton])
        verticalStackView.addArrangedSubviews([loginLabel, emailTextField, passwordTextField, horisontallStackView])
    }
    
    func cofigurationConstraints() {
        
        verticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        horisontallStackView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
//        nameTextField.snp.makeConstraints { make in
//            make.leading.trailing.equalToSuperview().inset(15)
//            make.height.equalTo(50)
//        }
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        logInButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.leading.equalTo(passwordTextField.snp.leading)
            make.trailing.equalTo(passwordTextField.snp.centerX).offset(-5)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.trailing.equalTo(passwordTextField.snp.trailing)
            make.leading.equalTo(passwordTextField.snp.centerX).offset(5)
            
        }
    }
    
    @objc private func logInButtonButtonAction() {
        //checkRegistration = !checkRegistration
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    let tabBarViewController = TabBarViewController()
                    tabBarViewController.modalPresentationStyle = .custom
                    self.navigationController?.present(tabBarViewController, animated: true)
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    self.present(self.errorAlert, animated: true, completion: nil)
                }
            }
        } else {
            present(errorAlert, animated: true, completion: nil)
        }
    }
    
    @objc private func registrationButtonAction() {
        let registrationViewController = RegistrationViewController()
        present(registrationViewController, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if checkRegistration {
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
        } else {
            if !email.isEmpty && !password.isEmpty {
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error == nil {
                        let tabBarViewController = TabBarViewController()
                        tabBarViewController.modalPresentationStyle = .custom
                        self.navigationController?.present(tabBarViewController, animated: true)
                        self.dismiss(animated: true, completion: nil)
                        
                    } else {
                        self.present(self.errorAlert, animated: true, completion: nil)
                    }
                }
            } else {
                present(errorAlert, animated: true, completion: nil)
            }
        }
        return true
    }
}
