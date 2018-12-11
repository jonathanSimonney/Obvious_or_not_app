//
//  RegisterController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 09/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegisterController: UIViewController, UITextFieldDelegate {

    var usernameSignUpField: UITextField?
    var passwordSignUpField: UITextField?
    var verifSignUpField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        let fieldWidth = self.view.frame.width - 48
        
        let firstLabel = UILabel()
        firstLabel.frame = CGRect(x: 24, y: self.view.frame.height - 146, width: fieldWidth, height: 72)
        firstLabel.text = "By signing in, I accept the generals conditions and the confidentiality policy."
        firstLabel.textColor = UIColor.white
        //firstLabel.backgroundColor = UIColor.blue
        firstLabel.numberOfLines = 2
        firstLabel.font = firstLabel.font.withSize(11)
        firstLabel.textAlignment = .center
        
        let inscriptionButton = UIButton()
        inscriptionButton.frame = CGRect(x: 24, y: firstLabel.frame.minY - 60, width: fieldWidth, height: 36)
        inscriptionButton.setTitle("S'inscrire", for: .normal)
        inscriptionButton.titleLabel?.textColor = UIColor.white
        inscriptionButton.backgroundColor = UIColor(white: 0, alpha: 0.5)
        inscriptionButton.titleLabel?.textAlignment = .center
        inscriptionButton.layer.cornerRadius = 10
        
        self.verifSignUpField = UITextField()
        verifSignUpField?.returnKeyType = UIReturnKeyType.continue
        verifSignUpField?.frame = CGRect(x: 24, y: inscriptionButton.frame.minY - 60, width: fieldWidth, height: 36)
        verifSignUpField?.layer.cornerRadius = 10
        verifSignUpField?.attributedPlaceholder = NSAttributedString(string: "password verification",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        verifSignUpField?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        verifSignUpField?.leftView = paddingView
        verifSignUpField?.leftViewMode = UITextField.ViewMode.always
        verifSignUpField?.tag = 1
        verifSignUpField?.keyboardAppearance = .dark
        verifSignUpField?.delegate = self
        verifSignUpField?.isSecureTextEntry = true
        
        self.passwordSignUpField = UITextField()
        passwordSignUpField?.returnKeyType = UIReturnKeyType.continue
        passwordSignUpField?.frame = CGRect(x: 24, y: (verifSignUpField?.frame.minY)! - 60, width: fieldWidth, height: 36)
        passwordSignUpField?.layer.cornerRadius = 10
        passwordSignUpField?.attributedPlaceholder = NSAttributedString(string: "password",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordSignUpField?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let secondPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        passwordSignUpField?.leftView = secondPaddingView
        passwordSignUpField?.leftViewMode = UITextField.ViewMode.always
        passwordSignUpField?.tag = 2
        passwordSignUpField?.keyboardAppearance = .dark
        passwordSignUpField?.delegate = self
        passwordSignUpField?.isSecureTextEntry = true
        
        self.usernameSignUpField = UITextField()
        usernameSignUpField?.returnKeyType = UIReturnKeyType.continue
        usernameSignUpField?.frame = CGRect(x: 24, y: (passwordSignUpField?.frame.minY)! - 60, width: fieldWidth, height: 36)
        usernameSignUpField?.layer.cornerRadius = 10
        usernameSignUpField?.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        usernameSignUpField?.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let usernamePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        usernameSignUpField?.leftView = usernamePaddingView
        usernameSignUpField?.leftViewMode = UITextField.ViewMode.always
        usernameSignUpField?.tag = 5
        usernameSignUpField?.keyboardAppearance = .dark
        usernameSignUpField?.delegate = self
        
        let imgBg = UIImageView()
        imgBg.image = UIImage(named: "background")
        imgBg.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(imgBg)
        self.view.addSubview(firstLabel)
        self.view.addSubview(inscriptionButton)
        self.view.addSubview(verifSignUpField!)
        self.view.addSubview(passwordSignUpField!)
        self.view.addSubview(usernameSignUpField!)
        
        inscriptionButton.addTarget(self, action: #selector(register), for: .touchDown)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag - 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc private func register(){
        let concurrentQueue = DispatchQueue(label: "registerQueue", attributes: .concurrent)
        
        var errors = [String]()
    
        if self.passwordSignUpField?.text == ""{
            errors.append("The password field is required")
        }
        
        if self.usernameSignUpField?.text == ""{
            errors.append("The username field is required")
        }
        
        if self.passwordSignUpField?.text != self.verifSignUpField?.text && self.passwordSignUpField?.text != ""{
            errors.append("you must enter the same password in password and verification password field")
        }
        
        if errors.count == 0{
            let parameters: Parameters = [
                "username": self.usernameSignUpField?.text ?? "",
                "password": self.passwordSignUpField?.text ?? "",
                ]
            
            
            concurrentQueue.async(execute: {
                Alamofire.request("https://obvious-or-not-api.herokuapp.com/user", method: .post, parameters: parameters).responseJSON { response in
                    //completionHandler(getPollsFromJson(response: response))
                    let jsonResponse = JSON(response.result.value as Any)
                    //print(jsonResponse)
                    if jsonResponse["status"] == 200{
                        //log the user in and redirzect him
                    }else{
                        self.showErrors(errors: [jsonResponse["error"].stringValue])
                    }
                }
            })
        }else{
            self.showErrors(errors: errors)
        }
    }
    
    private func showErrors(errors: [String]){
        var errorString = ""
        
        for singleError in errors{
            errorString += singleError + "\n"
        }
        
        AlertHelper.displaySimpleAlert(title: "error", message: errorString, type: .error)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
