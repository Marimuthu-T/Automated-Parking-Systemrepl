



func SearchWithID()
{
    
}





struct EntryExitController
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

