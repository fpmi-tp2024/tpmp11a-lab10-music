//  lab10
//
//  Created by Alexey on 27.05.2024
//

import UIKit
import MapKit
import CoreLocation

class InfoViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapInfo: MKMapView!
    let annotation = MKPointAnnotation()
    override func viewDidLoad() {
        super.viewDidLoad()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 53.893900, longitude: 27.546944)
        mapInfo.addAnnotation(annotation)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func siteShowing(_ sender: Any) {

        if let requestUrl = NSURL(string: "https://songfly.by") {
            UIApplication.shared.openURL(requestUrl as URL)
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
