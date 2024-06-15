import Foundation
import UIKit

protocol AnimationViewDelegate: AnyObject {
    func didTapButton(_ view: AnimationView)
}

class AnimationView: UIView {
    
    var delegate: AnimationViewDelegate?
    var rectConstraints: [NSLayoutConstraint] = []
    
    var button: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = UIColor.systemCyan
        button.setTitle("START", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var rect: UIView = {
        var rect = UIView()
        rect.backgroundColor = UIColor.red
        rect.layer.cornerRadius = 10
        rect.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.deactivate(rectConstraints)
        rectConstraints = [
            rect.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            rect.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            rect.widthAnchor.constraint(equalToConstant: 100),
            rect.heightAnchor.constraint(equalToConstant: 100)
        ]
        NSLayoutConstraint.activate(rectConstraints)

        UIView.animate(withDuration: 1.0) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func didTapButton() {
        delegate?.didTapButton(self)
    }
    
    private func setup() {
        addSubview(button)
        addSubview(rect)
        
        // 初期位置の制約
        rectConstraints = [
            rect.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            rect.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            rect.widthAnchor.constraint(equalToConstant: 100),
            rect.heightAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.centerYAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50),
        ] + rectConstraints)
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
}
