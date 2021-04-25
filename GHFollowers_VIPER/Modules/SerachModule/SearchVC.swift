//
//  SearchVC.swift
//  GHFollowers_VIPER
//
//  Created by Ayman Ata on 4/24/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var presenter: SearchPresenterInterface?
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gh-logo")
        imageView.tintColor = .systemPink
        return imageView
    }()
    
    let userTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.textColor = .label
        textField.tintColor = .label
        textField.textAlignment = .center
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        return textField
    }()
    
    let getFollowerBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius  = 10
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.backgroundColor = .systemPink
        button.setTitle("Git Followers", for: .normal)
        button.addTarget(self, action: #selector(getFollowersBtnTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.notifyViewWillDisappear()
    }
    
    @objc private func getFollowersBtnTapped() {
        guard let user = userTextField.text, !user.isEmpty else { return }
        presenter?.getFollowersFor(user: user)
        userTextField.text = nil
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        userTextField.delegate = self
        navigationController?.navigationBar.tintColor = .black
        
        [logoImageView, userTextField, getFollowerBtn].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userTextField.heightAnchor.constraint(equalToConstant: 48),
            
            getFollowerBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            getFollowerBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowerBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowerBtn.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension SearchVC: SearchViewInterface {
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUIElements() {
        setupUI()
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let user = userTextField.text,
            !user.isEmpty else { return false }
        presenter?.getFollowersFor(user: user)
        userTextField.text = nil
        return true
    }
}
