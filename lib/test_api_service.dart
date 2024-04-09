import 'api_service.dart'; // Update this with the correct path to your ApiService class



void main() async {
  // Instantiate your ApiService
  // var apiService = ApiService();

  // Assuming you have a method called getTotalClicks that takes a linkID
  // try {
  //   var totalClicks = await apiService.getTotalClicks(); // Use your actual link ID here
  //   print("Total Clicks: $totalClicks");
  // } catch (e) {
  //   print("Error fetching data: $e");
  // }
  try {
    final result = await ApiService().createNewLink();
    print('Path: ${result['path']}');
    print('Id: ${result['linkId']}');
  } catch (e) {
    print('Error creating link: $e');
  }
  
}
