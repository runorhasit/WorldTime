//
//  TimeDialView.swift
//  WorldTime
//
//  Created by Runor Jiroma on 27/12/2025.
//

import SwiftUI

struct TimeDialView: View {
    
    @ObservedObject var timeVM: TimeViewModel
    
    @State private var lastDragAngle: Double?
    @State private var accumulatedRotation: Double = 0
    
    
    private enum Dial {
        static let outerSize: CGFloat = 217
        static let innerSize: CGFloat = 163
        static let pointerInset: CGFloat = 20
    }
    
    
    struct DialPointer: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()

            let midX = rect.midX
            let midY = rect.midY

            path.move(to: CGPoint(x: midX, y: midY - 6))
            path.addLine(to: CGPoint(x: midX - 6, y: midY + 6))
            path.addLine(to: CGPoint(x: midX + 6, y: midY + 6))
            path.closeSubpath()

            return path
        }
    }


    
    var body: some View {
        
        let controlRadius = Dial.innerSize / 2
        
        ZStack {
            
            ZStack {
                // Outer yellow ring
                Circle()
                    .foregroundStyle(.yellow)
                    .frame(width: Dial.outerSize, height: Dial.outerSize)
                
                // 12 large ticks
                ForEach(0..<12) { index in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 1, height: 20)
                        .offset(y: -(Dial.outerSize / 2 - 10))
                        .rotationEffect(.degrees(Double(index) * 30))
                }
            }
        
            ZStack {
                
                ZStack {
                    // Inner blurred ring
                    Circle()
                        .foregroundStyle(Color(red: 52/255, green: 124/255, blue: 33/255))
                        .frame(width: Dial.innerSize, height: Dial.innerSize)
                        .shadow(color: Color(red: 52/255, green: 124/255, blue: 33/255).opacity(0.15),
                            radius: 12,
                            x: -4,
                            y: 0
                        )
                        .shadow(color: Color(red: 52/255, green: 124/255, blue: 33/255).opacity(0.15),
                            radius: 12,
                            x: 0,
                            y: -4
                        )
                        .shadow(color: Color(red: 52/255, green: 124/255, blue: 33/255).opacity(0.15),
                            radius: 12,
                            x: 4,
                            y: 0
                        )
                        .shadow(color: Color(red: 52/255, green: 124/255, blue: 33/255).opacity(0.15),
                            radius: 12,
                            x: 0,
                            y: 4
                        )
                    
                    Circle()
                        .foregroundStyle(Color(red: 52/255, green: 124/255, blue: 33/255))
                        .frame(width: Dial.innerSize, height: Dial.innerSize)
                    
                    
                    // Pointer
                    DialPointer()
                        .fill(Color.black)
                        .frame(width: 12, height: 12)
                        .offset(y: -controlRadius + Dial.pointerInset)
                }
                .rotationEffect(.degrees(accumulatedRotation))
                .animation(
                    .interactiveSpring(response: 0.25, dampingFraction: 0.9),
                    value: accumulatedRotation
                )
                
                
                // 60 fine ticks
                ForEach(0..<60) { index in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 1, height: 8)
                        .offset(y: -(Dial.innerSize / 2 - 4))
                        .rotationEffect(.degrees(Double(index) * 6))
                }
                    
            }
            
        }
        .frame(width: Dial.outerSize, height: Dial.outerSize)
        .gesture(dragGesture)
    }
    
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let angle = angleFromDrag(value.location)

                if let last = lastDragAngle {
                    var delta = angle - last

                    // Handle crossing 0/360 cleanly
                    if delta > 180 { delta -= 360 }
                    if delta < -180 { delta += 360 }

                    accumulatedRotation += delta
                    timeVM.scrub(byDegrees: delta)
                }

                lastDragAngle = angle
            }
            .onEnded { _ in
                lastDragAngle = nil
            }
    }
    
    private func angleFromDrag(_ location: CGPoint) -> Double {
        let center = Dial.outerSize / 2
        let dx = location.x - center
        let dy = center - location.y
        return atan2(dx, dy) * 180 / .pi
    }
    
}


#Preview {
    TimeDialView(timeVM: TimeViewModel())
}
