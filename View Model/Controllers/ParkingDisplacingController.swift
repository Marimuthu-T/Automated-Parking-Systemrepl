
func park(vehicle: Int , id: Int) -> (floor: Int , Row: Int, line: Int)?
{
   var floorNo = 0 
   for floor in ParkingModel.ParkingArea
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
    let parkingFloor = ParkingModel.ParkingArea[vehicle.parkedSlot.floor]
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
    let floor = ParkingModel.ParkingArea[requiredfloor].parkingFloor
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