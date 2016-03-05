#include <stdio.h>
#include <stdlib.h>

int factoral(int x) {
  if(x == 1) {
    return x;
  }
  return x * factoral(x - 1);
}

int main(int argc, char *argv[]) {
  int count;
  int factoral_start;
  int computed_factoral;

  if(argc > 1) {
    factoral_start = atoi(argv[1]);
  }

  computed_factoral = factoral(factoral_start);

  printf("Factoral of %d is %d\n", factoral_start, computed_factoral);

  return 0;
}
