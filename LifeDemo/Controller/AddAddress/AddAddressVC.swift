//
//  AddAddressVC.swift
//  LifeDemo
//
//  Created by Khadim Hussain on 03/11/2021.
//

import UIKit
import GoogleMaps

enum GoogleAPIStatus :String {
    case OK             = "OK"
    case ZeroResults    = "ZERO_RESULTS"
    case APILimit       = "OVER_QUERY_LIMIT"
    case RequestDenied  = "REQUEST_DENIED"
    case InvalidRequest = "INVALID_REQUEST"
}

class AddAddressVC: UIViewController {

    @IBOutlet var addAddressVM: AddAddressVM!
    let yourApiKey = "AIzaSyAZ5WcLqU7vEeulY2naEAyuhd2uS2koAxY"
    
    var arrSearchResults: [locationData]?
    var isUpdateAddress = false
    var userAddress: Address?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addAddressVM.setupUI(isUpdateAddress: isUpdateAddress)
        self.addAddressVM.registerCell()
        self.addAddressVM.searchField.delegate = self
        self.addAddressVM.searchField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        if let address = userAddress {
   
            self.addAddressVM.updateUserAddress(address: address)
        }

    }
    
    override func viewDidLayoutSubviews() {
        
        self.googleMapsSetup()
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapZoom(_ sender: Any) {
        
        self.addAddressVM.googleMaps.animate(toLocation: CLLocationCoordinate2D(latitude: Double(self.addAddressVM.currLocationLat) ?? 0.0, longitude: Double(self.addAddressVM.currLocationLng) ?? 0.0))
    }
    
    @IBAction func didTapAddAddress(_ sender: Any) {

        if self.checkValidation() {
            
            if let address = userAddress {
                
                self.performWSToUpdateUserAddress(Name: self.addAddressVM.txtName.text ?? "", Phone: self.addAddressVM.txtHhone.text ?? "", FlatNo: self.addAddressVM.txtFlatno.text ?? "", Building: self.addAddressVM.txtBuilding.text ?? "", StreetAddress: self.addAddressVM.txtStreetaddress.text ?? "", Area: self.addAddressVM.txtArea.text ?? "", City: self.addAddressVM.txtCity.text ?? "", State: self.addAddressVM.txtState.text ?? "", Country: self.addAddressVM.txtCountry.text ?? "", Latitude: self.addAddressVM.currLocationLat , Longitude: self.addAddressVM.currLocationLng)
            }
            else {
                
                self.performWSToAddUserAddress(Name: self.addAddressVM.txtName.text ?? "", Phone: self.addAddressVM.txtHhone.text ?? "", FlatNo: self.addAddressVM.txtFlatno.text ?? "", Building: self.addAddressVM.txtBuilding.text ?? "", StreetAddress: self.addAddressVM.txtStreetaddress.text ?? "", Area: self.addAddressVM.txtArea.text ?? "", City: self.addAddressVM.txtCity.text ?? "", State: self.addAddressVM.txtState.text ?? "", Country: self.addAddressVM.txtCountry.text ?? "", Latitude: self.addAddressVM.currLocationLat , Longitude: self.addAddressVM.currLocationLng)
            }
        }
    }
    
    func addMakerOnMap(location: locationData) {
        
        self.addAddressVM.googleMaps.clear()
        
        self.addAddressVM.googleMaps.animate(toLocation: CLLocationCoordinate2D(latitude: location.geometry?.location?.lat ?? 0.0, longitude: location.geometry?.location?.lng ?? 0.0))
        
        let position = CLLocationCoordinate2D(latitude: location.geometry?.location?.lat ?? 0.0, longitude: location.geometry?.location?.lng ?? 0.0)
        let marker = GMSMarker(position: position)
        marker.title = location.name ?? ""
        marker.map = self.addAddressVM.googleMaps
    }
    
    func checkValidation() -> Bool {
        
        if self.addAddressVM.txtName.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgUserName)
            return false
        }
        else if self.addAddressVM.txtHhone.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgUserPhone)
            return false
        }
        else if self.addAddressVM.txtFlatno.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgAddressFlatNo)
            return false
        }
        else if self.addAddressVM.txtBuilding.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgAddressBuilding)
            return false
        }
        else if self.addAddressVM.txtStreetaddress.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgAddressStreet)
            return false
        }
        else if self.addAddressVM.txtArea.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgAddressArea)
            return false
        }
        else if self.addAddressVM.txtCity.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgAddressCity)
            return false
        }
        else if self.addAddressVM.txtState.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgAddressState)
            return false
        }
        else if self.addAddressVM.txtCountry.text == "" {
            
            SharedManager.shared.showAlertView(source: self, title: ApplicationAlertMessages.kAppAlert, message: ApplicationAlertMessages.kMsgAddressCountry)
            return false
        }
        else {
            
            return true
        }
    }
}

