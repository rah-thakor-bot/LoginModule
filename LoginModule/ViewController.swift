//
//  ViewController.swift
//  LoginModule
//
//  Created by Rahul Thakor on 22/04/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var window: UIWindow!
    var emptyString = String()
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    
    // 1 Raywenderlich Code
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    // 2
    var dataTask: NSURLSessionDataTask?
    
    @IBAction func btnLogin(sender: AnyObject) {
        errorMsg.text = emptyString
        if let uname = txtUsername.text, pass = txtPassword.text where !uname.isEmpty && !pass.isEmpty {
            
            // 1
            if dataTask != nil {
                dataTask?.cancel()
            }
            // 2
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            // 3
            
            let expectedCharSet = NSCharacterSet.URLQueryAllowedCharacterSet()
            let unameTerm = uname.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
            let passTerm = pass.stringByAddingPercentEncodingWithAllowedCharacters(expectedCharSet)!
            
            // 4
            let url = NSURL(string: "http://172.16.40.39:4000/login?user_name=\(unameTerm)&password=\(passTerm)")
            // 5
            dataTask = defaultSession.dataTaskWithURL(url!) {
                data, response, error in
                // 6
                dispatch_async(dispatch_get_main_queue()) {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
                // 7
                if let error = error {
                    print(error.localizedDescription)
                } else if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        let user = User()
                        user.loginUser(unameTerm, authenticationCode: true)
                        //Get StoryBoard->Instantiate Initial ViewController->Set ViewController
                        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
                        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                        let rootController = storyboard.instantiateViewControllerWithIdentifier("HomeRootController") as! UITabBarController
                        self.window.rootViewController = rootController
                        self.window.makeKeyAndVisible()
                    }
                }
            }
            // 8
            dataTask?.resume()
        }
        else{
            if let uname = txtUsername.text
                where uname.isEmpty {
                 errorMsg.text = "Username cannot be empty"
                    return
            }
            if let pass = txtPassword.text
                where pass.isEmpty {
                    errorMsg.text = "Password cannot be empty"
                    return
            }
        }
    }
    
    @IBAction func btnCancel(sender: AnyObject) {
        txtUsername.text = emptyString
        txtPassword.text = emptyString
        errorMsg.text = emptyString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMsg.text = ""
        // Do any additional setup after loading the view, typically from a nib.
        
        //Code for hiding keyboard when tapping outside current control
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        navigationItem.title = nil
    }

}

