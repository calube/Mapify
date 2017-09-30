//
//  LoginCell.swift
//  mapify
//
//  Created by Caleb Davis on 9/30/17.
//  Copyright © 2017 Caleb Davis. All rights reserved.
//

import Foundation
import Firebase
import FBSDKLoginKit
import SnapKit

protocol DismissVCDelegate: NSObjectProtocol {
    func dismissVC()
}

class LoginCell: UICollectionViewCell {

    weak var delegate: DismissVCDelegate?

    // Properties
    var activeUser: User!
    var dict : [String : AnyObject]!
    fileprivate let facebookLoginManager = FBSDKLoginManager()
    let screenWidth = UIScreen.main.bounds.width

    // UIElements
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 152/255, green: 204/255, blue: 246/255, alpha: 1)
        return view
    }()

    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "My Maps"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 34)
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.width
//        label.frame = CGRect(x: screenWidth/2 - 64, y: screenHeight/7, width: 400, height: 44)
        return label
    }()

    let bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        tf.placeholder = "Email Address"
        return tf
    }()

    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()

    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 152/255, green: 204/255, blue: 246/255, alpha: 1)
        button.layer.cornerRadius = 5

        return button
    }()

    let forgotLoginDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Forgot your login details?"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    let getHelpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get help signing in", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(UIColor(red: 43/255, green: 149/255, blue: 237/255, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        return button
    }()

    let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1)
        return view
    }()

    let orLabel: UILabel = {
        let label = UILabel()
        label.text = "OR"
        label.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 16)
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
//        label.frame = CGRect(x: screenWidth/2 - 8, y: screenHeight/2 + 75, width: 24, height: 24)
        return label
    }()

    let rightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1)
        return view
    }()

    let facebookButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(#imageLiteral(resourceName: "fbLogo"), for: .normal)
        return button
    }()

    let connectButton: UIButton = {
        let button = UIButton()

        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitle("Connect with Facebook", for: .normal)
        button.setTitleColor(UIColor(red: 43/255, green: 149/255, blue: 237/255, alpha: 1), for: .normal)

        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

//        button.frame = CGRect(x: screenWidth/2 - 80, y: screenHeight/2 + screenHeight/4, width: 160, height: 32)
        return button
    }()

    let seperatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 203/255, green: 203/255, blue: 203/255, alpha: 1)
        return view
    }()

    let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.textColor = UIColor(red: 165/255, green: 165/255, blue: 165/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
//        label.frame = CGRect(x: screenWidth/2 - 100, y: screenHeight - 32, width: 144, height: 16)
        return label
    }()

    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(UIColor(red: 43/255, green: 149/255, blue: 237/255, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: Setup Cell
extension LoginCell {
    func setup() {
        addSubviews()
        addConstraints()
    }

    func addSubviews() {
        addSubview(headerView)
        addSubview(logoLabel)
        addSubview(bodyView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(forgotLoginDetailsLabel)
        addSubview(getHelpButton)
        addSubview(leftLineView)
        addSubview(orLabel)
        addSubview(rightLineView)
        addSubview(facebookButton)
        addSubview(connectButton)
        addSubview(seperatorLineView)
        addSubview(dontHaveAccountLabel)
        addSubview(signUpButton)
    }

    func addConstraints() {
        headerView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(safeAreaLayoutGuide).multipliedBy(0.2)
        }
        logoLabel.snp.makeConstraints { (make) in
            make.center.equalTo(headerView).offset(8)
            make.height.equalTo(44)
        }

        bodyView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.right.left.bottom.equalTo(safeAreaLayoutGuide)
        }

        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(bodyView.snp.top).offset(32)
            make.left.equalTo(safeAreaLayoutGuide).offset(40)
            make.right.equalTo(safeAreaLayoutGuide).offset(-40)
            make.height.equalTo(44)
        }

        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(16)
            make.trailing.leading.equalTo(emailTextField)
            make.height.equalTo(44)
        }

        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.trailing.leading.equalTo(emailTextField)
            make.height.equalTo(44)
        }

        forgotLoginDetailsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(8)
            make.left.equalTo(loginButton.snp.left).offset(4)
            make.height.equalTo(16)
        }

        getHelpButton.snp.makeConstraints { (make) in
            make.top.equalTo(forgotLoginDetailsLabel.snp.top)
            make.left.equalTo(forgotLoginDetailsLabel.snp.right).offset(4)
            make.height.equalTo(16)
        }

        orLabel.snp.makeConstraints { (make) in
            let top = UIScreen.main.bounds.size.height / 10
            make.width.height.equalTo(24)
            make.top.equalTo(forgotLoginDetailsLabel.snp.bottom).offset(top)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }

        leftLineView.snp.makeConstraints { (make) in
            make.left.equalTo(loginButton)
            make.right.equalTo(orLabel.snp.left).offset(-8)
            make.height.equalTo(1)
            make.centerY.equalTo(orLabel)
        }

        rightLineView.snp.makeConstraints { (make) in
            make.left.equalTo(orLabel.snp.right).offset(8)
            make.right.equalTo(loginButton)
            make.height.equalTo(1)
            make.centerY.equalTo(orLabel)
        }

        connectButton.snp.makeConstraints { (make) in
            make.top.equalTo(orLabel.snp.bottom).offset(32)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }

        facebookButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.centerY.equalTo(connectButton)
            make.right.equalTo(connectButton.snp.left).offset(-8)
        }

        dontHaveAccountLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide).offset(-1 * screenWidth/12)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }

        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(dontHaveAccountLabel.snp.top)
            make.left.equalTo(dontHaveAccountLabel.snp.right).offset(8)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }

        seperatorLineView.snp.makeConstraints { (make) in
            make.width.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(dontHaveAccountLabel.snp.top)
            make.height.equalTo(1)
        }

    }
}
