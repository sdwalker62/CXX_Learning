#include <iostream>

int main()
{
  std::cout << "Enter two integers" << std::endl;
  int v1, v2;
  std::cin >> v1;
  std::cin >> v2;
  if (v1 == v2)
  {
    std::cout << v1 << std::endl;
    return 0;
  }
  int lb, ub;
  if (v1 > v2)
  {
    lb = v2;
    ub = v1;
  }
  else
  {
    lb = v1;
    ub = v2;
  }
  while (ub >= lb)
  {
    std::cout << ub << std::endl;
    --ub;
  }
  return 0;
}