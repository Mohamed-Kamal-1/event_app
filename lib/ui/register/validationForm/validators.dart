final RegExp emailRegex = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
);

bool isValidEmail(String? email){
  if(email == null )return false;
  return emailRegex.hasMatch(email);
}
