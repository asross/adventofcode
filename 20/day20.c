#include<stdio.h>
#include<stdlib.h>

int main() {
  int min_presents = 36000000;
  int max_houses = 1000000;
  int houses[max_houses];
  for (int elf = 1; elf < max_houses; elf += 1) {
    for (int house = elf; house < max_houses; house += elf) {
      houses[house] += elf * 10;
    }
  }
  for (int i = 0; i < max_houses; i += 1) {
    if (houses[i] >= min_presents) {
      printf("Part 1: %d\n", i);
      break;
    }
  }

  int houses2[max_houses];
  for (int elf = 1; elf < max_houses; elf += 1) {
    for (int house = elf; (house < max_houses && house <= 50 * elf); house += elf) {
      houses2[house] += elf * 11;
    }
  }
  for (int i = 0; i < max_houses; i += 1) {
    if (houses2[i] >= min_presents) {
      printf("Part 2: %d\n", i);
      break;
    }
  }
}
