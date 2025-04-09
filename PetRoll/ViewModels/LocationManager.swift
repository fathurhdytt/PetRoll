import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private var locationCheckTimer: Timer?

    @Published var isAtBusStop: Bool = false
    @Published var userLocation: CLLocation?

//    // rumah gweh
//    let busStopCoordinate = CLLocation(latitude: -6.359047079248995, longitude: 106.7407852696751)
    
    // Koordinat Halte The Breeze tapi ini lagi pake koordinat ADA
    let busStopCoordinate = CLLocation(latitude: -6.302148, longitude: 106.652569)


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
        locationCheckTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
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
        self.isAtBusStop = distance <= 120

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
