//
//  EmptySlot.swift
//  WorldTime
//
//  Created by Runor Jiroma on 01/01/2026.
//
import SwiftUI

struct EmptySlot: View {
    
    @Binding var listState: CityListState
    @Binding var searchQuery: String
    @Binding var showAddSlot: Bool
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(" ")
                    .font(.caption)
                
                if case .searching = listState {
                    ZStack(alignment: .leading) {
                        if searchQuery.isEmpty {
                            Text("Type city name...")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.yellow)
                        }
                        
                        TextField("", text: $searchQuery)
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(.yellow)
                            .focused($isFocused)
                    }
                } else {
                    Text("Type city name...")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.yellow)
                }
            }
            
            Spacer()
            
            if case .searching = listState {
                Button {
                    if searchQuery.isEmpty {
                        listState = .empty
                        showAddSlot = false
                    } else {
                        searchQuery = ""
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.yellow)
                }
                .padding(.trailing, 16)
            }
        }
        .padding(.leading, 16)
        .frame(width: 361, height: 66)
        .background(Color(red: 40/255, green: 112/255, blue: 21/255))
        .contentShape(Rectangle())
        .onTapGesture {
            listState = .searching(query: "")
            isFocused = true
        }
        
    }
}





#Preview {
    ZStack {
        Color(red: 52/255, green: 124/255, blue: 33/255)
            .ignoresSafeArea()
        
        VStack {
            EmptySlot(
                listState: .constant(.empty),
                searchQuery: .constant(""),
                showAddSlot: .constant(true)
            )
            
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 57)
    }
}
