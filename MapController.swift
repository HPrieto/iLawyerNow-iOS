//
//  MapController.swift
//  iLawyerNow
//
//  Created by Heriberto Prieto on 11/13/17.
//  Copyright © 2017 Heriberto Prieto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    /* Global Variables */
    let locationManager = CLLocationManager()
    let LATDELTA:CLLocationDegrees = 0.045
    let LONDELTA:CLLocationDegrees = 0.045
    let LOWERED:CGFloat = -240
    let RAISED:CGFloat = 0
    let GRADUAL:Double = 0.5
    let INSTANT:Double = 0.0
    let APPEAR:CGFloat = 1.0
    let DISAPPEAR:CGFloat = 0.0
    /* MapController Views */
    /* MapView UIComponents */
    let map: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        return mapView
    }()
    let myLocationButton:UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "my_location_white"), for: .normal)
        button.alpha = 0
        button.backgroundColor = UIColor.blue
        button.layer.cornerRadius = 16
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(MapController.myLocationButtonClicked), for: .touchUpInside)
        return button
    }()
    /* myLocationButton touch up inside action listener */
    @objc func myLocationButtonClicked() {
        self.initializeLocationTracking()
        self.animateMyLocationButtonDisappear()
    }
    /* MapController LifeCycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapController viewDidLoad")
        self.map.delegate = self
        self.addSubviews()
        self.initializeView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Initialize additional MapController event listeners
        self.initAdditionalEventListeners()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MapController viewDidAppear")
        // Initialize Location Manager
        self.initializeLocationManager()
        self.initializeLocationTracking()
        // Initialize Views
        // Set designs
    }
    func initializeNavigationBarDesign(navigationBar:UINavigationBar,height:CGFloat) {
        navigationBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: height)
    }
    /* Sets locationManager object to MapContainer */
    func initializeLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    /* More MapController Event Listeners */
    func initAdditionalEventListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(MapController.applicationDidBecomeActive),     name: .UIApplicationDidBecomeActive,     object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapController.applicationDidEnterBackground),  name: .UIApplicationDidEnterBackground,  object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapController.applicationWillResignActive),    name: .UIApplicationWillResignActive,    object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapController.applicationWillEnterForeground), name: .UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapController.applicationWillTerminate),       name: .UIApplicationWillTerminate,       object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapController.applicationDidFinishLaunching),  name: .UIApplicationDidFinishLaunching,  object: nil)
    }
    @objc func applicationDidFinishLaunching() {
        print("MapController: applicationDidFinishLaunching")
    }
    @objc func applicationDidBecomeActive() {
        print("MapController: applicationDidBecomeActive")
    }
    @objc func applicationDidEnterBackground() {
        print("MapController: applicationDidEnterBackground")
    }
    @objc func applicationWillResignActive() {
        print("MapController: applicationWillResignActive")
    }
    @objc func applicationWillEnterForeground() {
        print("MapController: applicationWillEnterForeground")
    }
    @objc func applicationWillTerminate() {
        print("MapController: applicationWillTerminate")
    }
    /* Centers map around given coordinate of type CLLocationCoordinate2D */
    func centerMapOnCoordinate(coordinate:CLLocationCoordinate2D) {
        let mkSpan                      = MKCoordinateSpanMake(self.LATDELTA, self.LONDELTA)
        let mkRegion                    = MKCoordinateRegionMake(coordinate, mkSpan)
        self.map.setRegion(mkRegion, animated: true)
    }
    /* Centers map around given location of data type CLLocation */
    func centerMapOnLocation(location:CLLocation) {
        let latitude   = location.coordinate.latitude
        let longitude  = location.coordinate.longitude
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mkSpan     = MKCoordinateSpanMake(self.LATDELTA, self.LONDELTA)
        let mkRegion   = MKCoordinateRegionMake(coordinate, mkSpan)
        self.map.setRegion(mkRegion, animated: true)
    }
    /* LocationManager override methods */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager: Did Fail With Error => \(error.localizedDescription)")
    }
    /* Called after locationManager gets user's new location coordinates */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation   = locations[0]
        let userLatitude   = userLocation.coordinate.latitude
        let userLongitude  = userLocation.coordinate.longitude
        let userCoordinate = CLLocationCoordinate2DMake(userLatitude, userLongitude)
    }
    /* Called after user changes location permissions */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("LocationManager did change authorization: \(status)")
        self.initializeLocationTracking()
    }
    /* Called if user's location is not able to be read */
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print("Map did fail to locate user with error: \(error.localizedDescription)")
    }
    /* Called when locationManager gets user's new location */
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    }
    /* Called before mapRegion has changed */
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        print("MapRegion is about to change.")
    }
    /* Called after mapRegion has finished changing */
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.setActionViewAddressLabelText(coordinate: mapView.centerCoordinate)
    }
    /* Sets the text in ActionView AddressLabel to Address gecoded from coordinates */
    func setActionViewAddressLabelText(location:CLLocation) {
        var address  = ""
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if(error == nil) {
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                if let city = placeMark.addressDictionary!["City"] as? NSString {
                    address += city as String
                }
            } else {
                address = "Location Unavailable"
            }
        })
    }
    /* Converts Location into string address representation */
    func setActionViewAddressLabelText(coordinate:CLLocationCoordinate2D) {
        var address  = ""
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if(error == nil) {
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                if let city = placeMark.addressDictionary!["City"] as? NSString {
                    address += city as String
                }
            } else {
                address = "iLawyerNow"
            }
        })
    }
    /* Performs action depending on user location permissions granted */
    func initializeLocationTracking() {
        if CLLocationManager.locationServicesEnabled() {
            switch (CLLocationManager.authorizationStatus()) {
            case .denied:
                print("Location services: denied")
                break
            case .notDetermined:
                print("Location services: not determined")
                break
            case .restricted:
                print("Location services: restricted")
                break
            default:
                self.locationManager.startUpdatingLocation()
                if let location = locationManager.location {
                    self.centerMapOnLocation(location: location)
                }
                break
            }
        }
    }
    /* Touches Methods */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animateMyLocationButtonAppear()
    }
    /* Adds UIComponents to View */
    func addSubviews() {
        self.view.addSubview(self.map)
        self.view.addSubview(self.myLocationButton)
    }
    /* Sets UIComponent margins/dimensions programmatically */
    func initializeView() {
        // Map constraints
        self.map.heightAnchor.constraint(equalToConstant: self.view.bounds.height).isActive = true
        self.map.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        self.map.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.map.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        // MyLocation button constraints
        self.myLocationButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        self.myLocationButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        self.myLocationButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        self.myLocationButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -45).isActive = true
    }
    /* Map Component Animations */
    func animateMyLocationButtonDisappear() {
        UIView.animate(withDuration: self.GRADUAL) {
            self.myLocationButton.alpha = self.DISAPPEAR
        }
    }
    func animateMyLocationButtonAppear() {
        UIView.animate(withDuration: self.GRADUAL) {
            self.myLocationButton.alpha = self.APPEAR
        }
    }
    /* UI Manip */
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    /* Rounds UIView's corners */
    func roundCorners(view:UIView,corners:UIRectCorner) {
        let viewMaskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 10, height: 10))
        let shape         = CAShapeLayer()
        shape.path        = viewMaskPath.cgPath
        view.layer.mask   = shape
    }
    /* Rounds UIButton's corners */
    func roundButtonCorners(button:UIButton,corners:UIRectCorner) {
        let buttonMaskPath = UIBezierPath(roundedRect: view.bounds,
                                          byRoundingCorners: corners,
                                          cornerRadii: CGSize(width: button.bounds.width/3,
                                                              height: button.bounds.height/3))
        let shape         = CAShapeLayer()
        shape.path        = buttonMaskPath.cgPath
        button.layer.mask = shape
    }
}
