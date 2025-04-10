import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var locationCheckTimer: Timer?

    @Published var isAtBusStop: Bool = false
    @Published var userLocation: CLLocation?

//    // rumah gweh
//    let busStopCoordinate = CLLocation(latitude: -6.3593174070345535, longitude: 106.74084985162276)
    
    // Koordinat Halte The Breeze
    let busStopCoordinate = CLLocation(latitude: -6.301682861527709, longitude: 106.65324619049825)


    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        // Hanya ambil lokasi sekali-sekali, bukan realtime
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone

        // Mulai timer untuk cek lokasi setiap 3 menit
        startLocationCheckTimer()
    }

    //interval waktu
    private func startLocationCheckTimer() {
        locationCheckTimer = Timer.scheduledTimer(withTimeInterval: 0, repeats: true) { [weak self] _ in
            self?.locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLoc = locations.last else {
            print("⚠️ Tidak bisa mendapatkan lokasi user.")
            return
        }

        self.userLocation = userLoc

        let distance = userLoc.distance(from: busStopCoordinate)
        self.isAtBusStop = distance <= 100

        print("📍 Lokasi User: \(userLoc.coordinate.latitude), \(userLoc.coordinate.longitude)")
        print("🚏 Lokasi Halte: \(busStopCoordinate.coordinate.latitude), \(busStopCoordinate.coordinate.longitude)")
        print("📏 Jarak ke Halte: \(String(format: "%.2f", distance)) meter")
        print("✅ isAtBusStop: \(isAtBusStop)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ Gagal mendapatkan lokasi: \(error.localizedDescription)")
    }

    deinit {
        locationCheckTimer?.invalidate()
    }
}
