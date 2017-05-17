//
//  LandingVC.swift
//  RealtimeChat
//
//  Created by jG on 2017. 5. 17..
//  Copyright © 2017년 KangJungu. All rights reserved.
//

import UIKit

class LandingVC: UIViewController {

    //세로 방향의 뷰만 가능하게함
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return .portrait
        }
    }
    
    func pushTo(viewController:ViewControllerType){
        switch viewController {
        case .conversations:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Navigation")
            as! NavVC
            self.present(vc, animated: false, completion: nil)
        case .welcome:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Welcome") as! WelcomeVC
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    //MARK: 과거 로그인한 사용자인지 아닌지 확인
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let userInformation = UserDefaults.standard.dictionary(forKey: "userInformation"){
            guard let email = userInformation["email"] as? String else{
                return
            }
            guard let password = userInformation["password"] as? String else{
                return
            }
            User.loginUser(withEmail: email, password: password, completion: {
                [weak weakSelf = self] (status) in
                DispatchQueue.main.async{
                    if status == true {
                        weakSelf?.pushTo(viewController: .conversations)
                    }else{
                        weakSelf?.pushTo(viewController: .welcome)
                    }
                    weakSelf = nil
                }
            })
        }else{
            self.pushTo(viewController: .welcome)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
