//  lab10
//
//  Created by Alexey on 27.05.2024
//
import Foundation
import UIKit

open class ShowInfolWindow: UILabel {
    
    var firView = UIView()
    var backView = UIView()
    var labelT = UILabel()
    
    func setup(_ view: UIView,txt_msg:String) {
        let white = UIColor(red: 1/255, green: 0/255, blue:0/255, alpha: 0.0 )

        firView.frame = CGRect(x: 0, y: 0, width: view.frame.width - 60 , height: 50)
        firView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 100)
        firView.backgroundColor = UIColor.yellow
     
        
        backView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height)
        backView.center = view.center
        backView.backgroundColor = white
        view.addSubview(backView)
        
        labelT.frame = CGRect(x: 0, y: 0, width: firView.frame.width, height: 50)
        labelT.numberOfLines = 0
        labelT.textColor = UIColor.black
        labelT.center = firView.center
        labelT.text = txt_msg
        labelT.textAlignment = .center
        labelT.center = CGPoint(x: firView.bounds.width / 2, y: firView.bounds.height / 2)
        firView.addSubview(labelT)
        view.addSubview(firView)
    }
    
    class var shared: ShowInfolWindow {
        struct Static {
            static let instance: ShowInfolWindow = ShowInfolWindow()
        }
        return Static.instance
    }
    
    open func short(_ view: UIView,txt_msg:String) {
        self.setup(view,txt_msg: txt_msg)
        UIView.animate(withDuration: 1, animations: {
            self.firView.alpha = 1
        }) {
            (true) in UIView.animate(withDuration: 1, animations: {
                self.firView.alpha = 0
            }) {
                (true) in UIView.animate(withDuration: 1, animations: {
                    DispatchQueue.main.async(execute: {
                        self.firView.alpha = 0
                        self.labelT.removeFromSuperview()
                        self.firView.removeFromSuperview()
                        self.backView.removeFromSuperview()
                    })
                })
            }
        }
    }
}
