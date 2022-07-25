import Combine
import GoogleMaps
import UIKit
import SwiftUI


let startPoint = CLLocationCoordinate2D(latitude: 53.56950079760791, longitude: 9.913739879038134)
let cornerA = GMSGeometryOffset(startPoint, 500, 315)
let cornerB = GMSGeometryOffset(startPoint, 500, 135)


final class MapViewController: UIViewController {
  private let mapView: GMSMapView
  private let groundOverlay: GMSGroundOverlay

  private var renderedImageCount = 0
  private var subscriptions = Set<AnyCancellable>()

  init() {
    let cameraPosition = GMSCameraPosition(target: startPoint, zoom: 15.0)
    self.mapView = GMSMapView(frame: .init(), camera: cameraPosition)

    self.groundOverlay = GMSGroundOverlay(bounds: .init(coordinate: cornerA, coordinate: cornerB), icon: nil)
    groundOverlay.map = mapView

    super.init(nibName: nil, bundle: nil)

    setupMapView()
    setupPublishers()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupMapView() {
    view.addSubview(mapView)

    mapView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      mapView.widthAnchor.constraint(equalTo: view.widthAnchor),
      mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
    ])
  }

  private func setupPublishers() {
    Timer.publish(every: 1, on: RunLoop.main, in: .default)
      .autoconnect()
      .sink { [weak self] _ in
        guard let self = self else { return }
        let bounds = CGRect(origin: .zero, size: .init(width: .random(in: 1500...2000), height: .random(in: 1500...2000)))
        print("Rendering image no. \(self.renderedImageCount + 1) with a size of \(Int(bounds.width)) x \(Int(bounds.height))")
        self.groundOverlay.icon = Self.renderImage(in: bounds)
        self.renderedImageCount += 1
      }
      .store(in: &subscriptions)
  }

  private static func renderImage(in bounds: CGRect) -> UIImage {
    let renderer = UIGraphicsImageRenderer(bounds: bounds)
    let image = renderer.image { context in
      UIColor.purple.setStroke()
      context.stroke(renderer.format.bounds)
    }
    return image
  }
}


struct MapView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> MapViewController {
    MapViewController()
  }

  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
