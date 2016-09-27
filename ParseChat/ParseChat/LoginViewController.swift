//
//  ViewController.swift
//  ParseChat
//
//  Created by Jonathan Wang on 9/26/16.
//  Copyright © 2016 JonathanWang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signUp(sender: AnyObject) {
        if(emailTF.text == ""){
            alert("Email is empty.",t:"Please enter your email.")
        }
        else if(passwordTF.text == ""){
            alert("Password is empty.",t:"Please enter your password.")
        }
        else{
            let user = PFUser()
            //user.email = emailTF.text
            user.username = emailTF.text
            user.password = passwordTF.text
            user.signUpInBackgroundWithBlock({ (succeeded, error) -> Void in
                if (error == nil) {
                    // Hooray! Let them use the app now.
                    self.alert("User has been created", t:"Account was successfully created.")
                }
                else {
                    self.alert("Error",t:"Unable to create account.")
                    // Show the errorString somewhere and let the user try again.
                }
            })
        }
    }

    @IBAction func login(sender: AnyObject) {
        if(emailTF.text == ""){
          alert("Email is empty.",t:"Please enter your email.")
        }
        else if(passwordTF.text == ""){
            alert("Password is empty.",t:"Please enter your password.")
        }
        else{
            PFUser.logInWithUsernameInBackground(emailTF.text!, password: passwordTF.text!, block:{(user, error) -> Void in
                if((user) == nil){
                    self.alert("Invalid username or password. Please try again.", t: "Unable to login")
                }
                else{
                    
                    
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("chatView") as! ChatViewController
                    self.presentViewController(nextViewController, animated:true, completion:nil)
                   
                    
                }
            })
        }
    }
    
    func alert(m : String, t:String) {
        let alertController = UIAlertController(title: t, message: m, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        alertController.addAction(OKAction)
        presentViewController(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
}

