//InvoiceModel.swift


import Foundation

//MARK:  Parking Area Model

class ParkingFloor
{
    var parkingFloor = [[Int]](repeating: [Int](repeating: 0, count: 4), count: 5)
    var vehicleCount = 0

    func parkonthisFloor(lengthRequired: Int , Id: Int) -> (row: Int, line: Int)?
    {
        for i in 0...1
        {
            let parkedarea = parkOnThisRow(row: i,lengthRequired: lengthRequired , Id: Id)
            if parkedarea != nil
            {
                return parkedarea
            }
        }
        return nil
    }
    func parkOnThisRow(row: Int , lengthRequired: Int , Id: Int) -> (row: Int, line: Int)?
    {
        
        var lengthAvailable = 0
        var start = 0
        var linenumber = 0
        for line in parkingFloor
        {
            if(line[row*2] == 0)
            {
                lengthAvailable += 1
            }
            else
            {
                lengthAvailable = 0
                start = linenumber + 1
            }
            if(lengthAvailable ==  lengthRequired)
            {
                for i in 0...lengthRequired - 1
                {
                    parkingFloor[start + i][row * 2 ] = Id
                    parkingFloor[start + i][(row * 2 ) + 1] = Id
                }
                return (row , start)
            }
            linenumber += 1
        }
        return nil
    }
}
var ParkingArea = [ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor()]

enum VehicleType: Int {

    case bycycle = 1  
    case bike
    case car
    case van
    case bus
}



public class VehicleDetails
{
    let vehicleName: String!
    let vehicleNumber: String!

    public init(vehicleNumber: String , vehicleName: String )
    {
        self.vehicleName = vehicleName
        self.vehicleNumber = vehicleNumber
    }
}
public class InvoiceModel
{
    weak var register: InOutRegister!
    init(for register: InOutRegister)
    {
        self.register = register
    }
   public  func printInvoice()
    {       
        let calendar = Calendar(identifier: .gregorian)
        print("VehicleNumber:    \(register.vehicle.vehicleNumber!)")
        print("VehicleName:    \(register.vehicle.vehicleName!)")
        print("Driver:    \(register.driver!)")
        var DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: register.inTime)
        print("InTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)") 
        DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: register.outTime)
        print("OutTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)")
        print("totalTime:    \(register.totalTime!) mins")
        print("TotalAmount : \(register.Amount!) rupees" )       
    }

}

class InOutRegister
{
    var RegisterId: String!
    var vehicle: VehicleDetails!
    var driver: String!
    var inTime: Date!
    var outTime: Date!
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
        self.totalTime = outTime.timeIntervalSince(inTime)
        self.Amount = totalTime! * 5.00
    }    
}


//Mark: viewModel



func park(vehicle: Int , id: Int) -> (floor: Int , Row: Int, line: Int)?
{
   var floorNo = 0 
   for floor in ParkingArea
   {
       if let slotassigned = floor.parkonthisFloor(lengthRequired: vehicle , Id: id)
       {
            floor.vehicleCount = floor.vehicleCount + vehicle                 
            return (floorNo , slotassigned.row , slotassigned.line)       
        }
        floorNo += 1
   }  
   return nil
}


func displacing(vehicle: InOutRegister)
{
    let parkingFloor = ParkingArea[vehicle.parkedSlot.floor]
    let start = vehicle.parkedSlot.line
    let requiredLength = vehicle.vehicleType.rawValue
    print("\(vehicle.vehicleType.rawValue)       \(vehicle.parkedSlot.line)   \(vehicle.parkedSlot.floor)")
    for i in 0...requiredLength - 1
         {
            parkingFloor.parkingFloor[start + i][vehicle.parkedSlot.Row * 2] = 0
            parkingFloor.parkingFloor[start + i][vehicle.parkedSlot.Row * 2 + 1] = 0
         }
}



func printslot(Floor requiredfloor: Int = 0 , all: Bool = false)
{
    let floor = ParkingArea[requiredfloor].parkingFloor
    print("\nFloor: \(requiredfloor)")
    for line in floor
    {
        for row in line
        {
            print(row,terminator:" ")
        }
        print("")
    }
}

func SearchWithID()
{
    
}





struct EntryExit
{    
    var register: [Int : InOutRegister] = [0 : InOutRegister()] 
    var WaitingList: [InOutRegister] = []
    var registerId: Int = 10001
    mutating func entry(vehicleType: VehicleType , vehicleNumber: String , vehicleName: String ,driver: String )
    {
        let InVehicle = InOutRegister(vehicleType: vehicleType , vehicleNumber: vehicleNumber  , vehicleName: vehicleName , driver: driver )
        self.register.updateValue(InVehicle, forKey:registerId )       
        InVehicle.parkedSlot = park(vehicle: vehicleType.rawValue , id: registerId)
        if InVehicle.parkedSlot != nil
        {
        print("VehicleParkedIn")
        print("Floor: \(InVehicle.parkedSlot.floor + 1) Row: 1 line: \(InVehicle.parkedSlot.line + 1)") 
        printslot(Floor: InVehicle.parkedSlot.floor)
        registerId = registerId + 1
        }
        else
        {
            if(WaitingList.count < 5)
            {
                WaitingList.append(InVehicle)
                print("No Slots But Added to WaitingList")
            }
            else
            {
            print("No slot Available")  
            }
        }
    }

    
    mutating func checkforWaitingList(outVehicleType : VehicleType)
    {
        
        for waitingVehicle in WaitingList
        {
            if(waitingVehicle.vehicleType.rawValue <= outVehicleType.rawValue)
            {
                waitingVehicle.parkedSlot = park(vehicle: waitingVehicle.vehicleType.rawValue , id: registerId)
                if waitingVehicle.parkedSlot != nil
                {
                    print("VehicleParkedIn")
                    print("Floor: \(waitingVehicle.parkedSlot.floor + 1) Row: 1 line: \(waitingVehicle.parkedSlot.line + 1)") 
                    printslot(Floor: waitingVehicle.parkedSlot.floor)
                    registerId = registerId + 1
                    print("Waiting List Vehicle  parked \n   VehicleName: \(waitingVehicle.vehicle.vehicleName!)")
                }
            }
        }
    }


    mutating func out(registerId: Int)
    {
        guard registerId > 10000 && registerId <= self.registerId else
        {
            print("Enter Valid Register ID ")
            return 
        }
        
        let outVehicle = register[registerId]!
        guard outVehicle.vehicleIn else {
            print("Your Vehicle is already out")
            return 
        }
        outVehicle.vehicleOut()
        outVehicle.invoice = InvoiceModel(for: outVehicle)
        outVehicle.invoice!.printInvoice()
        outVehicle.vehicleIn = false
        displacing(vehicle: outVehicle)
        printslot(Floor: outVehicle.parkedSlot.floor)
        checkforWaitingList(outVehicleType: outVehicle.vehicleType)
    }
}

