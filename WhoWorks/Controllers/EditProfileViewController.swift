//
//  EditProfileViewController.swift
//  WhoWorks
//
//  Created by Медведь Святослав on 25.02.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var loginNameTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var currentUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        initCurrenUserUIAndContent()
        loginNameTextField.delegate = self
        fullNameTextField.delegate = self
        statusTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func keyboardWillShow(notification: NSNotification) {
        adjustingHeight(true, notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(false, notification)
    }
    
    private func adjustingHeight(_ show: Bool, _ notification: NSNotification) {
        var userInfo = notification.userInfo!
        let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let animationDurarion = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: animationDurarion, animations: { height in
            self.view.frame.origin.y = show ? -keyboardFrame.height : 0
        })
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case loginNameTextField:
                fullNameTextField.becomeFirstResponder()
            case fullNameTextField:
                statusTextField.becomeFirstResponder()
            default:
                statusTextField.resignFirstResponder()
        }
        return true
    }
    
    private func initCurrenUserUIAndContent() {
        deleteButton.layer.cornerRadius = 4.0
        avatarImageView.layer.cornerRadius = 80.0
        UICustomizationService.defaultTextFieldUI(loginNameTextField, placeholder: "Login name")
        UICustomizationService.defaultTextFieldUI(fullNameTextField, placeholder: "Full name")
        UICustomizationService.defaultTextFieldUI(statusTextField, placeholder: "Status")
        
        avatarImageView.image = currentUser?.avatar
        loginNameTextField.text = currentUser?.login
        fullNameTextField.text = currentUser?.fullName
        statusTextField.text = currentUser?.status
    }
    
    @IBAction func loginNameTextFieldEditing(_ sender: UITextField) {
        if ValidationService.checkPresence(sender.text) && (sender.text?.characters.count)! > 2 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    @IBAction func deleteAccount(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure to delete account?", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
            alert.dismiss(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            if UserService.destroyUser((self.currentUser?.id)!) {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "LoginView") as! LoginViewController
                self.present(loginVC, animated: true)
            } else {
                alert.dismiss(animated: true)
                let newAlert = UIAlertController(title: "Ooop!", message: "Something went wrong!", preferredStyle: .alert)
                    newAlert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                self.present(newAlert, animated: true)
            }
        }))
        
        self.present(alert, animated: true)
    }
}
