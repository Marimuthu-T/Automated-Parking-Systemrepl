//InvoiceModel.swift


import Foundation

//MARK:  Parking Area Model

class InOutRegister
{
    var vehicle: VehicleDetails = VehicleDetails()
    var driver: String = "Not SET"
    var inTime: Date?
    var outTime: Date?
    var totalTime: TimeInterval?
    var Amount : Double?
    var vehicleIn: Bool = false
    var vehicleType: VehicleType = .car
    var invoice: InvoiceModel?
    var floorNo: Int?
    var parkedSlot: (floor: Int, Row: Int, line: Int)!

    init (){}

    init (vehicleType: VehicleType , vehicleNumber: String , vehicleName: String ,driver: String )
    {
        self.driver = driver
        self.vehicle = VehicleDetails(vehicleNumber: vehicleNumber , vehicleName: vehicleName )
        self.vehicleType = vehicleType
        self.inTime = Date()
        self.vehicleIn = true
    }

    
    public func vehicleOut()
    {
        if outTime == nil 
        {
            outTime = Date()
            
        self.totalTimeCalculator()
        }
        else {
            print("The vhechile is already Out")
        }
    }
     
    public func totalTimeCalculator()
    {
		guard outTime != nil && inTime != nil
		else{
			print("Error in in out time")
			return
		}
        self.totalTime = outTime!.timeIntervalSince(inTime!)
        self.Amount = totalTime! * 5.00
    }    
}


//Mark: viewModel
