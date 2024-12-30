//
//  SignUpViewController.swift
//  chat-app
//
//  Created by DungHM on 30/12/24.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    let userDefault = UserDefaults.standard
    var nameEmpty = true
    var emailEmpty = true
    var passwordEmpty = true
    var check = false {
        didSet {
            if check {
                checkBtn.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                checkAllowSignUp()
            } else {
                checkBtn.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                checkAllowSignUp()
            }
        }
    }
    
    var allowSignUp = false {
        didSet {
            if allowSignUp {
                signUpBtn.isEnabled = true
                signUpBtn.backgroundColor = UIColor.UIColorFromRGB(0x4356B4)
            } else {
                signUpBtn.isEnabled = false
                signUpBtn.backgroundColor = UIColor.UIColorFromRGB(0xCACACA)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        nameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        check = false
        allowSignUp = false
    }
    
    func checkAllowSignUp() {
        nameEmpty = true
        emailEmpty = true
        passwordEmpty = true
        nameEmpty = nameTF.text == ""
        emailEmpty = emailTF.text == ""
        passwordEmpty = passwordTF.text == ""
        if !nameEmpty && !emailEmpty && !passwordEmpty && check {
            allowSignUp = true
        } else {
            allowSignUp = false
        }
    }
    
    func presentAlert(title: String , message: String) {
        let al = UIAlertController(title: title, message: message, preferredStyle: .alert)
        al.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(al, animated: true)
    }
    
    func emailValidate(email: String) -> Bool{
        let regex = try? NSRegularExpression(pattern: "[A-Za-z0-9]+@gmail.com")
        let range = NSRange(location: 0 , length: email.utf16.count)
        return regex?.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func passwordValidate(password: String) -> Bool {
        let pwLen = password.count
        if (pwLen>16) || (pwLen<6) {
            return false
        }
        return true
    }
    
    func signUpValidate() -> Bool {
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
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func check(_ sender: Any) {
        check = !check
    }
    
    @IBAction func signUp(_ sender: Any) {
        if signUpValidate() {
            userDefault.set(nameTF.text, forKey: "name")
            userDefault.set(emailTF.text, forKey: "email")
            userDefault.set(passwordTF.text, forKey: "password")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkAllowSignUp()
    }
}
