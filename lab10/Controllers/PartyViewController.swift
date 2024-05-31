//  lab10
//
//  Created by Alexey on 27.05.2024
//
import UIKit
import MapKit
import CoreLocation

class PartyViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var busnumbersLabel: UILabel!
    let manager = CLLocationManager()
    var prices = [String]()
    var placesAut = [String]()
    var variantsNumb:[(placesAut: String, number: String)] = []
    var userLocationLatitude = 1.0
    var userLocationLongitude = 1.0
    
    let sqlStatement1 = "CREATE TABLE IF NOT EXISTS PricesAndBusstops(id INTEGER UNIQUE, price DOUBLE, transport TEXT);"
    let sqlStatement2 = "CREATE TABLE IF NOT EXISTS BusesNumbers(id INTEGER PRIMARY KEY AUTOINCREMENT, transport TEXT, busnumber TEXT);"
    let insertStatement1 = "INSERT OR IGNORE INTO PricesAndBusstops(id, price, transport) VALUES (1, 99, 'Кунцевщина'), (2, 80, 'Масюковщина'), (3, 69, 'Кирова'), (4, 113, 'Славинского');"
    let insertStatement2 = "INSERT OR IGNORE INTO BusesNumbers(id, transport, busnumber) VALUES (1, 'Кунцевщина','40'), (2, 'Масюковщина', '69'), (3, 'Кирова', '1'), (4, 'Славинского', '100');"
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        let fileManager = FileManager()
        var sqliteDB: OpaquePointer? = nil
        var dataBases: NSURL? = nil
        do {
            let baseUrl = try
                fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            dataBases = baseUrl.appendingPathComponent("swiftDB.sqlite") as NSURL
        } catch {
            print(error)
        }
        if let dataBases = dataBases {
            let flags = SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE
            let status = sqlite3_open_v2(dataBases.absoluteString?.cString(using: String.Encoding.utf8), &sqliteDB, flags, nil)
            if status == SQLITE_OK {
                let errMsg: UnsafeMutablePointer<UnsafeMutablePointer<Int8>?>! = nil
                
                if (!(sqlite3_exec(sqliteDB, sqlStatement1, nil, nil, errMsg) == SQLITE_OK)) {
                    print("Failed to create first table")
                }
                if (!(sqlite3_exec(sqliteDB, sqlStatement2, nil, nil, errMsg) == SQLITE_OK)) {
                    print("Failed to create second table")
                }
                var statement: OpaquePointer? = nil
                sqlite3_prepare_v2(sqliteDB, insertStatement1, -1, &statement, nil)
                if (!(sqlite3_step(statement) == SQLITE_DONE)) {
                    print("Error during first insert")
                }
                sqlite3_prepare_v2(sqliteDB, insertStatement2, -1, &statement, nil)
                if (!(sqlite3_step(statement) == SQLITE_DONE)) {
                    print("Error during second insert")
                }
                sqlite3_finalize(statement)
                var selectStatement: OpaquePointer? = nil
                var selectSql = "select * from PricesAndBusstops"
                if sqlite3_prepare_v2(sqliteDB, selectSql, -1, &selectStatement, nil) == SQLITE_OK {
                    while sqlite3_step(selectStatement) == SQLITE_ROW {
                        let price = String(cString: UnsafePointer<UInt8>(sqlite3_column_text(selectStatement, 1)))
                        let transport = String(cString: UnsafePointer<UInt8>(sqlite3_column_text(selectStatement, 2)))
                        prices.append(price)
                        placesAut.append(transport)
                    }
                }
                selectSql = "select * from BusesNumbers"
                if sqlite3_prepare_v2(sqliteDB, selectSql, -1, &selectStatement, nil) == SQLITE_OK {
                    while sqlite3_step(selectStatement) == SQLITE_ROW {
                        let transport = String(cString: UnsafePointer<UInt8>(sqlite3_column_text(selectStatement, 1)))
                        let busNumber = String(cString: UnsafePointer<UInt8>(sqlite3_column_text(selectStatement, 2)))
                        variantsNumb.append((placesAut: transport, number: busNumber))
                    }
                }
                sqlite3_finalize(selectStatement)
            }
        }
        var idx: Int = 0
        if arc4random_uniform(2) == 0 {
            idx = 1
        }
        priceLabel.text = prices[idx] + " BYN"
        let requiredNumbers = variantsNumb.filter({$0.placesAut == placesAut[idx]})
        var numbersString: String = "Поезда\n"
        for i in 0..<requiredNumbers.count-1 {
            numbersString += String("А: " + requiredNumbers[i].number + "\n")
        }
        numbersString += String("№ " + requiredNumbers[requiredNumbers.count - 1].number)
        busnumbersLabel.text = numbersString
        let lawyerLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(53.893900, 27.546944)
        let annotation = MKPointAnnotation()
        annotation.coordinate = lawyerLocation
        annotation.title = "Офис SongFly"
        mapView.addAnnotation(annotation)
        let sourceLocation = CLLocationCoordinate2D(latitude: (manager.location?.coordinate.latitude)! , longitude: (manager.location?.coordinate.longitude)!)
        let destinationLocation = CLLocationCoordinate2D(latitude: lawyerLocation.latitude , longitude: lawyerLocation.longitude)
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            let route = directionResonse.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            let polylines = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(polylines), animated: true)
        }
        self.mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        userLocationLatitude = location.coordinate.latitude
        userLocationLongitude = location.coordinate.longitude
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let wayMap = MKPolylineRenderer(overlay: overlay)
        wayMap.strokeColor = UIColor.black
        wayMap.lineWidth = 4.0
        return wayMap
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

