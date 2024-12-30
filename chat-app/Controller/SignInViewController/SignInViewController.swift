//
//  LoginViewController.swift
//  chat-app
//
//  Created by DungHM on 30/12/24.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    var emailEmpty = false
    var passwordEmpty = false
    let userDefault = UserDefaults.standard
    var allowSignIn = false {
        didSet {
            if allowSignIn {
                signInBtn.isEnabled = true
                signInBtn.backgroundColor = UIColor.UIColorFromRGB(0x4356B4)
            } else {
                signInBtn.isEnabled = false
                signInBtn.backgroundColor = UIColor.UIColorFromRGB(0xCACACA)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        emailTF.delegate = self
        passwordTF.delegate = self
        allowSignIn = false 
    }
    
    func checkAllowSignIn() {
        emailEmpty = true
        passwordEmpty = true
        emailEmpty = emailTF.text == ""
        passwordEmpty = passwordTF.text == ""
        if !emailEmpty && !passwordEmpty {
            allowSignIn = true
        } else {
            allowSignIn = false
        }
    }
    
    func presentAlert(title: String , message: String) {
        let al = UIAlertController(title: title, message: message, preferredStyle: .alert)
        al.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(al, animated: true)
    }
    
    func emailValidate(email: String) -> Bool{
        let regex = try? NSRegularExpression(pattern: "[A-Za-z0-9]+@gmail.com")
        let range = NSRange(location: 0 , length: email.utf16.count )
        return regex?.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func passwordValidate(password: String) -> Bool {
        let pwLen = password.count
        if (pwLen>16) || (pwLen<6) {
            return false
        }
        return true
    }
    
    func signInValidate() -> Bool {
        if emailValidate(email: emailTF.text!) == false {
            presentAlert(title: "Error", message: "Please enter a valid email")
            return false
        }
        if passwordValidate(password: passwordTF.text!) == false {
            presentAlert(title: "Error", message: "Please enter a valid password")
            return false
        }
        return true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        
    }
    
    @IBAction func signIn(_ sender: Any) {
        if userDefault.string(forKey: "email") == emailTF.text && userDefault.string(forKey: "password") == passwordTF.text {
            presentAlert(title: "Success", message: "Sign in successfully")
        } else {
            presentAlert(title: "Error", message: "Sign in failed")
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkAllowSignIn()
    }
}
