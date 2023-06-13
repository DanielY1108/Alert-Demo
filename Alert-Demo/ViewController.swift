//
//  ViewController.swift
//  Alert-Demo
//
//  Created by JINSEOK on 2023/06/13.
//

import UIKit

class ViewController: UIViewController {
    
    // 기본 Alert
    lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 150, y: 530, width: 100, height: 50))
        button.addTarget(self, action: #selector(buttonHandler), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        config.title = "Go Alert"
        button.configuration = config
        
        return button
    }()
    
    // 커스텀 Alert
    lazy var customAlertButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 130, y: 600, width: 140, height: 50))
        button.addTarget(self, action: #selector(customAlertButtonHandler), for: .touchUpInside)
        
        var config = UIButton.Configuration.filled()
        config.title = "Custom Alert"
        button.configuration = config
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        view.addSubview(customAlertButton)

    }
    
    @objc func buttonHandler(_ sender: UIButton) {
        setupAlert()
    }
    
    
    @objc func customAlertButtonHandler(_ sender: UIButton) {
        let customAlert = CustomAlertController(logImage: UIImage(named: "myProfile")!,
                                                titleText: "공지",
                                                messegeText: "많은 댓글 부탁드려요.",
                                                doneButtonTitle: "확인",
                                                cancelButtonTitle: "취소 없음")
        customAlert.doneButtonCompletoin = {
            // 확인 동작을 정의
        }
        
        customAlert.cancelButtonCompletoin = {
            // 취소 동작을 정의
        }
        
        self.present(customAlert, animated: true)
    }

    func setupAlert() {
        let alert = UIAlertController(title: "로그인",
                                      message: "ID와 Password를 입력해주세요.",
                                      preferredStyle: .alert)
        alert.view.tintColor = .red
        alert.view.backgroundColor = .blue
        alert.view.layer.cornerRadius = 18
        alert.view.clipsToBounds = true
        
        let titleAttributedString = NSAttributedString(string: "로그인",
                                                       attributes: [NSAttributedString.Key.foregroundColor : UIColor.green,
                                                                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30, weight: .bold)])
        let messageAttributedString = NSAttributedString(string: "ID와 Password를 입력해주세요.",
                                                         attributes: [NSAttributedString.Key.foregroundColor : UIColor.orange])
        
        alert.setValue(titleAttributedString, forKey: "attributedTitle")
        alert.setValue(messageAttributedString, forKey: "attributedMessage")
        
        alert.addTextField { textField in
            textField.placeholder = "ID를 입력해주세요."
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Password를 입력해주세요."
        }

        let doneAction = UIAlertAction(title: "확인",
                                       style: .default) { action in
            // 동작을 설정
        }
    
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .cancel) { action in
            // 동작을 설정
        }
        
        alert.addAction(doneAction)
        alert.addAction(cancelAction)
        alert.modalPresentationStyle = .overCurrentContext
//        alert.view.backgroundColor = UIColor.clear
        alert.view.isOpaque = false
        self.present(alert, animated: true)
    }
}
