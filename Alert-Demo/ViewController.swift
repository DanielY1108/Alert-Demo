//
//  ViewController.swift
//  Alert-Demo
//
//  Created by JINSEOK on 2023/06/13.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var button: UIButton = {
        
        let button = UIButton(frame: CGRect(x: 150, y: 530, width: 100, height: 50),
                              primaryAction: UIAction(handler: { [weak self] action in
            self?.setupAlert()
        }))
        
        var config = UIButton.Configuration.filled()
        config.title = "Go Alert"
        button.configuration = config
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
    }

    func setupAlert() {
        let alert = UIAlertController(title: "로그인",
                                      message: "ID와 Password를 입력해주세요.",
                                      preferredStyle: .alert)
        alert.view.tintColor = .red
        alert.view.backgroundColor = .blue
        alert.view.layer.cornerRadius = 16
        alert.view.layer.masksToBounds = true

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
        
        self.present(alert, animated: true)
    }

}



