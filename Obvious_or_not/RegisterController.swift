//
//  RegisterController.swift
//  Obvious_or_not
//
//  Created by Jonathan SIMONNEY on 09/12/2018.
//  Copyright © 2018 Jonathan SIMONNEY. All rights reserved.
//

import UIKit

class RegisterController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        self.view.backgroundColor = UIColor.green
        
        let fieldWidth = self.view.frame.width - 48
        
        let firstLabel = UILabel()
        firstLabel.frame = CGRect(x: 24, y: self.view.frame.height - 96, width: fieldWidth, height: 72)
        firstLabel.text = "En m'inscrivant, j'accepte les Conditions Générales et la Politique de Confidentialité"
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
        
        let verifField = UITextField()
        verifField.returnKeyType = UIReturnKeyType.continue
        verifField.frame = CGRect(x: 24, y: inscriptionButton.frame.minY - 60, width: fieldWidth, height: 36)
        verifField.layer.cornerRadius = 10
        verifField.attributedPlaceholder = NSAttributedString(string: "Vérification du mot de passe",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        verifField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        verifField.leftView = paddingView
        verifField.leftViewMode = UITextField.ViewMode.always
        verifField.tag = 1
        verifField.keyboardAppearance = .dark
        verifField.delegate = self
        verifField.isSecureTextEntry = true
        
        let passwordField = UITextField()
        passwordField.returnKeyType = UIReturnKeyType.continue
        passwordField.frame = CGRect(x: 24, y: verifField.frame.minY - 60, width: fieldWidth, height: 36)
        passwordField.layer.cornerRadius = 10
        passwordField.attributedPlaceholder = NSAttributedString(string: "mot de passe",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let secondPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        passwordField.leftView = secondPaddingView
        passwordField.leftViewMode = UITextField.ViewMode.always
        passwordField.tag = 2
        passwordField.keyboardAppearance = .dark
        passwordField.delegate = self
        passwordField.isSecureTextEntry = true
        
        let emailField = UITextField()
        emailField.returnKeyType = UIReturnKeyType.continue
        emailField.frame = CGRect(x: 24, y: passwordField.frame.minY - 60, width: fieldWidth, height: 36)
        emailField.layer.cornerRadius = 10
        emailField.attributedPlaceholder = NSAttributedString(string: "Email",
                                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        emailField.leftView = emailPaddingView
        emailField.leftViewMode = UITextField.ViewMode.always
        emailField.tag = 3
        emailField.keyboardAppearance = .dark
        emailField.keyboardType = .emailAddress
        emailField.delegate = self
        
        let nameField = UITextField()
        nameField.returnKeyType = UIReturnKeyType.continue
        nameField.frame = CGRect(x: 24, y: emailField.frame.minY - 60, width: fieldWidth, height: 36)
        nameField.layer.cornerRadius = 10
        nameField.attributedPlaceholder = NSAttributedString(string: "Nom",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        nameField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        nameField.leftView = namePaddingView
        nameField.leftViewMode = UITextField.ViewMode.always
        nameField.tag = 4
        nameField.keyboardAppearance = .dark
        nameField.delegate = self
        
        let firstNameField = UITextField()
        firstNameField.returnKeyType = UIReturnKeyType.continue
        firstNameField.frame = CGRect(x: 24, y: nameField.frame.minY - 60, width: fieldWidth, height: 36)
        firstNameField.layer.cornerRadius = 10
        firstNameField.attributedPlaceholder = NSAttributedString(string: "Prénom",
                                                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        firstNameField.backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        let firstNamePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 36))
        firstNameField.leftView = firstNamePaddingView
        firstNameField.leftViewMode = UITextField.ViewMode.always
        firstNameField.tag = 5
        firstNameField.keyboardAppearance = .dark
        firstNameField.delegate = self
        
        let imgBg = UIImageView()
        imgBg.image = UIImage(named: "background")
        imgBg.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        self.view.addSubview(imgBg)
        self.view.addSubview(firstLabel)
        self.view.addSubview(inscriptionButton)
        self.view.addSubview(verifField)
        self.view.addSubview(passwordField)
        self.view.addSubview(emailField)
        self.view.addSubview(nameField)
        self.view.addSubview(firstNameField)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
