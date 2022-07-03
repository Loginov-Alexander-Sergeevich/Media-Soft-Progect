//
//  LoginViewController.swift
//  MediaSoftProgect
//
//  Created by Александр Александров on 01.07.2022.
//

import UIKit
import SnapKit


final class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModelProtocol!
 
    
//    let logInImageView: UIImageView = {
//        let imageView = UIImageView(image: UIImage(named: "LogoUnsplash"))
//        return imageView
//    }()
    
    lazy var idTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "client_id"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var secretTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "client_secret"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        
        button.addTarget(self, action: #selector(logInButtonAction), for: .touchUpInside)
        return button
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
        viewModel = LoginViewModel()
        setView()
        cofigurationConstraints()
    }
    
    func setView() {
        view.addSubviews([verticalStackView])
        verticalStackView.addArrangedSubviews([idTextField, secretTextField, logInButton])
    }
    
    func cofigurationConstraints() {
        let sizeButton = CGSize(width: 100, height: 300)
        
        verticalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        logInButton.snp.makeConstraints { make in
            make.size.equalTo(sizeButton)
        }
        
        idTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        secretTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
//        logInImageView.snp.makeConstraints { make in
//            make.size.equalTo(sizeImageView)
//        }
    }
    
    @objc private func logInButtonAction() {
        
        self.viewModel.requestGfycat(client_id: idTextField.text!, client_secret: secretTextField.text!, grant_type: "client_credentials")
        let tabBarViewController = TabBarViewController()
        tabBarViewController.modalPresentationStyle = .custom
        navigationController?.present(tabBarViewController, animated: true)
    }

}
