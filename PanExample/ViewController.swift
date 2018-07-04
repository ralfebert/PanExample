import UIKit

class MoveSupport {

    var animator : UIDynamicAnimator

    init(moveableView : UIView) {
        self.animator = UIDynamicAnimator(referenceView: moveableView.superview!)

        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        moveableView.addGestureRecognizer(recognizer)

    }

    @objc func pan(_ recognizer : UIPanGestureRecognizer) {
        let view = recognizer.view!

        switch(recognizer.state) {

        case .began:
            animator.removeAllBehaviors()

        case .changed:
            let translation = recognizer.translation(in: view)
            view.center.x += translation.x
            view.center.y += translation.y
            recognizer.setTranslation(.zero, in: view)

        case .ended:
            let velocity = recognizer.velocity(in: view)

            let behavior = UIDynamicItemBehavior(items: [view])
            behavior.addLinearVelocity(velocity, for: view)
            behavior.resistance = 3.0
            animator.addBehavior(behavior)

        default:
            break
        }
    }

}

class ViewController : UIViewController {

    @IBOutlet weak var tileView: UIView!
    var moveSupport: MoveSupport!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.moveSupport = MoveSupport(moveableView: tileView)
    }


}
