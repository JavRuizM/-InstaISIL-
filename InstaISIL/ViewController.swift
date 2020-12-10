//
//  ViewController.swift
//  InstaISIL
//
//  Created by user179028 on 11/11/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var constraintCenterYContentView: NSLayoutConstraint!
    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        txtUsuario.placeholder = "Usuario"
        txtPassword.placeholder = "Contraseña"
    }
    
    @IBAction func clickBtnCloseKeyboard(_ sender: Any){
    self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        let keyboardOrigin = keyboardFrame.origin.y
        let finalPosyContentView = self.contentView.frame.origin.y + self.contentView.frame.height
        
        var delta: CGFloat = 0
        let spaceKeyboardToContent: CGFloat = 25
        
        if keyboardOrigin < finalPosyContentView{
            delta = keyboardOrigin - finalPosyContentView - spaceKeyboardToContent
        }
        
        UIView.animate(withDuration: animationDuration){
            self.constraintCenterYContentView.constant = delta
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration){
            self.constraintCenterYContentView.constant = 0
            self.view.layoutIfNeeded()
        }
    }

}

