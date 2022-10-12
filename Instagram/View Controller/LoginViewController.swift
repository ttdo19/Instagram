//
//  LoginViewController.swift
//  Instagram
//
//  Created by Trang Do on 10/9/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.text = "Username"
        passwordField.text = "Password"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func usernameChanged(_ sender: Any) {
        usernameField.text = ""
    }
    
    
    @IBAction func passwordEdited(_ sender: Any) {
        passwordField.text = ""
        passwordField.isSecureTextEntry = true
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        if usernameAndPasswordNotEmpty() {
            let username = usernameField.text!
            let password = passwordField.text!
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
                if user != nil {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    print("Error: \(String(describing: error?.localizedDescription))")
                    self.displayLoginError(error: error!)
                }
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        if usernameAndPasswordNotEmpty() {
            let user = PFUser()
            user.username = self.usernameField.text
            user.password = self.passwordField.text
            
            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                } else {
                    print("Error: \(String(describing: error?.localizedDescription))")
                    self.displaySignupError(error: error!)
                }
            }
        }
    }
    
    func usernameAndPasswordNotEmpty() -> Bool {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            displayError()
            return false
        } else {
            return true
        }
    }
    
    func displayError() -> Void {
        let title = "Error"
        let message = "Username and password field cannot be empty"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        //add the OK Action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    func displayLoginError(error: Error) -> Void {
        let title = "Login Error"
        let message = "Oops! Something went wrong while logging in: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        //add the OK Action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    func displaySignupError(error: Error) -> Void {
        let title = "Login Error"
        let message = "Oops! Something went wrong while signing up: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        //create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        //add the OK Action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
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
