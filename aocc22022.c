#include <stdio.h>
#include <stdlib.h>
int you(int other, int outcome) {
    return outcome == 0 ? (other + 2) % 3 : outcome == 1 ? other : (other + 1) % 3;
}
int main() {
    FILE *input = fopen("aocc2202.txt", "r");
    char line[5];
    int totalPoints = 0;
    while (fgets(line, 5, input)) {
        int other = line[0] - 65;
        int outcome = line[2] - 88;
        int points = outcome * 3 + you(other, outcome) + 1;
        totalPoints += points;
    }
    printf("%d", totalPoints);
    return 0;
}
