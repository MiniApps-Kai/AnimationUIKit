//
//  ViewController.swift
//  AnimationUIKit
//
//  Created by 渡邊魁優 on 2024/06/11.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var delegate: AnimationViewDelegate?
    
    public override func loadView() {
        let view = AnimationView()
        self.view = view
        view.delegate = self
        view.backgroundColor = .white
    }
}

extension AnimationViewController: AnimationViewDelegate {
    func didTapButton(_ view: AnimationView) {
        view.moveRect()
    }
}

