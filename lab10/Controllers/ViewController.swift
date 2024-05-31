//  lab10
//
//  Created by Alexey on 27.05.2024
//

import UIKit

class ViewController: UIViewController {
    
    var iconClick : Bool!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var signInOrUp: UISegmentedControl!
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var actionName: UILabel!
    
    @IBAction func eye(_ sender: Any) {
        
        if(iconClick == true) {
            passwordInput.isSecureTextEntry = false
            iconClick = false
        } else {
            passwordInput.isSecureTextEntry = true
            iconClick = true
        }
        
    }
  
    @objc func dismissKeyboard() {
        // Вызовите метод endEditing(_:), чтобы закрыть клавиатуру
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInOrUp.accessibilityIdentifier = "signInOrUp"
        passwordInput.accessibilityIdentifier = "passwordInput"
        emailInput.accessibilityIdentifier = "emailInput"
        phoneNumber.accessibilityIdentifier = "phoneInput"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        login()
        iconClick = true
        passwordInput.isSecureTextEntry = true
    }
    
    @IBAction func enterButtonAction(_ sender: Any) {
        if (enterButton.title(for: []) == "ОК") {
            if (loginInput.text != "" && passwordInput.text != "" && emailInput.text != "" && phoneNumber.text != "") {
                if (UserDefaults.standard.string(forKey: "Login") == loginInput.text) 
                {
                    if (UserDefaults.standard.string(forKey: "Password") == passwordInput.text)
                    {
                        self.performSegue(withIdentifier: "mainScreen", sender: nil)
                    }
                    else
                    {
                        ShowInfolWindow.shared.short(self.view, txt_msg: "Пользователь с таким логином уже существует. Пароль не верный.")
                    }
                }
                else
                {
                    UserDefaults.standard.set(loginInput.text, forKey: "Login")
                    UserDefaults.standard.set(passwordInput.text, forKey: "Password")
                    UserDefaults.standard.set(emailInput.text, forKey: "e-mail")
                    UserDefaults.standard.set(phoneNumber.text, forKey: "Phone")
                    ShowInfolWindow.shared.short(self.view, txt_msg: "Благодарим за регистрацию!")
                    self.performSegue(withIdentifier: "mainScreen", sender: nil)
                }
            }
            else {
                ShowInfolWindow.shared.short(self.view, txt_msg: "Заполните все поля!")
            }
        }
        else {
            if (UserDefaults.standard.string(forKey: "Login") == loginInput.text && UserDefaults.standard.string(forKey: "Password") == passwordInput.text) {
                self.performSegue(withIdentifier: "mainScreen", sender: nil)
            }
            else {
                ShowInfolWindow.shared.short(self.view, txt_msg: "Неверный логин или пароль")
            }
        }
    }
    
    func login() {
        actionName.text = "Авторизация"
        emailInput.isHidden = true
        phoneNumber.isHidden = true
        lab.isHidden = true
        emailLabel.isHidden = true
        phoneLabel.isHidden = true
        enterButton.frame.origin.y -= 140
        enterButton.setTitle("Войти", for: [])
    }
    
    @IBAction func changeSignTypeAction(_ sender: Any) {
        if (signInOrUp.selectedSegmentIndex == 1) {
            login()
        }
        else {
            enterButton.setTitle("ОК", for: [])
            actionName.text = "Регистрация"
            phoneNumber.isHidden = false
            lab.isHidden = false
            emailLabel.isHidden = false
            phoneLabel.isHidden = false
            emailInput.isHidden = false
            phoneNumber.isHidden = false
            enterButton.frame.origin.y += 140
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
