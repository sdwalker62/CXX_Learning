#include <iostream>

int main()
{
  std::cout << "Enter two numbers to be multiplied: " << std::endl;

  int v1 = 0, v2 = 0;

  std::cin >> v1;
  std::cin >> v2;

  std::cout << "The product of ";
  std::cout << v1;
  std::cout << " and ";
  std::cout << v2;
  std::cout << " is ";
  std::cout << v1 * v2 << "." << std::endl;
}