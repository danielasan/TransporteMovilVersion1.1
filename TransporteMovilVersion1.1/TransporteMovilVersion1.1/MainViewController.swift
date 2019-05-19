//
//  MainViewController.swift
//  TransporteMovilVersion1.1
//
//  Created by SSiOS on 5/14/19.
//  Copyright © 2019 SSiOS. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBOutlet weak var routesButon: UIButton!
    
    @IBOutlet weak var busButton: UIButton!
    
    @IBOutlet weak var routesTable: UITableView!
    
    @IBOutlet weak var pin: UIImageView!
    
    let urlReq = URL(string: "http://18.188.136.122:3000/api/paradasCercanas")
    
    
    func peticion(){
        
        let peticion = URLRequest(url:urlReq!)
        
        let tarea = URLSession.shared.dataTask(with: peticion)
        {
            datos,respuesta,error in
            if error != nil {
                print(error!)
                
            }else{
                do {
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    print(json)
                    
                } catch {
                    print("Error carnal")
                }
            }
        }
        tarea.resume()
        
    }
 
    
    let locationA = CLLocationManager()
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    var previousLocation: CLLocation?
    
    let geoCoder = CLGeocoder()
    var directionsArray: [MKDirections] = []
    
    var routes : [Route] = []
    var buttonActivated: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMyView()
    }
    
    func initMyView(){
        routesTable.isHidden = true
        routes = createArray()
        busButton.layer.cornerRadius = busButton.frame.size.height/2
        pin.isHidden = true
       
        checkLocationServices()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationA.delegate = self
        
    }
    
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTackingUserLocation()
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
      
        }
    }
    
    
    func startTackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
       
        
        let latitude =  mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getBaseUniversidadLocation(for mapView: MKMapView) -> CLLocation {
        let coordinate = CLLocationCoordinate2D(latitude: 19.306753, longitude: -99.172342)
        
        let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
        let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    func getBaseOyamelLocation(for mapView: MKMapView) -> CLLocation {
        let coordinate = CLLocationCoordinate2D(latitude: 19.306753, longitude: -99.265766)
        
        let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
        let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
        
        func getBaseZacatonLocation(for mapView: MKMapView) -> CLLocation {
            let coordinate = CLLocationCoordinate2D(latitude: 19.270345, longitude: -99.241546)
            
            let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
            let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        func getBaseCopilco87Location(for mapView: MKMapView) -> CLLocation {
            let coordinate = CLLocationCoordinate2D(latitude: 19.336125, longitude: -99.186463)
            
            let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
            let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        
        func getBaseTaxqueñaLocation(for mapView: MKMapView) -> CLLocation {
            let coordinate = CLLocationCoordinate2D(latitude: 19.343716, longitude: -99.143568)
            
            let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
            let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        func getBaseCopilco309Location(for mapView: MKMapView) -> CLLocation {
            let coordinate = CLLocationCoordinate2D(latitude: 19.337472, longitude: -99.186463)
            
            let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
            let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        
        func getBaseSanAngelLocation(for mapView: MKMapView) -> CLLocation {
            let coordinate = CLLocationCoordinate2D(latitude: 19.343625, longitude: -99.189889)
            
            let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
            let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        func getBaseLaBolaLocation(for mapView: MKMapView) -> CLLocation {
            let coordinate = CLLocationCoordinate2D(latitude: 19.314439, longitude: -99.167766)
            
            let latitude =  coordinate.latitude //mapView.centerCoordinate.latitude
            let longitude = coordinate.longitude//mapView.centerCoordinate.longitude
            
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        
 
        
    
    func getDirectionsUno() {
        guard let location = locationManager.location?.coordinate
            else {
            //TODO: Inform user we don't have their current location
            return
        }
        let first = getBaseOyamelLocation(for: mapView).coordinate
        //let request = createDirectionsRequest(from: location)
        let request = createDirectionsRequest1(from: first)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            //TODO: Handle error if needed
            guard let response = response else { return } //TODO: Show response not available in an alert
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    func getDirectionsDos() {
        guard let location = locationManager.location?.coordinate
            else {
                //TODO: Inform user we don't have their current location
                return
        }
        let first = getBaseZacatonLocation(for: mapView).coordinate
        //let request = createDirectionsRequest(from: location)
        let request = createDirectionsRequest2(from: first)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            //TODO: Handle error if needed
            guard let response = response else { return } //TODO: Show response not available in an alert
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    func getDirectionsTres() {
        guard let location = locationManager.location?.coordinate
            else {
                //TODO: Inform user we don't have their current location
                return
        }
        let first = getBaseTaxqueñaLocation(for: mapView).coordinate
        //let request = createDirectionsRequest(from: location)
        let request = createDirectionsRequest3(from: first)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            //TODO: Handle error if needed
            guard let response = response else { return } //TODO: Show response not available in an alert
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    func getDirectionsCuatro() {
        guard let location = locationManager.location?.coordinate
            else {
                //TODO: Inform user we don't have their current location
                return
        }
        let first = getBaseSanAngelLocation(for: mapView).coordinate
        //let request = createDirectionsRequest(from: location)
        let request = createDirectionsRequest4(from: first)
        let directions = MKDirections(request: request)
        resetMapView(withNew: directions)
        
        directions.calculate { [unowned self] (response, error) in
            //TODO: Handle error if needed
            guard let response = response else { return } //TODO: Show response not available in an alert
            
            for route in response.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }
    
    
    
    func getRoute1()->CLLocationCoordinate2D{
        
        var locationA: CLLocationCoordinate2D
      //  var locationB: CLLocationCoordinate2D
        
        locationA = CLLocationCoordinate2D(latitude: 195014263806, longitude: -992023694515)
        return locationA
    }
    func getRoute2()->CLLocationCoordinate2D{
        
        var locationA: CLLocationCoordinate2D
        //  var locationB: CLLocationCoordinate2D
        
        locationA = CLLocationCoordinate2D(latitude: 195014263806, longitude: -992023694515)
        return locationA
    }
    func getRoute3()->CLLocationCoordinate2D{
        
        var locationA: CLLocationCoordinate2D
        //  var locationB: CLLocationCoordinate2D
        
        locationA = CLLocationCoordinate2D(latitude: 195014263806, longitude: -992023694515)
        return locationA
    }
    func getRoute4()->CLLocationCoordinate2D{
        
        var locationA: CLLocationCoordinate2D
        //  var locationB: CLLocationCoordinate2D
        
        locationA = CLLocationCoordinate2D(latitude: 195014263806, longitude: -992023694515)
        return locationA
    }
    
    
    
    
    
    func createDirectionsRequest1(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate       = getBaseUniversidadLocation(for: mapView).coordinate//getCenterLocation(for: mapView).coordinate
        let startingLocation            = MKPlacemark(coordinate: coordinate)
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = false
        
        return request
    }
 
    func createDirectionsRequest2(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate       = getBaseCopilco87Location(for: mapView).coordinate//getCenterLocation(for: mapView).coordinate
        let startingLocation            = MKPlacemark(coordinate: coordinate)
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = false
        
        return request
    }
    func createDirectionsRequest3(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate       = getBaseCopilco309Location(for: mapView).coordinate//getCenterLocation(for: mapView).coordinate
        let startingLocation            = MKPlacemark(coordinate: coordinate)
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = false
        
        return request
    }
    func createDirectionsRequest4(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate       = getBaseLaBolaLocation(for: mapView).coordinate//getCenterLocation(for: mapView).coordinate
        let startingLocation            = MKPlacemark(coordinate: coordinate)
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .automobile
        request.requestsAlternateRoutes = false
        
        return request
    }
    
 
    
 /*
    func createDirectionsRequest(from coordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let destinationCoordinate       = getCenterLocation(for: mapView).coordinate
        
        let startingLocation            = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 195014263806, longitude: -992023694515))
        
        let destination                 = MKPlacemark(coordinate: destinationCoordinate)
        
        let request                     = MKDirections.Request()
        request.source                  = MKMapItem(placemark: startingLocation)
        request.destination             = MKMapItem(placemark: destination)
        request.transportType           = .transit
        request.requestsAlternateRoutes = false
        
        return request
    }
 */
    
    func resetMapView(withNew directions: MKDirections) {
        mapView.removeOverlays(mapView.overlays)
        directionsArray.append(directions)
        let _ = directionsArray.map { $0.cancel() }
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        buttonActivated = !buttonActivated
        activateTable()
        //getDirections()
    }
    
    @IBAction func busButtonTapped(_ sender: UIButton) {
        
    }
    
    
    func activateTable(){
        if buttonActivated{
            routesTable.isHidden = false
        }else{
            routesTable.isHidden = true
            
        }
    }
    
    
    func activateBus(){
        if buttonActivated{
            
        }else{
            
        }
    }
    
    func createArray()->[Route]{
        
        var array: [Route] = []
        let standardSchedule: String = "11:00 am - 11:00 pm"
        let standardRate: Double = 5.50
        let one = Route(name: "Ruta 309", color: .green, baseOne: "Taxqueña", baseTwo: "Metro Copilco", schedule: standardSchedule , rate: standardRate)
        
        let two = Route(name: "Ruta 397", color: .blue, baseOne: "San Ángel", baseTwo: "Mercado de la bola", schedule: standardSchedule, rate: standardRate)
        let three = Route(name: "Ruta 20", color: .red, baseOne: "Metro Copilco", baseTwo: "Cerro del Judío", schedule: standardSchedule, rate: standardRate)
        let four = Route(name: "Ruta 87", color: .yellow, baseOne: "Zacaton por bosques", baseTwo: "Metro copilco", schedule: standardSchedule, rate: standardRate)
        
        array.append(three)
        array.append(four)
        array.append(one)
        array.append(two)
        
        
        return array
    }
    
    }


extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}


extension MainViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.cancelGeocode()
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let _ = error {
                //TODO: Show alert informing the user
                return
            }
            
            guard let placemark = placemarks?.first else {
                //TODO: Show alert informing the user
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        renderer.strokeColor = .blue
        
        return renderer
    }
}

extension MainViewController : UITableViewDataSource, UITableViewDelegate{

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //Cuatroooo
        return 1
    }
    
    func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int{
        return routes.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        /*
        case (0, 0): getDirections()
        case (0, 1): getDirections()
        case (0, 2): getDirections()
        case (0, 3): getDirections()
        */
            
        case (0, 0): getDirectionsUno(); peticion()
        case (0, 1): getDirectionsDos(); peticion()
        case (0, 2): getDirectionsTres(); peticion()
        case (0, 3): getDirectionsCuatro(); peticion()
      
           
        default : break
        }
        
    }
    
    func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath )-> UITableViewCell{
        let route = routes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item") as! TableViewItem
        
        
        cell.name?.setTitle(route.name, for: .normal)
        cell.baseOne?.text = route.baseOne
        cell.baseTwo?.text = route.baseTwo
   
        return cell
        
    }
    
}
