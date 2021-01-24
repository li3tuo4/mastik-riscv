#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

volatile char buffer[4096];

int main(int ac, char **av) {
  //default values from original mastic repo
  int rattle_1 = 800;
  int rattle_2 = 1800;
  int rattle_times = 64000;

  //if 2 arguments are given that are valid integers between 0 and 4096 use them instead of default values
  if (ac >= 3){
    int r_1 = atoi(av[1]);
    int r_2 = atoi(av[2]);


    if (r_1 >= 0 && r_1 <4096){
      rattle_1 = r_1;
    }
    if (r_2 >= 0 && r_2 <4096){
      rattle_2 = r_2;
    }

    if (ac == 4){
      int r_t = atoi(av[3]);
      if (r_t > 0){
        rattle_times = r_t;
      }
    }

  }
  fprintf(stderr, "using rattle values: %d and %d, %d times\n", rattle_1, rattle_2, rattle_times);

  for (;;) {
    for (int i = 0; i < rattle_times; i++)
      buffer[rattle_1] += i;
    for (int i = 0; i < rattle_times; i++)
      buffer[rattle_2] += i;
  }
}
