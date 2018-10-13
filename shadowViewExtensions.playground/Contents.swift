// Playground to show a UIView extension to add drop shadows to a view

/*
 Extension specifically solves the problem of adding a corner radius to a view and at the same time adding a drop shadow.
 Extension works by creating a new view behind the view.
 This allows the orginal view to have a clip to bounds to true value added so any subviews of this view don't spill out over the corner radius.
 For added functionality to support multiple shadows for different views the ShadowParams struct was created to support functions of the various shadows
 */
  
import UIKit
import PlaygroundSupport

struct ShadowParams {
    let shadowColor: CGColor
    let shadowOffSet: CGSize
    let shadowOpacity: Float
    let shadowRadius: CGFloat
}

func shadowParamsForRedSquare() -> ShadowParams {
    return ShadowParams(shadowColor: UIColor.red.cgColor, shadowOffSet: CGSize(width: 3, height: -3), shadowOpacity: 0.5, shadowRadius: 4.0)
}

func shadowParamsForBlueSquare() -> ShadowParams {
        return ShadowParams(shadowColor: UIColor.blue.cgColor, shadowOffSet: CGSize(width: -3, height: 3), shadowOpacity: 0.5, shadowRadius: 4.0)
}

class MyViewController : UIViewController {
    
    let backgroundView = UIView()
    let redView = UIView()
    let blueView = UIView()
    let yellowView = UIView()
    let greenView = UIView()
    
    override func loadView() {
        
        backgroundView.backgroundColor = .white
        redView.backgroundColor = .red
        blueView.backgroundColor = .blue
        yellowView.backgroundColor = .yellow
        greenView.backgroundColor = .green
        self.view = backgroundView
        
        addSubViews()
        styleViews()
    }
    
    private func addSubViews(){
        view.addSubview(redView)
        redView.addSubview(yellowView)
        view.addSubview(blueView)
        blueView.addSubview(greenView)
    }
    
    private func styleViews(){
        redView.frame = CGRect(x: 140, y: 20, width: 100, height: 100)
        redView.addViewShadowWith(shadowParamsForRedSquare())
        
        blueView.frame = CGRect(x: 20, y: 20, width: 100, height: 100)
        blueView.layer.cornerRadius = 5
        blueView.clipsToBounds = true
        blueView.addViewShadowWith(shadowParamsForBlueSquare())
        
        yellowView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        greenView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
    }
}

extension UIView {
    func addViewShadow() {
        let shadowView = UIView()
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.cornerRadius = self.layer.cornerRadius
        shadowView.layer.shadowOffset = CGSize(width: -3, height: 3)
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowRadius = 4.0
        shadowView.frame = self.frame
        shadowView.clipsToBounds = false
        shadowView.backgroundColor = .white
        self.superview?.insertSubview(shadowView, belowSubview: self)
    }
    
    func addViewShadowWith(_ shadowParams: ShadowParams) {
        let shadowView = UIView()
        shadowView.layer.shadowColor = shadowParams.shadowColor
        shadowView.layer.shadowOffset = shadowParams.shadowOffSet
        shadowView.layer.shadowOpacity = shadowParams.shadowOpacity
        shadowView.layer.shadowRadius = shadowParams.shadowRadius
        shadowView.layer.cornerRadius = self.layer.cornerRadius
        shadowView.frame = self.frame
        shadowView.clipsToBounds = false
        shadowView.backgroundColor = .white
        shadowView.backgroundColor?.withAlphaComponent(0.0)
        self.superview?.insertSubview(shadowView, belowSubview: self)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
