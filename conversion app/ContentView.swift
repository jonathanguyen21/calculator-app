//
//  ContentView.swift
//  conversion app
//
//  Created by Jonathan Nguyen on 2/13/23.
//

import SwiftUI

struct ContentView: View {
    
    let euro = 1.0059
    @State var left_num = 0
    
    var body: some View {
        
        var right_num = Double(left_num) * euro
        VStack {
            // Layer 1 Conversion Boxes
            HStack {
                
                Spacer()
                
                var left_formatted:String = ""
                if type(of: left_num) == Int {
                    left_formatted = String(format: "%.2f", left_num)
                }
                else if type(of: left_num) == Double{
                    left_formatted = String(format: "%.3f", left_num)
                }
               
                Text("\(left_formatted)")
                    .padding(.horizontal, 50).padding(.vertical, 20).border(.black)
                    
                    
                Spacer()
                Image(systemName: "equal.circle").resizable()
                    .frame(width: 40, height: 40)
                Spacer()
                var right_formatted = String(format: "%.3f", right_num)
                Text("\(right_formatted)")
                    .padding(.horizontal, 50).padding(.vertical, 20).border(.black)
                Spacer()
            }
            
            // Layer 2 USD -> Euro
            
            HStack {
                Spacer()
                Text("USD")
                    .padding(.horizontal, 50).padding(.vertical, 20).border(.black)
                Spacer()
                Image(systemName: "arrow.right").resizable()
                    .frame(width: 40, height: 40)
                Spacer()
                Text("EURO")
                    .padding(.horizontal, 50).padding(.vertical, 20).border(.black)
                Spacer()
            }
            
            //Layer 3 Text
            
            Text("1 USD = 1.0059 EUR")
            
            // Layer 4 BUTTONS
            
            VStack {
                
                // numbers 7-9 and clear
                HStack {
                    
                    // 7 button
                    Button {
                        if left_num == 0 {
                            left_num += 7
                        }
                        else {
                            left_num = Int(String(left_num) + "7") ?? 0
                        }
                        
                    } label: {
                        Text("7")
                            .font(.largeTitle)
                    }
                    
                    // 8 button
                    Button {
                        if left_num == 0 {
                            left_num += 8
                        }
                        else {
                            left_num = Int(String(left_num) + "8") ?? 0
                        }
                        
                    } label: {
                        Text("8")
                            .font(.largeTitle)
                    }

                    // 9 button
                    Button {
                        if left_num == 0 {
                            left_num += 9
                        }
                        else {
                            left_num = Int(String(left_num) + "9") ?? 0
                        }
                        
                    } label: {
                        Text("9")
                            .font(.largeTitle)
                    }
                    
                    // Clear button
                    Button {
                        left_num = 0
                        
                    } label: {
                        Text("Clear")
                            .font(.largeTitle)
                    }
                }
                
                // numbers 4-6 and delete
                HStack {
                    
                    // 4 button
                    Button {
                        if left_num == 0 {
                            left_num += 4
                        }
                        else {
                            left_num = Int(String(left_num) + "4") ?? 0
                        }
                        
                    } label: {
                        Text("4")
                            .font(.largeTitle)
                    }
                    
                    // 5 button
                    Button {
                        if left_num == 0 {
                            left_num += 5
                        }
                        else {
                            left_num = Int(String(left_num) + "5") ?? 0
                        }
                        
                    } label: {
                        Text("5")
                            .font(.largeTitle)
                    }

                    // 6 button
                    Button {
                        if left_num == 0 {
                            left_num += 6
                        }
                        else {
                            left_num = Int(String(left_num) + "6") ?? 0
                        }
                        
                    } label: {
                        Text("6")
                            .font(.largeTitle)
                    }
                    
                    // Clear button
                    Button {
                        
                        
                    } label: {
                        Image(systemName: "delete.left")
                            
                            
                    }
                }
            }.border(.black)
            
        }
        .padding().border(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
