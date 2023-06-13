//
//  CustomAlertController.swift
//  Alert-Demo
//
//  Created by JINSEOK on 2023/06/13.
//

import UIKit
import SnapKit

class CustomAlertController: UIViewController {
    
    private let alertView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let messegeLable = UILabel()
    private let doneButton = UIButton()
    private let cancelButton = UIButton()
    
    private var logoImage: UIImage?
    private var titleText: String?
    private var messegeText: String?
    private var doneButtonTitle: String?
    private var cancelButtonTitle: String?
    
    // 버튼의 동작을 담아서 사용하기 위해 만들어 줌.
    var doneButtonCompletoin: (()-> Void)?
    var cancelButtonCompletoin: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) { [weak self] in
            // 확대된 효과를 처음 크기로으로 되돌리기
            self?.alertView.transform = .identity
        }
    }

    // 여긴 그냥 레이아웃 및 설정들 (모양은 원하는 대로 만들기)
    private func setupUI() {
        // 이전 VC 배경이 살짝 어두워지는 효과
        self.view.backgroundColor = .black.withAlphaComponent(0.2)
        
        // 처음 생성 될 때, 살짝 커지는 효과(viewWillAppear, viewWillDisappear에서 애니메이션 효과를 만들어 줌)
        self.alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 15
        alertView.clipsToBounds = true
        
        view.addSubview(alertView)
        alertView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(160)
        }
        
        alertView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
            $0.height.width.equalTo(60)
        }
        imageView.layer.cornerRadius = 30

        alertView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        
        alertView.addSubview(messegeLable)
        messegeLable.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        messegeLable.font = .preferredFont(forTextStyle: .body)
        
        let vStack = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        vStack.axis = .horizontal
        vStack.distribution = .fillEqually
        vStack.spacing = 15
        
        cancelButton.layer.cornerRadius = 15
        cancelButton.backgroundColor = .systemRed
        cancelButton.addTarget(self, action: #selector(cancelButtonHandler), for: .touchUpInside)

        doneButton.layer.cornerRadius = 15
        doneButton.backgroundColor = .systemBlue
        doneButton.addTarget(self, action: #selector(doneButtonHandler), for: .touchUpInside)
        
        alertView.addSubview(vStack)
        vStack.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(15)
            $0.height.equalTo(45)
        }
    }
}

extension CustomAlertController {
    // 생성 시, 각각의 Label 및 이지미를 설정 할 있게 만듬
    convenience init(logImage: UIImage, titleText: String, messegeText: String, doneButtonTitle: String, cancelButtonTitle: String) {
        self.init()
        
        imageView.image = logImage
        titleLabel.text = titleText
        messegeLable.text = messegeText
        cancelButton.setTitle(cancelButtonTitle, for: .normal)
        doneButton.setTitle(doneButtonTitle, for: .normal)
        
        // 이 부분이 중요하다.
        // crossDissolve는 VC가 생성되는 동시에 나타나서 조금 더 자연스럽게 창이 생성되게 만들 수 있다.
        self.modalTransitionStyle = .crossDissolve
        // ⭐️ 만약 fullScreen을 사용하게 되면, VC가 생성이 완료되면 이전 VC가 제거된다.
        // overFullScreen은 말그대로 덮는 형식으로 생성이 되서 이전 VC가 유지된다.
        self.modalPresentationStyle = .overFullScreen
    }
}

extension CustomAlertController {
    @objc func doneButtonHandler(_ sender: UIButton) {
        doneButtonCompletoin?()
        self.dismiss(animated: true)
    }
    
    @objc func cancelButtonHandler(_ sender: UIButton) {
        cancelButtonCompletoin?()
        self.dismiss(animated: true)
    }
}
