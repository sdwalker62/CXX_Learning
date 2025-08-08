#include <iostream>

int main()
{
  std::cout << "Enter integers to be summed:" << std::endl;

  int sum = 0, v;
  while (std::cin >> v)
  {
    sum += v;
  }
  std::cout << "The sum is " << sum << std::endl;

  return 0;
}