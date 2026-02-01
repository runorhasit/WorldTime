//
//  ContentView.swift
//  WorldTime
//
//  Created by Runor Jiroma on 26/12/2025.
//

import SwiftUI


struct CityTime: Identifiable, Equatable, Codable, Hashable {
    let id: UUID
    let city: String
    let timeZoneIdentifier: String
    
    init(id: UUID = UUID(), city: String, timeZoneIdentifier: String) {
        self.id = id
        self.city = city
        self.timeZoneIdentifier = timeZoneIdentifier
    }
    
    var timeZone: TimeZone {
       return TimeZone(identifier: timeZoneIdentifier) ?? .current
    }
    
    
}


enum CityListState {
    case empty
    case searching(query: String)
    case populated
}


struct ContentView: View {
    
    
    @State private var showAddSlot: Bool = false
    @State private var listState: CityListState = .empty
    @State private var searchQuery = ""
    @StateObject private var timeVM = TimeViewModel()
    @StateObject private var locationManager = LocationManager()
    
    @State private var searchResults: [CityTime] = []
    
    
    
    private var isSearching: Bool {
        if case .searching = listState { return true }
        return false
    }
    
    
    private func searchCities(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        let addedCityNames = cities.map { $0.city.lowercased() }
        
        searchResults = Array(CityDatabase.cities.filter {
            $0.city.lowercased().hasPrefix(query.lowercased()) &&
            !addedCityNames.contains($0.city.lowercased())
        }.prefix(1))
    }
    
    
    private var searchResultsHeight: CGFloat {
        let rowHeight: CGFloat = 45
        let maxHeight: CGFloat = 45
        let contentHeight = CGFloat(searchResults.count) * rowHeight
        return min(contentHeight, maxHeight)
    }
    
    
    @State private var cities: [CityTime] = []
    
    
    
    var body: some View {
        ZStack {
            
            Color (red: 52/255, green: 124/255, blue: 33/255 )
                .ignoresSafeArea()
                .onTapGesture {
                    listState = .empty
                    searchQuery = ""
                }
            //City List pinned from the top
            VStack () {
                
                // City List
                VStack(alignment: .leading, spacing: 0) {
                    
                    // Empty Search slot
                    if cities.isEmpty {
                        EmptySlot(
                            listState: $listState,
                            searchQuery: $searchQuery,
                            showAddSlot: $showAddSlot)
                    }
                    
                    
                    // City Row
                    ForEach(cities) { city in
                        VStack(spacing: 0) {
                            TimeRow(
                                city: city.city,
                                time: timeVM.timeString(for: city.timeZone),
                                note: timeVM.dayNote(for: city.timeZone)
                            )
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 6)
                            
                            DashedDivider()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [8,8]))
                                .frame(height: 1)
                                .foregroundColor(Color(red: 182/255, green: 255/255, blue: 163/255).opacity(0.48))
                            
                        }
                        .contextMenu {
                                Button(role: .destructive) {
                                    if let index = cities.firstIndex(where: { $0.id == city.id }) {
                                        cities.remove(at: index)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                    
                    // Case 2: cities exist but < 5 → EmptySlot is appended
                    if !cities.isEmpty && cities.count < 5 && showAddSlot {
                        EmptySlot(
                            listState: $listState,
                            searchQuery: $searchQuery,
                            showAddSlot: $showAddSlot)
                    }
                    
                    
                    // Search results-expand below the active slot
                    if case .searching = listState,
                       (cities.isEmpty || showAddSlot),
                       !searchResults.isEmpty {

                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color(red: 182/255, green: 255/255, blue: 163/255).opacity(0.48))
                                .frame(maxWidth: .infinity)
                                .frame(height: 1)

                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: 0) {
                                    ForEach(searchResults.prefix(1)) { result in
                                        Button {
                                            cities.append(result)
                                            listState = .populated
                                            searchQuery = ""
                                            showAddSlot = false
                                        } label: {
                                            VStack(spacing: 0) {
                                                HStack {
                                                    Text(result.city)
                                                        .font(.body)
                                                        .foregroundColor(.yellow)
                                                    Spacer()
                                                }
                                                .padding(.leading, 16)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 44)

                                                Rectangle()
                                                    .fill(Color(red: 182/255, green: 255/255, blue: 163/255).opacity(0.48))
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 1)
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(height: searchResultsHeight)
                        }
                        .background(Color(red: 40/255, green: 112/255, blue: 21/255))
                    }
                    
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                
                
                Spacer()
                
                }
                
                // Dial pinned from the bottom
                VStack() {
                    Spacer()
                        
                    // Dial
                    TimeDialView(timeVM: timeVM)
                        .padding(.bottom, 80)
                        .padding(.leading, 40)
                }
                .ignoresSafeArea(.keyboard)
                .opacity(cities.count >= 4 && showAddSlot && isSearching ? 0 : 1)
               
            
            // + Button - pinned bottom right
            if cities.count < 5 {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            if cities.count >= 1 {
                                    showAddSlot = true
                                    listState = .empty
                                    searchQuery = ""
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .light))
                                .foregroundColor(.black)
                                .frame(width: 48, height: 48)
                                .background(Color.yellow)
                                .clipShape(Circle())
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 260)
                    }
                }
                .ignoresSafeArea(.keyboard)
            }
            
        
        }
        .onAppear {
            
            // Load saved cities
            if let data = UserDefaults.standard.data(forKey: "savedCities") {
                let decoder = JSONDecoder()
                if let savedCities = try? decoder.decode([CityTime].self, from: data) {
                        cities = savedCities
                    }
                }
            
            // Only request location if no cities exist
            if cities.isEmpty {
                locationManager.requestPermission()
            }
        }
        
       .onChange(of: locationManager.userCity) { oldValue, newValue in
           // adds city when location detected
            if let city = newValue, cities.isEmpty {
                cities.append(city)
           }
        }
        
       .onChange(of: searchQuery) { oldValue, newValue in
           print("searchQuery changed to: \(newValue)")
           searchCities(query: newValue)
       }
        
       .onChange(of: cities) { oldValue, newValue in
           // saves cities whenever array changes
           let encoder = JSONEncoder()
           let data = try? encoder.encode(newValue)
           UserDefaults.standard.set(data, forKey: "savedCities")
       }
        
        
    }
        
    
    
    
    
    
    struct TimeRow: View {
        let city: String
        let time: String
        let note: String

        var body: some View {
            VStack(spacing: 6) {

                // HStack: text block + time
                HStack {

                    // Note + City block
                    VStack(alignment: .leading, spacing: 4) {
                        Text(note)
                            .textInputAutocapitalization(.words)
                            .font(.system(.footnote, weight: .semibold))
                            .foregroundColor(Color(red: 182/255, green: 255/255, blue: 163/255))

                        Text(city)
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.yellow)
                    }

                    Spacer() // auto gap

                    Text(time)
                        .font(.system(size: 60, weight: .semibold))
                        .foregroundColor(Color(red: 182/255, green: 255/255, blue: 163/255))
                }

            
            }
            .frame(maxWidth: .infinity)
            .frame(height: 66)
        }
    }

    
    
    
    struct DashedDivider: Shape {
        func path(in rect: CGRect) -> Path {
                var path = Path()
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: rect.width, y: 0))
                return path
            }
    }
    
    
}



















#Preview {
    ContentView()
}

