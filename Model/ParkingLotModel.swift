class ParkingModel
{
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
   static var ParkingArea = [ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor()]

}