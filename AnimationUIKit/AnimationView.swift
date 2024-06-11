//
//  AnimationView.swift
//  AnimationUIKit
//
//  Created by 渡邊魁優 on 2024/06/11.
//

import Foundation
import UIKit

protocol AnimationViewDelegate: AnyObject {
    func didTapButton(_ view: AnimationView)
}

class AnimationView: UIView {
    
    var delegate: AnimationViewDelegate?
    
    private var button: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemCyan
        button.setTitle("START", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.isHidden = true
        button.alpha = 0
        return button
    }()
    
    private var rect: UIView = {
        var rect = UIView()
        rect.backgroundColor = UIColor.red
        rect.layer.cornerRadius = 10
        rect.translatesAutoresizingMaskIntoConstraints = false
        
        rect.isHidden = true
        rect.alpha = 0
        return rect
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    func moveRect() {
        print("##: start moving rect \(rect.constraints)")
        let newConstraints = [
            rect.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 100),
            rect.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            rect.widthAnchor.constraint(equalToConstant: 200),
            rect.heightAnchor.constraint(equalToConstant: 200)
        ]
        rect
            .removeConstraints(rect.constraints)
        NSLayoutConstraint.activate(newConstraints)
        
        UIView.animate(withDuration: 1.0) {
            self.layoutIfNeeded()
            print("##: called animate")
        }
        print("##: end moving rect \(rect.constraints)")
    }
    
    @objc private func didTapButton() {
        delegate?.didTapButton(self)
    }
    
    private func setup() {
        addSubview(button)
        addSubview(rect)
        
        NSLayoutConstraint.activate([
                    button.centerXAnchor.constraint(equalTo: centerXAnchor),
                    button.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 100),
                    button.widthAnchor.constraint(equalToConstant: 200),
                    button.heightAnchor.constraint(equalToConstant: 50),
                    rect.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -100),
                    rect.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
                    rect.widthAnchor.constraint(equalToConstant: 200),
                    rect.heightAnchor.constraint(equalToConstant: 200)
                ])
        
        button.isHidden = false
        rect.isHidden = false
        UIView.animate(withDuration: 1.0) {
            self.button.alpha = 1
            self.rect.alpha = 1
        }
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
}