//MARK:- TextFiled delegates and datasoures
extension AddAddressVC: UITextFieldDelegate {
    
    @objc func textFieldDidChange(textField: UITextField){

        if let searchText = textField.text, !(searchText.isEmpty) {
  
            self.searchPlaceFromGoogle(search_place_string: searchText)
           // self.didTapSelectCancel(self)
            if  self.addAddressVM.viewMapSearch.isHidden {
                UIView.transition(with: self.addAddressVM.viewMapSearch, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.addAddressVM.viewMapSearch.isHidden = false
                })
            }
        }
        else {
            
            UIView.transition(with: self.addAddressVM.viewMapSearch, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.addAddressVM.viewMapSearch.isHidden = true
            })
            self.view.endEditing(true)
        }
    }
}

extension AddAddressVC:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 62
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSearchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCC") as! LocationCC
   
        if let arrLocation = self.arrSearchResults, arrLocation.count > indexPath.row {
   
            let Location = arrLocation[indexPath.row]
            cell.setupLocation(location: Location)
        }
        cell.selectionStyle = .none
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        self.view.endEditing(true)
        if let Location = self.arrSearchResults?[indexPath.row] {
 
            self.addAddressVM.txtArea.text = Location.name ?? ""
            self.addAddressVM.currLocationLat = "\(Location.geometry?.location?.lat ?? 0.0)"
            self.addAddressVM.currLocationLng = "\(Location.geometry?.location?.lng ?? 0.0)"
          
            self.addMakerOnMap(location:Location)
            self.getAddressFromLatLon(lat: Location.geometry?.location?.lat ?? 0.0, withLongitude: Location.geometry?.location?.lng ?? 0.0)
            
            UIView.transition(with: self.addAddressVM.viewMapSearch, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.addAddressVM.viewMapSearch.isHidden = true
            }, completion: { _ in

            })
        }
    }
}

extension AddAddressVC: CLLocationManagerDelegate, GMSMapViewDelegate  {
    
    func googleMapsSetup() {
        
        self.addAddressVM.locationManager.requestWhenInUseAuthorization()
        self.addAddressVM.locationManager.requestAlwaysAuthorization()
        self.addAddressVM.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.addAddressVM.locationManager.delegate = self
        self.addAddressVM.locationManager.startUpdatingLocation()
        self.addAddressVM.googleMaps.delegate = self
    }
    
