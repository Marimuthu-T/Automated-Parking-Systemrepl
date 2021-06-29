
class RegisterModel
{
    var register: [Int : InOutRegister] = [0 : InOutRegister()] 
	var registerId: Int = 10001
    var WaitingList: [InOutRegister] = []
	private init()
	{

	}
	private static let registerSingleton: RegisterModel = {
			let registerSingleton = RegisterModel()
			return registerSingleton
		}()
	static func shared() -> RegisterModel
	{
		return registerSingleton		
	} 
}