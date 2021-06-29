
import Foundation


public class InvoiceModel
{
    weak var register: InOutRegister!
    init(for register: InOutRegister)
    {
        self.register = register
    }
   public  func printInvoice()
    {       
		guard register.outTime != nil && register.inTime != nil
		else
		{
			print("Issue in In  Out time")
			return
		}
        let calendar = Calendar(identifier: .gregorian)
        print("VehicleNumber:    \(register.vehicle.vehicleNumber)")
        print("VehicleName:    \(register.vehicle.vehicleName)")
        print("Driver:    \(register.driver)")
        var DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: register.inTime!)
        print("InTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)") 
        DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: register.outTime!)
        print("OutTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)")
        print("totalTime:    \(register.totalTime!) mins")
        print("TotalAmount : \(register.Amount!) rupees" )       
    }

}