    //Location Manager delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.first != nil else {
            return
        }
        
        self.addAddressVM.currLocationLat = "\(locations.first?.coordinate.latitude ?? 0.0)"
        self.addAddressVM.currLocationLng = "\(locations.first?.coordinate.longitude ?? 0.0)"
        
        let location = CLLocationCoordinate2D(latitude: locations.first?.coordinate.latitude ?? 0.0, longitude: locations.first?.coordinate.longitude ?? 0.0)
        if self.addAddressVM.isInitialised == false {
            
            self.initializeMapView(location: location)
        }
    }
    
    func initializeMapView(location: CLLocationCoordinate2D?) {

        guard let location = location else {
            return
        }
        if self.addAddressVM.currLocationLat == "0.0" || self.addAddressVM.currLocationLng == "0.0" {
            
            return
        }
        DispatchQueue.main.async {
            CATransaction.begin()
            CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
            CATransaction.setCompletionBlock {
                CATransaction.begin()
                CATransaction.setValue(1, forKey: kCATransactionAnimationDuration)
                self.addAddressVM.googleMaps.animate(toZoom: 14)
                CATransaction.setCompletionBlock {
                 
                }
                CATransaction.commit()
            }
            // your camera code goes here, example:
            self.addAddressVM.googleMaps.animate(with: GMSCameraUpdate.setTarget(location))
            CATransaction.commit()
        }
        
        self.addAddressVM.isInitialised = true
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
        // Display the map using the default location.
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            
            print("Location status is OK.")
            
            self.addAddressVM.locationManager.startUpdatingLocation()
        @unknown default: break
            
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.addAddressVM.locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

// MARK: - Google APIs Response
extension AddAddressVC {
  
    func searchPlaceFromGoogle(search_place_string : String) {
        
        let currLocation = "\(self.addAddressVM.currLocationLat) \(self.addAddressVM.currLocationLng)"
        var strGoogleApi = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(search_place_string)&location=\(currLocation)&key=\(yourApiKey)"
    
        strGoogleApi = strGoogleApi.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var urlRequest = URLRequest(url: URL(string: strGoogleApi)!)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, resopnse, error) in
       
            print(resopnse as Any)
            print(data as Any)
            print(error as Any)
            if error == nil {
        
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let root = try decoder.decode(locationSearchDC.self, from: data!)
            
                    if let results = root.results {
                        
                        self.arrSearchResults?.removeAll()
                        self.arrSearchResults = results
                        
                        DispatchQueue.main.async {
                            
                            UIView.transition(with: self.addAddressVM.tableView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.addAddressVM.tableView.reloadData() })
                        }
                    }
                } catch {
                    print(error)
                }
            } else {
                //we have error connection google api
            }
        }
        task.resume()
    }
    
    func getAddressFromLatLon(lat: Double, withLongitude lon: Double) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()

        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    {(placemarks, error) in
            if (error != nil)
            {
            }
            
            if placemarks != nil
            {
                
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    
                    let pm = placemarks![0]
                    print(pm.country ?? "")
                    print(pm.locality ?? "")
                    DispatchQueue.main.async {
                        
                        self.addAddressVM.txtCountry.text = pm.country ?? ""
                        self.addAddressVM.txtCity.text = pm.locality ?? ""
                        self.addAddressVM.txtState.text = pm.administrativeArea ?? ""
                        self.addAddressVM.txtStreetaddress.text = pm.thoroughfare ?? ""
                        
                    }
                    
                }
            }
        })
        
    }
}
//MARK:- WebServices
extension AddAddressVC {
    
    func performWSToAddUserAddress(Name:String,Phone:String, FlatNo: String, Building: String, StreetAddress: String, Area: String, City: String, State: String, Country: String, Latitude: String, Longitude: String) {

        let params = [
            "name": Name,
            "phone": Phone,
            "flatno": FlatNo,
            "building": Building,
            "streetaddress": StreetAddress,
            "area": Area,
            "city": City,
            "state": State,
            "country": Country,
            "latitude": Latitude,
            "longitude": Longitude
            
        ]
        WebServices.URLResponse("Address_Update", method: .post, parameters: params, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(userAddressDC.self, from: response)
                
                if let message = FULLResponse.messages, message == "Success" {
                    
                    self.didTapBack(self)
                }
            }catch let jsonerror{
                
                print("error parsing json objects",jsonerror)
            }
        }){ (error) in
        }
    }
    
    func performWSToUpdateUserAddress(Name:String,Phone:String, FlatNo: String, Building: String, StreetAddress: String, Area: String, City: String, State: String, Country: String, Latitude: String, Longitude: String) {

        let params = [
            "id": userAddress?.id ?? "0",
            "name": Name,
            "phone": Phone,
            "flatno": FlatNo,
            "building": Building,
            "streetaddress": StreetAddress,
            "area": Area,
            "city": City,
            "state": State,
            "country": Country,
            "latitude": Latitude,
            "longitude": Longitude
            
        ]
        WebServices.URLResponse("Address_Update", method: .post, parameters: params, headers: nil, withSuccess: { (response) in
            
            do{
                let FULLResponse = try
                    JSONDecoder().decode(userAddressDC.self, from: response)
                
                if let message = FULLResponse.messages, message == "Success" {
                    
                    self.didTapBack(self)
                }
            }catch let jsonerror{
                
                print("error parsing json objects",jsonerror)
            }
        }){ (error) in
        }
    }
}
