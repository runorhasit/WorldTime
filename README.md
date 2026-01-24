# WorldTime

A timezone scrubber app that lets you visualise time across cities with an interactive dial.


## Why a Dial?

Most timezone apps use static displays or linear sliders. But time is cyclical — so WorldTime uses a dial interaction that mirrors how we actually think about time. Rotating the dial scrubs through hours, and concepts like "yesterday" and "tomorrow" become intuitive as you cross midnight.

## Features

- Interactive dial for scrubbing time across all added cities
- Auto-detect user's city via location services
- Search and add up to 5 cities
- Visual indicators for day changes (Today, Yesterday, Tomorrow)
- Clean list layout for scanning times at a glance

## Architecture

WorldTime follows the MVVM pattern:

| Layer | Component | Responsibility |
|-------|-----------|----------------|
| Model | `CityTime` | Data structure for city and timezone |
| View | `ContentView`, `TimeRow`, `EmptySlot`, `TimeDialView` | UI rendering |
| ViewModel | `TimeViewModel` | Time logic and scrubbing state |
| Service | `LocationManager` | Location permission and reverse geocoding |

## Tech Stack

- **SwiftUI** — Declarative UI framework
- **CoreLocation** — Location services and geocoding
- **Combine** — Reactive state management via @Published
- **Foundation** — Date formatting and timezone handling

## Requirements

- iOS 17.0+
- Xcode 15.0+

## Getting Started

1. Clone the repository
   ```bash
   git clone https://github.com/runorhasit/WorldTime.git
   ```
2. Open `WorldTime.xcodeproj` in Xcode
3. Select a simulator or connected device
4. Build and run (⌘R)

## Future Improvements

### High Priority
- Persist cities between launches (UserDefaults or Core Data)
- Replace deprecated CLGeocoder with MapKit geocoding APIs
- Integrate real city search (MKLocalSearch or timezone API)

### Medium Priority
- Swipe to delete cities
- Drag to reorder cities
- Haptic feedback on dial interaction

### Low Priority
- Dark mode support
- Accessibility (VoiceOver, Dynamic Type)
- iPad and landscape layouts

## Case Study

Read the full design and development story:
[WorldTime: From Slider to Dial, Visualising Time the Way We Think About It](https://medium.com/@Orunor/worldtime-from-slider-to-dial-visualising-time-the-way-we-think-about-it-fd72700ccbc1)

## License

MIT License — see [LICENSE](LICENSE) for details.

## Author

Built by [Runor Jiroma](https://github.com/runorhasit) as a learning project to explore SwiftUI development.
