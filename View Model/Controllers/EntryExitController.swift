import Foundation

func SearchWithID()
{
    
}

struct EntryExitController
{
	let registerSingleton = RegisterModel.shared()

    func entry(vehicleType: VehicleType , vehicleNumber: String , vehicleName: String ,driver: String )
    {
        let InVehicle = InOutRegister(vehicleType: vehicleType , vehicleNumber: vehicleNumber  , vehicleName: vehicleName , driver: driver )
        self.registerSingleton.register.updateValue(InVehicle, forKey:registerSingleton.registerId )       
        InVehicle.parkedSlot = park(vehicle: vehicleType.rawValue , id: registerSingleton.registerId)
        if InVehicle.parkedSlot != nil
        {
        print("VehicleParkedIn")
        print("Floor: \(InVehicle.parkedSlot.floor + 1) Row: 1 line: \(InVehicle.parkedSlot.line + 1)") 
        printslot(Floor: InVehicle.parkedSlot.floor)
        registerSingleton.registerId = registerSingleton.registerId + 1
        }
        else
        {
            if(registerSingleton.WaitingList.count < 5)
            {
                registerSingleton.WaitingList.append(InVehicle)
                print("No Slots But Added to WaitingList")
				

            }
            else
            {
            print("No slot Available")  
            }
        }
    }

    
    func checkforWaitingList(outVehicleType : VehicleType)
    {
        var index=0
        for waitingVehicle in registerSingleton.WaitingList
        {
            if(waitingVehicle.vehicleType.rawValue <= outVehicleType.rawValue)
            {
                waitingVehicle.parkedSlot = park(vehicle: waitingVehicle.vehicleType.rawValue , id: registerSingleton.registerId)
                if waitingVehicle.parkedSlot != nil
                {
					waitingVehicle.inTime = Date()
                    print("VehicleParkedIn")
                    print("Floor: \(waitingVehicle.parkedSlot.floor + 1) Row: 1 line: \(waitingVehicle.parkedSlot.line + 1)") 
                    printslot(Floor: waitingVehicle.parkedSlot.floor)
					self.registerSingleton.register.updateValue(waitingVehicle, forKey:registerSingleton.registerId )  
                    registerSingleton.registerId = registerSingleton.registerId + 1
                    print("Waiting List Vehicle  parked \n   VehicleNumber: \(waitingVehicle.vehicle.vehicleNumber)")
					registerSingleton.WaitingList.remove(at: index)
					index -= 1
				}
            }
			index += 1
        }
    }


    func out(registerId: Int)
    {
        guard registerId > 10000 && registerId <= self.registerSingleton.registerId else
        {
            print("Enter Valid Register ID ")
            return 
        }
        
        let outVehicle = self.registerSingleton.register[registerId]!
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

