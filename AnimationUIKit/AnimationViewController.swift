import UIKit

class AnimationViewController: UIViewController {
    
    var delegate: AnimationViewDelegate?
    var animationView: AnimationView {
        view as! AnimationView
    }
    
    public override func loadView() {
        view = AnimationView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        animationView.delegate = self
        animationView.backgroundColor = .white
    }
}

extension AnimationViewController: AnimationViewDelegate {
    func didTapButton(_ view: AnimationView) {
        animationView.moveRect()
    }
}

