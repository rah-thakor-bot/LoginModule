//
//  AccountSettingViewController.swift
//  LoginModule
//
//  Created by Rahul Thakor on 20/05/16.
//  Copyright © 2016 Rahul Thakor. All rights reserved.
//

import UIKit

class AccountSettingViewController: UIViewController {

    var window: UIWindow!

    @IBAction func logoutButton(sender: AnyObject) {
        let userObj = User()
        userObj.logoutUser()
        //Return to Login Screen
        //Get StoryBoard->Set InitialRootController->Set Navigation to rootController
        self.window = UIWindow.init(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let rootController = storyboard.instantiateViewControllerWithIdentifier("ViewController")
        let navigation = UINavigationController.init(rootViewController: rootController)
        self.window.rootViewController = navigation;
        self.window.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
